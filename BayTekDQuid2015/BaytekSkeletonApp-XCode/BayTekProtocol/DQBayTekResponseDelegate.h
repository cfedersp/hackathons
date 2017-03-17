//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#ifndef DQBayTekResponseDelegate_h
#define DQBayTekResponseDelegate_h

@protocol DQBayTekResponseDelegate
-(void) onMachineIDReceived:(Byte) machineID;
-(void) onMajGameVerReceived:(Byte) majVer;
-(void) onMinGameVerReceived:(Byte) minVer;
-(void) onPHSubminGameVerReceived:(Byte) phSubminVer;
-(void) onMajAuxVerReceived:(Byte) majAuxVer;
-(void) onMinAuxVerReceived:(Byte) minAuxVer;
-(void) onPHMajAuxVerReceived:(Byte) phMajAuxVer;
-(void) onPHMinAuxVerReceived:(Byte) phMinAuxVer;
-(void) onPlaySoundACKReceived;
-(void) onLastScoreLSBReceived:(Byte) lastScoreLSB;
-(void) onLastScoreMSBReceived:(Byte) lastScoreMSB;
-(void) onLightsACKReceived:(Byte) lightCode;
-(void) onGameModeReceived:(Byte) gameMode;
-(void) onToggleInputACKReceived:(Byte) inputBitmask;
-(void) onAddCreditsACKReceived:(Byte) noOfCredits;
-(void) onClearAllCreditsACKReceived;
-(void) onDispenseTicketsACKReceived:(Byte) noOfTickets;
-(void) onPHAddTicketsACKReceived:(Byte) noOfTickets;
-(void) onNoOfPlayedGamesLSBReceived:(Byte) noOfPlayedGamesLSB;
-(void) onNoOfPlayedGamesMSBReceived:(Byte) noOfPlayedGamesMSB;
-(void) onNoOfDispensedTicketsLSBReceived:(Byte) noOfDispensedTicketsLSB;
-(void) onNoOfDispensedTicketsMSBReceived:(Byte) noOfDispensedTicketsMSB;
-(void) onFBCurrentDailyHighScoreReceived:(Byte) currentDailyHighscore;
-(void) onPHTotalAddedTicketsLSBReceived:(Byte) noOfAddedTicketsLSB;
-(void) onPHTotalAddedTicketsMLSBReceived:(Byte) noOfAddedTicketsMLSB;
-(void) onPHTotalAddedTicketsMSBReceived:(Byte) noOfAddedTicketsMSB;
-(void) onPHTotalRedeemedTicketsLSBReceived:(Byte) noOfRedeemedTicketsLSB;
-(void) onPHTotalRedeemedTicketsMLSBReceived:(Byte) noOfRedeemedTicketsMLSB;
-(void) onPHTotalRedeemedTicketsMSBReceived:(Byte) noOfRedeemedTicketsMSB;
-(void) onPHTotalPrintedTicketsMSBReceived:(Byte) noOfPrintedTicketsMSB;
-(void) onPHTotalPrintedTicketsLSBReceived:(Byte) noOfPrintedTicketsLSB;
-(void) onPHNumberOfVendSucceededReceived:(Byte)noOfVendSucceeded forLocation:(Byte)location;
-(void) onPHNumberOfVendFailedReceived:(Byte)noOfVendSucceeded forLocation:(Byte)location;
-(void) onInvalidCommandReceived:(NSError*) e;

-(void) onConnectionEstablished;
-(void) onDisconnection;

@end

#endif
