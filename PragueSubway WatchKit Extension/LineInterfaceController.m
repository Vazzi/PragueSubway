//
//  LineInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "LineInterfaceController.h"
#import "SubwayLine.h"

@interface LineInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@end

@implementation LineInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    SubwayLine *line = context;
    NSString *title = [NSString stringWithFormat:@"Linka %@", line.name];
    [self.titleLabel setText:title];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



