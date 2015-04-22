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
    
    // Scale
    CGFloat originalHeight = DRAW_HEIGHT;
    CGFloat scale = frame.size.height / originalHeight;
    self.transform = CGAffineTransformMakeScale(scale, scale);
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    
    NSArray *lines = [[DataService sharedService] subwayLineArray];
    for (SubwayLine *line in lines) {
        [self drawSubwayLine:line];
    }
    
    for (SubwayLine *line in lines) {
        [self drawStationsOfLine:line];
    }

}

- (void)drawSubwayLine:(SubwayLine *)line {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, DRAW_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, line.UIColor.CGColor);
    Station *station = line.stations[0];
    
    CGContextMoveToPoint(context, station.drawPosX, station.drawPosY);
    
    for (int i = 1; i < line.stations.count; i++) {
        station = line.stations[i];
        if ([station.name isEqualToString:@"Můstek"] && [line.name isEqualToString:@"A"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
        } else if ([station.name isEqualToString:@"Můstek"] && [line.name isEqualToString:@"B"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
        
        } else if ([station.name isEqualToString:@"Náměstí republiky"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Muzeum"] && [line.name isEqualToString:@"C"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Florenc"] && [line.name isEqualToString:@"B"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Vltavská"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Křižíkova"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        }else if ([station.name isEqualToString:@"Náměstí Míru"]) {
            Station *stationBefore = line.stations[i-1];
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else {
            CGContextAddLineToPoint(context, station.drawPosX, station.drawPosY);
        }

    }
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawStationsOfLine:(SubwayLine *)line {
    
    for (Station *station in line.stations) {
        // Text
        NSAttributedString* attrStr = [self attrString:station.name fontSize:25 color:[UIColor blackColor]];
        [attrStr drawInRect:[self stationNameRect:station]];
        // Station
        [self drawStation:station];
    }
}

- (void)drawLineBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 withColor:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, DRAW_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (void)drawStation:(Station *)station {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = [self stationPositionRect:station];
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, ((SubwayLine *)station.line[0]).UIColor.CGColor);
    CGContextSetLineWidth(context, DRAW_STATION_STROKE);
    CGContextFillEllipseInRect (context, rect);
    CGContextStrokeEllipseInRect(context, rect);
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

#pragma mark - Rectangles

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


@end
