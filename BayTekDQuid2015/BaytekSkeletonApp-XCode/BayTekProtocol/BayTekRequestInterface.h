//
//  BayTekRequestInterface.h
//  BayTekProtocol
//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BayTekRequestInterface <NSObject>

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

@end
