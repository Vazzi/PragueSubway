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

@interface StationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UIView *leftStripe;
@property (weak, nonatomic) IBOutlet UIView *rightStripe;
@property (weak, nonatomic) IBOutlet UITableView *departureTableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.stationNameLabel setText:self.station.name];
    [self setBackgroundColorAndColorsOfStripes];
    [self stylizeDepartureTable];
    [self stylizeCancelButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)stylizeCancelButton {
    self.cancelButton.layer.cornerRadius = 15.0f;
    
}

- (void)stylizeDepartureTable {
    self.departureTableView.layer.cornerRadius = 15.0f;
    [self.departureTableView setClipsToBounds:YES];
    
}

#pragma mark - View
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
        [self.delegate stationViewDidDismiss];
    }];
}

#pragma mark - UITableViewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.station.line.count * 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setText:[NSString stringWithFormat:@"  Směr: %@", self.station.name]];
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    [cell setAccessoryView:nil];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.textLabel.text = @"0:00:00";
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
