//
//  main.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataService+InitialData.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        [[DataService sharedService] createAndSaveInitialData];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
