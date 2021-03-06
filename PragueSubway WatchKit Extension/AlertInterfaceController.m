//
//  AlertInterfaceController.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 06/05/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "AlertInterfaceController.h"

@interface AlertInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *contextLabel;

@end

@implementation AlertInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self.contextLabel setText:context];
    // Configure interface objects here.
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



