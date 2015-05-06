//
//  StationInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "StationInterfaceController.h"
#import "Station.h"
#import "SubwayLine.h"
#import "DeparturesTimer.h"
#import "Departure.h"

@interface StationInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstToStationLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstTimeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *secondToStationLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *secondTimeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *secondGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceSeparator *separator;

@property (strong, atomic) Station *station;
@property (strong, atomic) DeparturesTimer *timerFirst;
@property (strong, atomic) DeparturesTimer *timerSecond;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation StationInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSDictionary *data = context;
    [self initalizeDataWithStation:(Station *)data[@"station"]
                              line:(SubwayLine *)data[@"line"]];
    
    [self setupLabels];
    [self setupTimerLabels];
    
}

- (void)setupLabels {
    [self.stationNameLabel setText:self.station.name];
    Departure *firstDeparture = [self.timerFirst getDeparture];
    [self.firstToStationLabel setText:firstDeparture.directionStation.name];
    
    if (self.timerSecond == nil) {
        [self.secondGroup setHidden:YES];
    } else {
        Departure *secondDeparture = [self.timerSecond getDeparture];
        [self.secondToStationLabel setText:secondDeparture.directionStation.name];
    }
}

- (void)setupTimerLabels {
    [self.firstTimeLabel setText:[self.timerFirst getFormatedRemainingTime]];
    
    if (self.timerSecond != nil) {
        [self.secondTimeLabel setText:[self.timerSecond getFormatedRemainingTime]];
    }
}

- (void)initalizeDataWithStation:(Station *)station line:(SubwayLine *)line {
    self.station = station;
    NSArray *departuresGrouped = [station getDeparturesGroupedByDirectionsForLine:line];
    self.timerFirst = [[DeparturesTimer alloc] initWithDepartures:departuresGrouped.firstObject];
    [self.timerFirst start];
    
    if (departuresGrouped.count == 2) {
        self.timerSecond = [[DeparturesTimer alloc] initWithDepartures:departuresGrouped.lastObject];
        [self.timerSecond start];
    } else {
        self.timerSecond = false;
    }
    
    [self.separator setColor:[line UIColor]];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(setupTimerLabels) userInfo:nil repeats:YES];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
    [self.timer invalidate];
    self.timer = nil;
}

@end



