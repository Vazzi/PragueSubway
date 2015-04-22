//
//  ViewController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "ViewController.h"
#import "SubwayView.h"

@interface ViewController ()

@property (strong, nonatomic) SubwayView *subwayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subwayView = [[SubwayView alloc] initWithFrame:self.view.bounds];
    [self.subwayView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.subwayView];
    
    [((UIScrollView *)self.view) setContentSize:self.subwayView.frame.size];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
