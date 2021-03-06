//
//  DepartureSectionHeaderView.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 29/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DepartureSectionHeaderView.h"

@interface DepartureSectionHeaderView ()

@property (strong, nonatomic) UIImageView *arrowImageView;

@end

@implementation DepartureSectionHeaderView

- (instancetype)initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createLayoutAndSubviews];
    }
    return self;
}


- (void)createLayoutAndSubviews {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setFont:[UIFont systemFontOfSize:20]];
    
    
    UIImage *image = [UIImage imageNamed:@"arrow"];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:label];
    [self addSubview:imageView];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView(30)]-[label]-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(imageView, label)]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(imageView)]];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(label)]];
    self.stationLabel = label;
    self.arrowImageView = imageView;
}

- (void)setArrowColor:(UIColor *)color {
    [self.arrowImageView setTintColor:color];
}

@end
