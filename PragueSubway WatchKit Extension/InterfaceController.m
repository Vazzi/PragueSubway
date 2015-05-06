//
//  InterfaceController.m
//  PragueSubway WatchKit Extension
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "InterfaceController.h"
#import "DataService+SubwayLine.h"
#import "DataService+InitialData.h"
#import "LineRowType.h"
#import "SubwayLine.h"
#import "Station.h"
#import "StationLocationManager.h"

#define SEQUE_IDETIFIER_TO_LINE @"toLine"

@interface InterfaceController() <StationLocationDelegate>

@property (weak, nonatomic) IBOutlet WKInterfaceTable *linesTable;
@property (strong, atomic) NSArray *lines;
@property (strong, nonatomic) StationLocationManager *stationLocMan;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self initializeData];
    [self setupTableData];
    [self initializeStationLocationManager];
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
    if ([segueIdentifier isEqualToString:SEQUE_IDETIFIER_TO_LINE]) {
        return self.lines[rowIndex];
    }
    return nil;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - Setup views and data 

- (void)initializeStationLocationManager {
    self.stationLocMan = [[StationLocationManager alloc] init];
    [self.stationLocMan setDelegate:self];
}

- (void)initializeData {
    [[DataService sharedService] createAndSaveInitialData];
    
    self.lines = [[DataService sharedService] subwayLineArraySorted];
}

- (void)setupTableData {
    [self.linesTable setNumberOfRows:self.lines.count withRowType:@"LineRowType"];
    
    for (NSUInteger i = 0; i < self.linesTable.numberOfRows; i++) {
        LineRowType *row = [self.linesTable rowControllerAtIndex:i];
        SubwayLine *line = self.lines[i];
        [row.LineTitle setText:line.name];
        [row.group setBackgroundColor:[line UIColor]];
    }
}

#pragma mark - StationLocationDelegate
- (void)stationFound:(Station *)station {
    if (station.line.count > 1) {
        [self pushControllerWithName:@"StationLinesChoice" context:station];
    } else {
        NSDictionary *data = @{@"station" : station,
                               @"line" : [station getFirstLine]};
        [self pushControllerWithName:@"StationDetail" context:data];
    }
}

- (void)stationSearchDidFailed {
   [self presentControllerWithName:@"AlertView" context:NSLocalizedString(@"Some error occured when finding station.", nil)];
}

- (void)noStationFound {
   [self presentControllerWithName:@"AlertView" context:NSLocalizedString(@"Can not find any near station.", nil)];
    
}

#pragma mark - Actions

- (IBAction)nearStationAction {
    if (![self.stationLocMan isServiceDisabled]) {
        [self.stationLocMan startUpdatingLocation];
    }
}

@end



