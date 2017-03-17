 /*****************************************
 * Thermistor between 3.3v and PIN9
 * NTC Thermsistor between PIN9 and PIN8
 * 
 * To read the value from the NTC:
 * 1) Drive Pin8 LOW
 * 2) Read Pin9
 * 3) Drive Pin8 HIGH
 * 
 * Current will only flow when Pin8 is LOW,
 * which is great for batteries
 ******************************************/
 
 // blink codes
 // http://electricimp.com/docs/troubleshooting/blinkup/
 
 class HoneyWellHIH8000Sensor {
 //HIH8120-021-001 without filter,non-condensing
 //HoneyWell recommends a .22uF cap between pins 1 (Vss/GND) and 2 (Vdd/Supply)
 // and a 2.2k resister between pin 3 (SCL/Clock) and Supply
 // and a 2.2k resister between pin 4 (SDA/Data) and Supply
 // From their i2c doc: 
 //The output stages of the devices connected to the bus are designed around open collector architecture.
// Because of this, pull-up resistors to +VDD must be provided on the bus
//Both SDA and SCL are bidirectional lines, and it is important to system performance to match the capacitive loads on both lines to ensure reliable edge transitions at 400 kHz clock speeds.

// HIH8000 Commands:
// MR (Measurement Request): WRITE bit (0) returns ACK.
// DF: Data Fetch): READ bit (1) returns 4 bytes: 
// [Byte1: 0-1: status, 2-7 humidity. Byte 2: 0-7 humidity. Byte 3: 0-7 temperature. Byte 4: 0-5 temperature, 6-7 ignore]
// Detecting whether data is ready to be fetched can be handled
// by testing the status bits in the fetched data

// the measurement cycle is typically 36.65ms for humidity and temp
// humidity count represents a 14bit percentage between 0% RH and 100%RH
// the imp itself is 32 bit, so no overflow is expected during conversion

_i2c = null;
_addr = null;
static HIH8000_I2C_ADDRESS = 0x4F;
static SENSOR_MAX_HUMIDITY_COUNT=16382; //(2^14)-2;
static SENSOR_MAX_TEMP_COUNT = 16382;
//static START_TEMP = "\xE3"; //"\xF3";
//static START_HUMIDITY = "\xF5";


constructor(i2c, address) {
_i2c = i2c;
_addr = address;
}
function getTemperature() {
    //TODO: configure device with resolution
    
    local writeResult = _i2c.write(_addr, "\x00");
    server.log(format("write result: %x", writeResult));
    if(writeResult != 0) {
        server.log("could not write to i2c unit");
        return 10;
    }
    local readBytes = _i2c.read(_addr, "", 4);
    local status = readBytes[0] & 0xC0;
    
    local humidity = 0;
    local maxTries = 20;
    local tries = 1;
    while(status != 0 && ++tries %maxTries != 0) {
        server.log("sensor not ready");
        if(status == 0xC0) { // 11: diagnostic mode
            
            server.log("diagnostic mode");
        } else if(status == 0x40) { // 01: stale data - do not use
            server.log("stale data");
        } else if(status == 0x80) { // aka 256, aka 10xxxxxx: command mode - should never happen
            
            server.log("command mode");
        }
        imp.sleep(1);
        readBytes = _i2c.read(_addr, "", 4);
        status = readBytes[0] & 0xC0;
    }
    
    local humidityCount = readBytes[0] << 8 | readBytes[1];
    
    local humidityRatio = humidityCount.tofloat()/SENSOR_MAX_HUMIDITY_COUNT;
    local humidityPercent = 100*humidityRatio;
    server.log(format("got reading: %f",humidityPercent));
    
    local temperatureCount = readBytes[2] << 6 | readBytes[3] >>2;;
    //if(temperatureCount & 0x2000) {
    //     temperatureCount = -((~temperatureCount & 0x3FFF) + 1);
    //}
    local tempRatio =temperatureCount.tofloat()/SENSOR_MAX_TEMP_COUNT;
    local temp = tempRatio*165-40;
    server.log(format("got i2c count: %i. normalized, 40C - 125C temp: %f", temperatureCount, temp));
    return 10.0;
    
} // end getTemperature function
} // end class


// Setup our hardware
NTC <- hardware.pin9;
NTC_Read_Enable <- hardware.pin8;
NTC_Read_Enable.configure(DIGITAL_OUT_OD);
NTC_Read_Enable.write(1);
NTC.configure(ANALOG_IN);

PHOTO <- hardware.pin5;
PHOTO.configure(ANALOG_IN);

globalMeasurementCount <- 0;
//contiguousOpenMeasurements -< 0;
//openBoxThreshold -< 3;

//imp.configure("Living Room TempBug", [], []);

imp.setpowersave(true);

// configure i2c bus
hardware.i2c89.configure(CLOCK_SPEED_100_KHZ); //10, 50, 100, 400

const b_therm = 3988;
const t0_therm = 298.15;

local boxIsOpen = 0;
// create TempSensor object
imp.sleep(4);
sensor <- HoneyWellHIH8000Sensor(hardware.i2c89, 0x4F);


function round(x, y) {
    return (x.tofloat()/y+(x>0?0.5:-0.5)).tointeger()*y
}

function getMaxVoltage()
{
    local v_high  = 0;
    for(local i = 0; i < 10; i++){
        imp.sleep(0.01);
        v_high += hardware.voltage();
    }
    v_high = v_high / 10.0;
    return v_high;
}


function getThermistorTemperature() {
    local v_high = getMaxVoltage();
    
    NTC_Read_Enable.write(0);
    
    local val = 0;
    for (local i = 0; i < 10; i++) {
        imp.sleep(0.01);
        val += NTC.read();
    }
    val = val/10;    

    NTC_Read_Enable.write(1);

    local v_therm = v_high * val / 65535.0;
    local r_therm = 10000.0 / ( (v_high / v_therm) - 1);
    local ln_therm = math.log(10000.0 / r_therm);
    local t_therm = (t0_therm * b_therm) / (b_therm - t0_therm * ln_therm) - 273.15;
    
    return round(t_therm, 0.5);
}

function SendToXively()
{
    local temp = sensor.getTemperature();
    server.log(format("temperature %f degrees C", temp));
    agent.send("SendToXively", {id = "Temperature", value = temp});
    
    //server.sleepfor(10);   // dont use sleep! use onidle. 
}
function notifyBoxIsOpen() {
    server.log("box is open");
}
function measurePhotoSensor() {
    local photoValue = hardware.lightlevel();
    server.log(format("photo %f", photoValue));
    if(photoValue > 18000) {
        notifyBoxIsOpen();
        //boxIsOpen = 1;
    }else{
        //boxIsOepn = 0;
    }
}
function measureAllSensors() {
    measurePhotoSensor();
    
    
    if(globalMeasurementCount % 1 == 0) {
        
        SendToXively();
        //local temp = sensor.getTemperature();
    
    
        //server.log(format("temperature %fC", temp));
        //agent.send("SendToXively", {id = "Temperature", value = temp});
    }
    globalMeasurementCount++;
    imp.wakeup(1, measureAllSensors);
    //server.sleepfor(1);   // 15 minutes
}
//SendToXively();
measureAllSensors();


