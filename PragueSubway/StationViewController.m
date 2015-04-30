//
//  StationViewController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 29/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "StationViewController.h"
#import "Station.h"
#import "SubwayLine.h"
#import <QuartzCore/QuartzCore.h>
#import "DepartureSectionHeaderView.h"
#import "DeparturesTimer.h"
#import "Departure.h"

@interface StationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UIView *leftStripe;
@property (weak, nonatomic) IBOutlet UIView *rightStripe;
@property (weak, nonatomic) IBOutlet UITableView *departureTableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, atomic) NSArray *departuresTimers;
@property (strong, nonatomic) NSTimer *updateTimer;

@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewSetup];
    [self initializeData];
    [self setupAndStartTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)initializeData {
    NSArray *departuresGroupedByDirections = [self.station getAllDeparturesGroupedByDirections];
    
    NSMutableArray *departuresTimersMutable = [[NSMutableArray alloc] init];
    for (NSArray *departures in departuresGroupedByDirections) {
        DeparturesTimer *dtimer = [[DeparturesTimer alloc] initWithDepartures:departures];
        [dtimer start];
        [departuresTimersMutable addObject:dtimer];
    }
    self.departuresTimers = [NSArray arrayWithArray:departuresTimersMutable];
    
}

- (void)setupAndStartTimer {
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateTable) userInfo:nil repeats:YES];
}

- (void)updateTable {
    [self.departureTableView reloadData];
}

#pragma mark - Views

- (void)viewSetup {
    [self.stationNameLabel setText:self.station.name];
    [self setBackgroundColorAndColorsOfStripes];
    [self stylizeDepartureTable];
    [self stylizeCancelButton];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)stylizeCancelButton {
    self.cancelButton.layer.cornerRadius = 15.0f;
}

- (void)stylizeDepartureTable {
    self.departureTableView.layer.cornerRadius = 15.0f;
    [self.departureTableView setClipsToBounds:YES];
}

- (void)setBackgroundColorAndColorsOfStripes {
    UIColor *mainColor = [[self.station.line lastObject] UIColor];
    UIColor *secondaryColor = [[self.station getFirstLine] UIColor];
    
    if ([self.station isTransferStation]) {
        [self.view setBackgroundColor:mainColor];
        [self.leftStripe setBackgroundColor:secondaryColor];
        [self.rightStripe setBackgroundColor:secondaryColor];
    } else {
        [self.view setBackgroundColor:mainColor];
        [self.leftStripe setBackgroundColor:mainColor];
        [self.rightStripe setBackgroundColor:mainColor];
    }
}

#pragma mark - Actions

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.updateTimer invalidate];
        self.updateTimer = nil;
        [self.delegate stationViewDidDismiss];
    }];
}

#pragma mark - UITableViewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.departuresTimers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DepartureSectionHeaderView *view = [[DepartureSectionHeaderView alloc] initWithFrame:CGRectZero];
    
    Departure *departure = [self.departuresTimers[section] getDeparture];
    [view.stationLabel setText:departure.directionStation.name];
    [view setArrowColor:[[departure.directionStation getFirstLine] UIColor]];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        // Setting constant properties
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell.textLabel setFont:[UIFont systemFontOfSize:32]];
        [cell.textLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        cell.imageView.image = [UIImage imageNamed:@"clock"];
    }
    
    DeparturesTimer *data = self.departuresTimers[indexPath.section];
    cell.textLabel.text = [data getFormatedRemainingTime];
    
    return cell;
}

@end
