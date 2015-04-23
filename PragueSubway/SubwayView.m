//
//  SubwayView.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 22/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "SubwayView.h"
#import "DataService+SubwayLine.h"
#import "DataService+Station.h"
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
    NSArray *stations = [[DataService sharedService] stationsArray];
    [self drawStations:stations];

}

- (void)drawSubwayLine:(SubwayLine *)line {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, DRAW_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, line.UIColor.CGColor);
    Station *station = line.stations[0];
    
    CGContextMoveToPoint(context, station.drawPosX, station.drawPosY);
    
    for (int i = 1; i < line.stations.count; i++) {
        station = line.stations[i];
        Station *stationBefore = line.stations[i-1];
        if ([station.name isEqualToString:@"Můstek"] && [line.name isEqualToString:@"A"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
        } else if ([station.name isEqualToString:@"Můstek"] && [line.name isEqualToString:@"B"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
        
        } else if ([station.name isEqualToString:@"Náměstí republiky"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Muzeum"] && [line.name isEqualToString:@"C"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Florenc"] && [line.name isEqualToString:@"B"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     stationBefore.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Vltavská"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Křižíkova"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        }else if ([station.name isEqualToString:@"Náměstí Míru"]) {
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

- (void)drawStations:(NSArray *)stations {
    for (Station *station in stations) {
        if ([station isEndStation]) {
            [self drawEndStation:station];
        } else if ([station isTransferStation]) {
            [self drawTransferStation:station];
        } else {
            [self drawStation:station];
        }
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
    // Text
    NSAttributedString* attrStr = [self attrString:station.name fontSize:26 color:[UIColor blackColor]];
    [attrStr drawInRect:[self stationNameRect:station scale:1]];
     // Station
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = [self stationPositionRect:station scale:1];
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [station getLine].UIColor.CGColor);
    CGContextSetLineWidth(context, DRAW_STATION_STROKE);
    CGContextFillEllipseInRect (context, rect);
    CGContextStrokeEllipseInRect(context, rect);
}

-(void)drawEndStation:(Station *)station {
    // Text
    NSAttributedString* attrStr = [self attrString:station.name fontSize:26 color:[UIColor blackColor]];
    [attrStr drawInRect:[self stationNameRect:station scale:1.1]];
    
    // Station
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = [self stationPositionRect:station scale:1.1];
    CGFloat radius = 10.0;
    CGContextSetStrokeColorWithColor(context, [station getLine].UIColor.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextSetLineWidth(context, DRAW_STATION_STROKE);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    // Line name
    NSAttributedString* attrStrS = [self attrString:[station getLine].name
                                           fontSize:DRAW_STATION_SIZE
                                              color:[station getLine].UIColor];
    [attrStrS drawInRect:rect];
}

-(void)drawTransferStation:(Station *)station {
    
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

- (CGRect)stationPositionRect:(Station *)station scale:(CGFloat)scale {
    return CGRectMake(station.getDrawPoint.x - (DRAW_STATION_SIZE * scale) / 2,
                      station.getDrawPoint.y - (DRAW_STATION_SIZE * scale) / 2,
                      (DRAW_STATION_SIZE * scale),
                      (DRAW_STATION_SIZE * scale));
}

- (CGRect)stationNameRect:(Station *)station scale:(CGFloat)scale {
    return CGRectMake(station.getDrawPoint.x - (DRAW_STATION_SIZE * scale) * 1.25,
                      station.getDrawPoint.y + (DRAW_STATION_SIZE * scale) * 0.7,
                      (DRAW_STATION_SIZE * scale) * 2.5,
                      (DRAW_STATION_SIZE * scale));
}


@end
