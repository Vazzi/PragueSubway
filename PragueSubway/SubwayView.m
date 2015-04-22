//
//  SubwayView.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 22/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "SubwayView.h"
#import "DataService+SubwayLine.h"
#import "Station.h"
#import "SubwayLine.h"

@implementation SubwayView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, DRAW_WIDTH, DRAW_HEIGHT)];
    if (!self) {
        return nil;
    }
    
    CGFloat originalHeight = DRAW_HEIGHT;
    CGFloat scale = frame.size.height / originalHeight;
    self.transform = CGAffineTransformMakeScale(scale, scale);
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSArray *lines = [[DataService sharedService] subwayLineArray];
    for (SubwayLine *line in lines) {
        [self drawSubwayLine:line];
    }

}

- (void)drawSubwayLine:(SubwayLine *)line {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (Station *station in line.stations) {
        
        NSAttributedString* attrStr = [self attrString:station.name fontSize:25 color:[UIColor blackColor]];
        [attrStr drawInRect:[self stationNameRect:station]];
        
        CGRect rect = [self stationPositionRect:station];
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetFillColorWithColor(context, line.UIColor.CGColor);
        CGContextSetLineWidth(context, 5.0);
        CGContextFillEllipseInRect (context, rect);
        CGContextStrokeEllipseInRect(context, rect);
    }
}

- (CGRect)stationPositionRect:(Station *)station {
    return CGRectMake(station.getDrawPoint.x - DRAW_STATION_SIZE / 2,
                      station.getDrawPoint.y - DRAW_STATION_SIZE / 2,
                      DRAW_STATION_SIZE,
                      DRAW_STATION_SIZE);
}

- (CGRect)stationNameRect:(Station *)station {
    return CGRectMake(station.getDrawPoint.x - DRAW_STATION_SIZE * 1.25,
                      station.getDrawPoint.y + DRAW_STATION_SIZE * 0.6,
                      DRAW_STATION_SIZE * 2.5,
                      DRAW_STATION_SIZE);
}

- (NSAttributedString *)attrString:(NSString *)text fontSize:(int)size color:(UIColor *)color {
    
    UIFont* font = [UIFont fontWithName:@"Arial" size:size];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font,
                                   NSForegroundColorAttributeName : color,
                                   NSParagraphStyleAttributeName : style};
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:text
                                                                  attributes:stringAttrs];
    
    return attrStr;
}


@end
