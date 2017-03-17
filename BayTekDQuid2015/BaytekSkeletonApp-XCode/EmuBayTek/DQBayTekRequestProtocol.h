//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

/**
 * CHANGEME if you need to connect to another DQuidIO.
 * Serial number is always composed by 16 digits
 */
//#define DQUIDIO_SERIAL_NUMBER @"0000000000000115"  // Flappy Bird  116 piano 117 Prize Hub
#define DQUIDIO_SERIAL_NUMBER @"0000000000000116"  // Flappy Bird  116 piano 117 Prize Hub
//#define DQUIDIO_SERIAL_NUMBER @"0000000000000117"  // Flappy Bird  116 piano 117 Prize Hub

#import <Foundation/Foundation.h>
#import "BayTekProtocol.h"
#import "BayTekRequestInterface.h"
#import "DQBayTekResponseDelegate.h"
#import "DQIncludes.h"
#import "DQManager.h"
#import "DQObject.h"
#import "DQProperty.h"
#import "DQData.h"

@interface DQBayTekRequestProtocol : BayTekProtocol <BayTekRequestInterface,DQObjectDelegateProtocol>

@property(nonatomic, getter=isConnected)BOOL connected;
@property(nonatomic,readonly) NSString* theDQuidIOSerial;
@property(atomic, strong)DQObject* dqobject;

-(instancetype) init __attribute__((unavailable("use initWithMachineID:andDQuidIOSerialNumber:andResponseDelegate:")));
-(instancetype) initWithMachineID:(Byte)machineID __attribute__((unavailable("use initWithMachineID:andDQuidIOSerialNumber:andResponseDelegate:")));
-(instancetype) initWithMachineID:(Byte)machineID andResponseDelegate:(id<DQBayTekResponseDelegate>)aResponseDelegate __attribute__((unavailable("use initWithMachineID:andDQuidIOSerialNumber:andResponseDelegate:")));
                                                                
-(id) initWithMachineID:(Byte)machineID andDQuidIOSerialNumber:(NSString*) serialNumber andResponseDelegate:(id<DQBayTekResponseDelegate>)aResponseDelegate;

-(BOOL) getMachineID;
-(BOOL) getMajGameVer;
-(BOOL) getMinGameVer;
-(BOOL) getPHSubminGameVer;
-(BOOL) getMajAuxVer;
-(BOOL) getMinAuxVer;
-(BOOL) getPHMajAuxVer;
-(BOOL) getPHMinAuxVer;
-(BOOL) playSound;
-(BOOL) getLastScoreLSB;
-(BOOL) getLastScoreMSB;
-(BOOL) setLightsWithCode:(Byte)lightCode;
-(BOOL) getGameMode;
-(BOOL) toggleInputWithBitkask:(Byte)inputBitmask;
-(BOOL) addCredits:(Byte)noOfCredits;
-(BOOL) clearAllCredits;
-(BOOL) dispenseTickets:(Byte)noOfTickets;
-(BOOL) phAddTickets:(Byte)noOfTickets;
-(BOOL) getNoOfPlayedGamesLSB;
-(BOOL) getNoOfPlayedGamesMSB;
-(BOOL) getNoOfDispensedTicketsLSB;
-(BOOL) getNoOfDispensedTicketsMSB;
-(BOOL) getFBCurrentDailyHighScore;
-(BOOL) getPHTotalAddedTicketsLSB;
-(BOOL) getPHTotalAddedTicketsMLSB;
-(BOOL) getPHTotalAddedTicketsMSB;
-(BOOL) getPHTotalRedeemedTicketsLSB;
-(BOOL) getPHTotalRedeemedTicketsMLSB;
-(BOOL) getPHTotalRedeemedTicketsMSB;
-(BOOL) getPHTotalPrintedTicketsMSB;
-(BOOL) getPHTotalPrintedTicketsLSB;
-(BOOL) getPHNumberOfVendSucceededForLocation:(Byte)location;
-(BOOL) getPHNumberOfVendFailureForLocation:(Byte)location;

- (BOOL) connect;
- (void) disconnect;

@end
