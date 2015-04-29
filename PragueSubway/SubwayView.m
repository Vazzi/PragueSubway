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
    
    [self transformToHeight:frame.size.height];
    
    return self;
}

- (void)transformToHeight:(CGFloat) height {
    CGFloat originalHeight = DRAW_HEIGHT;
    CGFloat scale = height / originalHeight;
    self.transform = CGAffineTransformMakeScale(scale, scale);
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
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

#pragma mark Lines

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
            
        } else if ([station.name isEqualToString:@"Náměstí Republiky"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) / 2),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else if ([station.name isEqualToString:@"Muzeum"] && [line.name isEqualToString:@"C"]) {
            CGContextAddCurveToPoint(context,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) * 0.2),
                                     stationBefore.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) * 0.2),
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
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) * 0.8),
                                     station.drawPosY,
                                     station.drawPosX - ((station.drawPosX - stationBefore.drawPosX) * 0.8),
                                     station.drawPosY,
                                     station.drawPosX, station.drawPosY);
            
        } else {
            CGContextAddLineToPoint(context, station.drawPosX, station.drawPosY);
        }
    }
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawLineBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 withColor:(UIColor *)color {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, DRAW_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

#pragma mark Stations
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

- (void)drawStation:(Station *)station {
    // Text
    NSAttributedString* attrStr = [self attrString:station.name alignment:NSTextAlignmentCenter];
    if ([station.name isEqualToString:@"Hlavní nádraží"]) {
        CGRect rect = [self stationNameRightRect:station scale:1];
        rect.origin.y += DRAW_STATION_SIZE * 0.3;
        rect.size.width = DRAW_STATION_SIZE * 1.2;
        [attrStr drawInRect:rect];
    } else  if ([station.name isEqualToString:@"Náměstí Republiky"]) {
        CGRect rect = [self stationNameRect:station scale:1];
        rect.origin.y -= DRAW_STATION_SIZE * 2;
        [attrStr drawInRect:rect];
    } else {
        [attrStr drawInRect:[self stationNameRect:station scale:1]];
    }
    
    // Station
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = [self stationPositionRect:station scale:1];
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [station getFirstLine].UIColor.CGColor);
    CGContextSetLineWidth(context, DRAW_STATION_STROKE);
    CGContextFillEllipseInRect (context, rect);
    CGContextStrokeEllipseInRect(context, rect);
}

-(void)drawEndStation:(Station *)station {
    // Text
    NSAttributedString* attrStr = [self attrString:station.name alignment:NSTextAlignmentCenter];
    [attrStr drawInRect:[self stationNameRect:station scale:1.1]];
    
    // Station
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = [self stationPositionRect:station scale:1.1];
    CGFloat radius = 10.0;
    CGContextSetStrokeColorWithColor(context, [station getFirstLine].UIColor.CGColor);
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
    NSAttributedString* attrStrS = [self attrLineName:[station getFirstLine]];
    [attrStrS drawInRect:rect];
}

-(void)drawTransferStation:(Station *)station {
    [self drawTransferStationName:station];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect stationRect = [self stationPositionRect:station scale:DRAW_STATION_LARGE_SCALE];
    CGContextSetFillColorWithColor(context, [station getFirstLine].UIColor.CGColor);
    CGContextFillEllipseInRect (context, stationRect);
    
    CGRect substationRect = [self stationPositionRect:station scale:0.8];
    CGContextSetFillColorWithColor(context, ((SubwayLine *)station.line[1]).UIColor.CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, DRAW_STATION_STROKE * 2);
    CGContextStrokeEllipseInRect (context, substationRect);
    CGContextFillEllipseInRect (context, substationRect);
}

#pragma mark Text

- (void)drawTransferStationName:(Station *)station {
    NSAttributedString* attrStr;
    CGRect rect;
    if ([station.name isEqualToString:@"Můstek"]) {
        attrStr = [self attrString:station.name alignment:NSTextAlignmentRight];
        rect = [self stationNameLeftRect:station scale:DRAW_STATION_LARGE_SCALE];
    } else if ([station.name isEqualToString:@"Muzeum"]) {
        attrStr = [self attrString:station.name alignment:NSTextAlignmentLeft];
        rect = [self stationNameRightRect:station scale:DRAW_STATION_LARGE_SCALE];
    } else if ([station.name isEqualToString:@"Florenc"]) {
        attrStr = [self attrString:station.name alignment:NSTextAlignmentRight];
        rect = [self stationNameLeftRect:station scale:DRAW_STATION_LARGE_SCALE];
    }
    [attrStr drawInRect: rect];
}

- (NSAttributedString *)attrString:(NSString *)text alignment:(enum NSTextAlignment)alignment {
    
    UIFont* font = [UIFont fontWithName:@"Arial" size:26];

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:alignment];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font,
                                   NSForegroundColorAttributeName : [UIColor blackColor],
                                   NSParagraphStyleAttributeName : style};
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:text
                                                                  attributes:stringAttrs];
    
    return attrStr;
}

- (NSAttributedString *)attrLineName:(SubwayLine *) line {
    
    UIFont* font = [UIFont fontWithName:@"Arial" size:DRAW_STATION_SIZE];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font,
                                   NSForegroundColorAttributeName : line.UIColor,
                                   NSParagraphStyleAttributeName : style};
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:line.name
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

- (CGRect)stationNameRightRect:(Station *)station scale:(CGFloat)scale {
    return CGRectMake(station.getDrawPoint.x + ((DRAW_STATION_SIZE * scale) * 0.7),
                      station.getDrawPoint.y - (DRAW_STATION_SIZE * scale) / 4,
                      (DRAW_STATION_SIZE * scale) * 2.5,
                      (DRAW_STATION_SIZE * scale));
}

- (CGRect)stationNameLeftRect:(Station *)station scale:(CGFloat)scale {
    return CGRectMake(station.getDrawPoint.x - ((DRAW_STATION_SIZE * scale) / 2) - (DRAW_STATION_SIZE * scale) * 1.2,
                      station.getDrawPoint.y - (DRAW_STATION_SIZE * scale) / 4,
                      (DRAW_STATION_SIZE * scale),
                      (DRAW_STATION_SIZE * scale) * 1.2);
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    NSArray *stations = [[DataService sharedService] stationsArray];
    
    for (Station *station in stations) {
        CGFloat scale = ([station isEndStation] || [station isTransferStation]) ? DRAW_STATION_LARGE_SCALE : 1;
        CGRect stationRect = [self stationPositionRect:station scale:scale];
        if (CGRectContainsPoint(stationRect, touchLocation)) {
            [self.subwayDelegate stationTouched:station];
            return;
        }
    }
    
}

@end
