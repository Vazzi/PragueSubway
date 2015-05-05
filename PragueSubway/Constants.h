//
//  Constants.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#ifndef PragueSubway_Constants_h
#define PragueSubway_Constants_h

#define DRAW_SIDE_STATIONS_SIZE 1900
#define DRAW_Y_STEP 120
#define DRAW_MIDDLE_STATIONS_SIZE 400
#define DRAW_MIDDLE_INSETS_SIDE 250
#define DRAW_INSETS_TOP 160
#define DRAW_INSETS_BOTTOM 80
#define DRAW_INSETS_SIDE 200
#define DRAW_STATION_SIZE 80
#define DRAW_LINE_WIDTH 60
#define DRAW_STATION_STROKE 9
#define DRAW_STATION_LARGE_SCALE 1.3

#define DRAW_WIDTH (2*DRAW_INSETS_SIDE+2*DRAW_SIDE_STATIONS_SIZE+2*DRAW_MIDDLE_INSETS_SIDE+DRAW_MIDDLE_STATIONS_SIZE)
#define DRAW_HEIGHT (5*DRAW_Y_STEP+DRAW_INSETS_TOP+DRAW_INSETS_BOTTOM)


#define LOCATION_UPDATE_AFTER_METERS 100

#ifdef DEBUG
#define TRC_OBJ(A)                          NSLog(@"%@", A)
#define TRC_DATA(A)                         NSLog(@"DATA %10db: %@", [A length], [[NSString alloc] initWithData:A encoding:NSUTF8StringEncoding])
#define TRC_LOG(format, ...)                NSLog(format, ## __VA_ARGS__)
#define TRC_ERR(format, ...)                NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#else
#define TRC_OBJ(A)
#define TRC_DATA(A)
#define TRC_LOG(format, ...)
#define TRC_ERR(format, ...)                NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#endif

#ifdef DEBUG
#define TRC_POINT(A)                        TRC_OBJ(NSStringFromCGPoint(A))
#define TRC_SIZE(A)                         TRC_OBJ(NSStringFromCGSize(A))
#define TRC_RECT(A)                         TRC_OBJ(NSStringFromCGRect(A))
#define TRC_AFFINE_TRANSFORM(A)             TRC_OBJ(NSStringFromCGAffineTransform(A))
#define TRC_EDGE_INSETS(A)                  TRC_OBJ(NSStringFromUIEdgeInsets(A))
#define TRC_OFFSET(A)                       TRC_OBJ(NSStringFromUIOffset(A))
#else
#define TRC_POINT(A)
#define TRC_SIZE(A)
#define TRC_RECT(A)
#define TRC_AFFINE_TRANSFORM(A)
#define TRC_EDGE_INSETS(A)
#define TRC_OFFSET(A)

#endif

#endif
