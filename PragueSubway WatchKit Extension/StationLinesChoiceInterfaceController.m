//
//  StationLinesChoiceInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 06/05/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "StationLinesChoiceInterfaceController.h"
#import "Station.h"

#define SEQUE_IDETIFIER_TO_STATION @"toStationDetail"

@interface StationLinesChoiceInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceTable *linesTable;
@property (strong, atomic) Station *station;

@end

@implementation StationLinesChoiceInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.station = context;
    [self.stationNameLabel setText:self.station.name];
    
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
    if ([segueIdentifier isEqualToString:SEQUE_IDETIFIER_TO_STATION]) {
        return @{@"station" : self.station,
                 @"line" : self.station.line[rowIndex]};
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

- (void)setupTableDataWithStation:(Station *)station {
   // TODO: lines to table
}

@end



