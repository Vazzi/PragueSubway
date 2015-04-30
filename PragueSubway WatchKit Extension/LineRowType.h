//
//  LineRowType.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface LineRowType : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *LineTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *group;

@end
