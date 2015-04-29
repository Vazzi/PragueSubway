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

@interface StationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UIView *leftStripe;
@property (weak, nonatomic) IBOutlet UIView *rightStripe;

@end

@implementation StationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.stationNameLabel setText:self.station.name];
    [self setBackgroundColorAndColorsOfStripes];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View
- (void)setBackgroundColorAndColorsOfStripes {
    if ([self.station isTransferStation]) {
        [self.view setBackgroundColor:[self.station.line[1] UIColor]];
        [self.leftStripe setBackgroundColor:[[self.station getFirstLine] UIColor]];
        [self.rightStripe setBackgroundColor:[[self.station getFirstLine] UIColor]];
    } else {
        [self.view setBackgroundColor:[[self.station getFirstLine] UIColor]];
        [self.leftStripe setBackgroundColor:[[self.station getFirstLine] UIColor]];
        [self.rightStripe setBackgroundColor:[[self.station getFirstLine] UIColor]];
    }
}


#pragma mark - Actions

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate stationViewDidDismiss];
    }];
}

@end
