//
//  ViewController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "ViewController.h"
#import "SubwayView.h"
#import "StationViewController.h"
#import "Station.h"

#import "BlurryModalSegue.h"

@interface ViewController () <UIScrollViewDelegate, SubwayViewDelegate, StationViewDelegate>

@property (strong, nonatomic) SubwayView *subwayView;
@property (weak, nonatomic) Station* stationToGo;
@property BOOL isZoomedToStation;
@property CGRect originalZoomRect;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subwayView = [[SubwayView alloc] initWithFrame:self.view.bounds];
    [self.subwayView setBackgroundColor:[UIColor whiteColor]];
    [self.subwayView setSubwayDelegate:self];
    [self.scrollView addSubview:self.subwayView];
    [self.scrollView setDelegate:self];
    
    [self.scrollView setContentSize:self.subwayView.frame.size];

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
        [(self.scrollView) setContentSize:self.subwayView.frame.size];
    } else {
        if (self.subwayView.frame.size.height != self.view.bounds.size.width) {
            [self.subwayView transformToHeight:self.view.bounds.size.width];
            [(self.scrollView) setContentSize:self.subwayView.frame.size];
        }
    }
    
    [UIView commitAnimations];
}

#pragma mark - SubwayViewDelegate 

- (void)stationTouched:(Station *)station rect:(CGRect)rectToZoom {
    [self prepareToZoom];
    self.isZoomedToStation = YES;
    self.stationToGo = station;
    [self setOriginalZoomRectForCurrentPosition];
    [self.scrollView zoomToRect:rectToZoom animated:YES];
}

#pragma mark - StationViewDelegate

- (void)stationViewDidDismiss {
    [self.scrollView zoomToRect:self.originalZoomRect animated:YES];
}

#pragma mark - ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.subwayView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (self.isZoomedToStation) {
        [self showStationView];
        self.stationToGo = nil;
        self.isZoomedToStation = NO;
    } else {
        [self afterZoom];
    }
    
}

#pragma mark -

- (void)setOriginalZoomRectForCurrentPosition {
    CGRect visibleRect;
    visibleRect.origin = self.scrollView.contentOffset;
    visibleRect.size = self.scrollView.frame.size;
    CGFloat scale = 1.0 / [self.scrollView zoomScale];
    visibleRect.origin.x *= scale;
    visibleRect.size.width *= scale;
    visibleRect.size.height *= scale;
    visibleRect.origin.y *= scale;
    self.originalZoomRect = visibleRect;
}

- (void)showStationView {
    StationViewController *stationView = [[StationViewController alloc] initWithNibName:@"StationViewController" bundle:nil];
    [stationView setStation:self.stationToGo];
    [stationView setDelegate:self];
    
    [self presentViewController:stationView animated:NO completion:nil];
    
}

- (void)prepareToZoom {
    UIScrollView *scrollView = self.scrollView;
    [scrollView setMinimumZoomScale:0];
    [scrollView setMaximumZoomScale:500];
    [scrollView setScrollEnabled:NO];
}

- (void)afterZoom {
    UIScrollView *scrollView = self.scrollView;
    [scrollView setMinimumZoomScale:1];
    [scrollView setMaximumZoomScale:1];
    [scrollView setScrollEnabled:YES];
}

@end
