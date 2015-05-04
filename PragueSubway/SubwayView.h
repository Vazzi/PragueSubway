//
//  SubwayView.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 22/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Station;

@protocol SubwayViewDelegate <NSObject>

- (void)stationTouched:(Station *)station rect:(CGRect)rectToZoom;

@end

@interface SubwayView : UIView

@property (nonatomic, assign) id<SubwayViewDelegate> subwayDelegate;

- (instancetype)initWithHeight:(CGFloat) height;
- (void)transformToHeight:(CGFloat) height;

@end
