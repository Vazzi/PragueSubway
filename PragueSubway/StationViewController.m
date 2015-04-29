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

@end

@implementation StationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.stationNameLabel setText:self.station.name];
    [self.view setBackgroundColor:[[self.station getFirstLine] UIColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate stationViewDidDismiss];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
