//
//  LineInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "LineInterfaceController.h"
#import "StationRowType.h"
#import "SubwayLine.h"
#import "Station.h"

#define SEQUE_IDETIFIER_TO_STATION @"toStationDetail"

@interface LineInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceTable *stationsTable;

@property (strong, atomic) NSArray *stations;
@property (strong, atomic) SubwayLine *line;

@end

@implementation LineInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.line = context;
    [self setTitleWithSubwayLine:self.line];
    [self setupTableDataWithLine:self.line];
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
    if ([segueIdentifier isEqualToString:SEQUE_IDETIFIER_TO_STATION]) {
        return @{@"station" : self.stations[rowIndex],
                 @"line" : self.line};
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
- (void)setTitleWithSubwayLine:(SubwayLine *)line {
    NSString *title = [NSString stringWithFormat:@"Linka %@", line.name];
    [self.titleLabel setText:title];
}

- (void)setupTableDataWithLine:(SubwayLine *)line {
    self.stations = [line.stations array];
    [self.stationsTable setNumberOfRows:self.stations.count withRowType:@"StationRowType"];
    
    for (NSUInteger i = 0; i < self.stationsTable.numberOfRows; i++) {
        StationRowType *row = [self.stationsTable rowControllerAtIndex:i];
        Station *station = self.stations[i];
        [row.titleLabel setText:station.name];
        [row.group setBackgroundColor:[line UIColor]];
    }
}

@end



