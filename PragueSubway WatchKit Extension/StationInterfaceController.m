//
//  StationInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "StationInterfaceController.h"
#import "Station.h"
#import "DeparturesTimer.h"

@interface StationInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstToStationLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstTimeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *secondToStationLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *secondTimeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *secondGroup;

@property (strong, atomic) Station *station;
@property (strong, atomic) DeparturesTimer *timerFirst;
@property (strong, atomic) DeparturesTimer *timerSecond;

@end

@implementation StationInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSDictionary *data = context;
    
    [self initalizeDataWithStation:(Station *)data[@"station"]
                              line:(SubwayLine *)data[@"line"]];
    
    
}

- (void)initalizeDataWithStation:(Station *)station line:(SubwayLine *)line {
    self.station = station;
    NSArray *departuresGrouped = [station getDeparturesGroupedByDirectionsForLine:line];
    self.timerFirst = departuresGrouped.firstObject;
    
    if (departuresGrouped.count == 2) {
        self.timerSecond = departuresGrouped.lastObject;
    } else {
        self.timerSecond = false;
    }
    
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



