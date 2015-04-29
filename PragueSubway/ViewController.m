//
//  ViewController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "ViewController.h"
#import "SubwayView.h"

@interface ViewController () <SubwayViewDelegate>

@property (strong, nonatomic) SubwayView *subwayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subwayView = [[SubwayView alloc] initWithFrame:self.view.bounds];
    [self.subwayView setBackgroundColor:[UIColor whiteColor]];
    [self.subwayView setSubwayDelegate:self];
    [self.view addSubview:self.subwayView];
    
    [((UIScrollView *)self.view) setContentSize:self.subwayView.frame.size];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InterfaceOrientationMethods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (UIInterfaceOrientationIsPortrait(interfaceOrientation) || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        [self changeTheViewToPortrait:YES andDuration:duration];
    } else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation) &&
              UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
        [self changeTheViewToPortrait:NO andDuration:duration];
    }
}

- (void)changeTheViewToPortrait:(BOOL)portrait andDuration:(NSTimeInterval)duration {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    if (portrait) {
        [self.subwayView transformToHeight:self.view.bounds.size.width];
        [((UIScrollView *)self.view) setContentSize:self.subwayView.frame.size];
    } else {
        if (self.subwayView.frame.size.height != self.view.bounds.size.width) {
            [self.subwayView transformToHeight:self.view.bounds.size.width];
            [((UIScrollView *)self.view) setContentSize:self.subwayView.frame.size];
        }
    }
    
    [UIView commitAnimations];
}

#pragma mark - SubwayViewDelegate 

- (void)stationTouched:(Station *)station {
    TRC_OBJ(station);
}

@end
