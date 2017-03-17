//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import "DQBayTekRequestProtocol.h"


@interface DQBayTekRequestProtocol ()
@end

#define WRITE_PROP      @"stx"
#define READ_PROP       @"srx"

@implementation DQBayTekRequestProtocol

#pragma mark - Private Methods

- (BOOL) attachToDQObject:(DQObject*)dqobject{
    
    if([dqobject.serialNumber isEqualToString:_theDQuidIOSerial]){
        _dqobject = dqobject;
        [self connect];
        return YES;
    }
    
    return NO;
}

#pragma mark - Public methods

-(id) initWithMachineID:(Byte)machineID andDQuidIOSerialNumber:(NSString*) serialNumber andResponseDelegate:(id<DQBayTekResponseDelegate>)aResponseDelegate {
    self = [super initWithMachineID:machineID andResponseDelegate:aResponseDelegate];
    if (self) {
        _theDQuidIOSerial = serialNumber;
    }
    return self;
}

- (BOOL) connect{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewObjectDiscovered:) name:@"onNewObjectDiscovered" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDQObjectInRange:) name:@"onDQObjectInRange" object:nil];
    
    if(_dqobject != nil){
        [_dqobject dqConnect];
        [_dqobject setDelegate:self];
        return YES;
    }
    
    [DQMANAGER dqDiscover];
    return NO;
}


- (void) disconnect{
    if(_dqobject != nil)
        [_dqobject dqDisconnect];
}

-(BOOL) getMachineID {
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_MACHINE_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getMajGameVer {
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_MAJ_GAME_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getMinGameVer {
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_MIN_GAME_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHSubminGameVer {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_PH_SMIN_GAME_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getMajAuxVer {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_AUX_MAJ_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getMinAuxVer {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_AUX_MIN_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHMajAuxVer {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_PH_AUX_MAJ_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHMinAuxVer {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_VER_AND_ID andPayload:PL_GET_PH_AUX_MIN_VER_ID];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) playSound {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_PLAY_SOUND];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getLastScoreLSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_LAST_SCORE andPayload:PL_LAST_SCORE_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getLastScoreMSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_LAST_SCORE andPayload:PL_LAST_SCORE_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) setLightsWithCodeAsNSNumber:(NSNumber*)lightCode {
    return [self setLightsWithCode:(Byte)[lightCode intValue]];
}

-(BOOL) setLightsWithCode:(Byte)lightCode {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_SET_LIGHTS andPayload:lightCode];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getGameMode {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_GAME_MODE];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) toggleInputWithBitkaskAsNSNumber:(NSNumber*)bitmask {
    return [self toggleInputWithBitkask:(Byte)[bitmask intValue]];
}

-(BOOL) toggleInputWithBitkask:(Byte)inputBitmask {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_TOGGLE_INPUT andPayload:inputBitmask];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) addCreditsAsNSNumber:(NSNumber*)noOfCredits {
    return [self addCredits:(Byte)[noOfCredits intValue]];
}

-(BOOL) addCredits:(Byte)noOfCredits {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_ADD_CREDITS andPayload:noOfCredits];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) clearAllCredits {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_CLEAR_ALL_CREDITS];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) dispenseTicketsAsNSNumber:(NSNumber*)noOfTickets {
    return [self dispenseTickets:(Byte)[noOfTickets intValue]];
}

-(BOOL) dispenseTickets:(Byte)noOfTickets {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_DISPENSE_TICKETS andPayload:noOfTickets];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) phAddTicketsAsNSNumber:(NSNumber*)noOfTickets {
    return [self phAddTickets:(Byte)[noOfTickets intValue]];
}

-(BOOL) phAddTickets:(Byte)noOfTickets {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_ADD_TICKETS andPayload:noOfTickets];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getNoOfPlayedGamesLSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_NO_OF_PLAYED_GAMES_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getNoOfPlayedGamesMSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_NO_OF_PLAYED_GAMES_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getNoOfDispensedTicketsLSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_NO_OF_DISP_TICKETS_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getNoOfDispensedTicketsMSB {
    if (theMachineID == PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_NO_OF_DISP_TICKETS_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getFBCurrentDailyHighScore {
    if (theMachineID != FLAPPY_BIRD) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_FB_CURR_DAILY_HIGHSCORE];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalAddedTicketsLSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_ADDED_TICKETS_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalAddedTicketsMLSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_ADDED_TICKETS_MLSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalAddedTicketsMSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_ADDED_TICKETS_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalRedeemedTicketsLSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_REDEEMED_TICKETS_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalRedeemedTicketsMLSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_REDEEMED_TICKETS_MLSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalRedeemedTicketsMSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_REDEEMED_TICKETS_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalPrintedTicketsMSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_PRINTED_TICKETS_MSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHTotalPrintedTicketsLSB {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_MACHINE_STATS andPayload:PL_PH_TOT_PRINTED_TICKETS_LSB];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}

-(BOOL) getPHNumberOfVendSucceededForLocationAsNSNumber:(NSNumber*)loc {
    return [self getPHNumberOfVendSucceededForLocation:(Byte)[loc intValue]];
}

-(BOOL) getPHNumberOfVendSucceededForLocation:(Byte)location  {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_PH_MACHINE_STATS_1 andPayload:location];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
    
}

-(BOOL) getPHNumberOfVendFailureForLocationAsNSNumber:(NSNumber*)loc {
    return [self getPHNumberOfVendFailureForLocation:(Byte)[loc intValue]];
}

-(BOOL) getPHNumberOfVendFailureForLocation:(Byte)location  {
    if (theMachineID != PRIZE_HUB) return NO;
    NSData* packet = [self newRequestPacketWithCommand:ID_PH_MACHINE_STATS_2 andPayload:location];
    if (packet == nil) return NO;
    if (![_dqobject.propertiesByName.allKeys containsObject:WRITE_PROP]) return NO;
    [_dqobject dqWriteRawData:packet toProperty:WRITE_PROP];
    return YES;
}


#pragma mark - DQObjectDelegateProtocol Delegate

- (void) onConnectionEstablished{
    [self setConnected:YES];
    
    for(DQProperty *property in [_dqobject.propertiesByName allValues]){
        if(property.isReadable)
            [_dqobject dqReadProperty:property.name subscribe:YES];
    }
    [theResponseDelegate onConnectionEstablished];
    [self getMachineID];
    
}

- (void) onConnectionFailed{
    NSLog(@"onConnectionFailed");
    [self setConnected:NO];
}


- (void) onDisconnection{
    [theResponseDelegate onDisconnection];
    [self setConnected:NO];
}


- (void) onErrorOccurred:(NSError*)error{
    NSLog(@"onErrorOccurred: %@", [error localizedDescription]);
}


#pragma mark - DQuid APIs Notifications

- (void) onNewObjectDiscovered:(NSNotification*)notification{
    DQObject* object = notification.userInfo.allValues[0];
    
    if(_dqobject == nil)
        [self attachToDQObject:object];
    
}

- (void) onDQObjectInRange:(NSNotification*)notification{
    [DQMANAGER dqDiscover];
}

- (void) onProperty:(DQProperty*)property receivedData:(DQData*)data{
    if([data.name isEqualToString:READ_PROP]){
        [self parsePacket:[data rawValue]];
        return;
    }
}

@end
