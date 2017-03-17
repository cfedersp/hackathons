//
//  BayTekProtocol.h
//  BayTekProtocol
//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQBayTekResponseDelegate.h"


FOUNDATION_EXPORT NSString* const  BAYTEK_ERR_DOMAIN;

#define E_INVALID_LEN               -1
#define E_INVALID_PREAMBLE          -2
#define E_INVALID_PAYLOAD           -3
#define E_UNSUPPORTED_COMMAND       -4
#define E_UNDEFINED_COMMAND         -5

#define PACKET_LEN                  2

#define LIGHTS_GAME_CONTROL_CODE 	0x00
#define LIGHTS_GREEN_CODE           0x01
#define LIGHTS_YELLOW_CODE          0x02
#define LIGHTS_LIGHT_BLUE_CODE      0x03
#define LIGHTS_BLUE_CODE            0x04
#define LIGHTS_PURPLE_CODE          0x05
#define LIGHTS_RED_CODE             0x06
#define LIGHTS_WHITE_CODE           0x07

#define FLAPPY_BIRD                 0x00
#define PIANO_TILES                 0x01
#define PRIZE_HUB				 	0x03

#define IDX_PREAMBLE                0
#define IDX_PAYLOAD                 1

#define ID_GAME_VER_AND_ID          0x00
#define ID_PLAY_SOUND               0x01
#define ID_LAST_SCORE               0x02
#define ID_SET_LIGHTS               0x03
#define ID_GAME_MODE                0x04
#define ID_TOGGLE_INPUT             0x05
#define ID_ADD_CREDITS              0x06
#define ID_CLEAR_ALL_CREDITS        0x07
#define ID_DISPENSE_TICKETS         0x08
#define ID_ADD_TICKETS              0x08
#define ID_MACHINE_STATS            0x0A
#define ID_PH_MACHINE_STATS_1       0x0B
#define ID_PH_MACHINE_STATS_2       0x0C

#define PL_NULL						0x00
#define PL_GET_MACHINE_ID			0x00
#define PL_GET_MAJ_GAME_VER_ID		0x01
#define PL_GET_MIN_GAME_VER_ID		0x02
#define PL_GET_AUX_MAJ_VER_ID		0x03
#define PL_GET_AUX_MIN_VER_ID		0x04
#define PL_GET_PH_SMIN_GAME_VER_ID	0x03
#define PL_GET_PH_AUX_MAJ_VER_ID	0x04
#define PL_GET_PH_AUX_MIN_VER_ID	0x05
#define PL_LAST_SCORE_LSB			0x00
#define PL_LAST_SCORE_MSB			0x01

#define PL_NO_OF_PLAYED_GAMES_LSB	0x00
#define PL_NO_OF_PLAYED_GAMES_MSB	0x01
#define PL_NO_OF_DISP_TICKETS_LSB	0x02
#define PL_NO_OF_DISP_TICKETS_MSB	0x03
#define PL_FB_CURR_DAILY_HIGHSCORE	0x04

#define PL_PH_TOT_ADDED_TICKETS_LSB		  0x00
#define PL_PH_TOT_ADDED_TICKETS_MLSB	  0x01
#define PL_PH_TOT_ADDED_TICKETS_MSB		  0x02
#define PL_PH_TOT_REDEEMED_TICKETS_LSB	  0x03
#define PL_PH_TOT_REDEEMED_TICKETS_MLSB	  0x04
#define PL_PH_TOT_REDEEMED_TICKETS_MSB	  0x05
#define PL_PH_TOT_PRINTED_TICKETS_LSB	  0x06
#define PL_PH_TOT_PRINTED_TICKETS_MSB	  0x07

@interface BayTekProtocol : NSObject {
    @protected
    Byte theMachineID;
    id<DQBayTekResponseDelegate> theResponseDelegate;

    @private
    Byte lastRequestPayload;
}

-(id) initWithMachineID:(Byte) machineID;
-(id) initWithMachineID:(Byte) machineID andResponseDelegate:(id<DQBayTekResponseDelegate>)aResponseDelegate;
-(void) setMachineID:(Byte) machineID;
-(void) setResponseDelegate:(id<DQBayTekResponseDelegate>)aResponseDelegate;
-(NSData*) newRequestPacketWithCommand:(Byte)command andPayload:(Byte)payload;
//-(NSData*) newResponsePacketWithCommand:(Byte)command andPayload:(Byte)payload;
-(NSData*) newRequestPacketWithCommand:(Byte)command;
//-(NSData*) newResponsePacketWithCommand:(Byte)command;
-(void) parsePacket:(NSData*) aPacket;

@end
