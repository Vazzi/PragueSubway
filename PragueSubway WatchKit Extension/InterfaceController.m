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

#define SEQUE_IDETIFIER_TO_LINE @"toLine"

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *linesTable;
@property (strong, atomic) NSArray *lines;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self initializeData];
    [self setupTableData];
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


#pragma mark - Actions

- (IBAction)nearStationAction {
    // TODO: Implement
    NSLog(@"Find nearest station and show");
}

@end



