//
//  StationLocationManager.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 05/05/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "StationLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "DataService+Station.h"
#import "Station.h"

@interface StationLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, atomic) NSArray *stations;
@property (strong, atomic) Station *nearestStation;

@end

@implementation StationLocationManager

- (instancetype)init {
    if (self = [super init]) {
        self.stations = [[DataService sharedService] stationsArray];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager setDistanceFilter:LOCATION_UPDATE_AFTER_METERS];;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return self;
}


- (void)showAllertIfServiceDisabled {
    if([CLLocationManager locationServicesEnabled]){
        if( [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied ||
           [CLLocationManager authorizationStatus]==kCLAuthorizationStatusRestricted ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Polohové služby"
                                                            message:@"Pro vyhledání nejbližší stanice, musíte mít zapnutou funkci Polohové služby. Pro povolení přejděte do Nastavení > Soukromí > Polohové služby a zaškrtněte tuto aplikaci."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Polohové služby"
                                                        message:@"Pro vyhledání nejbližší stanice, musíte mít zapnutou funkci Polohové služby. Pro zapnutí přejděte do Nastavení > Soukromí > Polohové služby."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

- (Station *)getNearestStation {
    return self.nearestStation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *userLoc = [locations lastObject];
    NSLog(@"NewLocation %f %f", userLoc.coordinate.latitude, userLoc.coordinate.longitude);
    
    CLLocationDistance smallestDist = STATION_LIMIT_METERS;
    Station *nearestStation = nil;
    
    for (Station *station in self.stations) {
        if (station.latitude == nil || station.longitude == nil) {
            continue;
        }
        CLLocation *stationLoc = [[CLLocation alloc]
                                   initWithLatitude:(CLLocationDegrees)[station.latitude doubleValue]
                                   longitude:(CLLocationDegrees)[station.longitude doubleValue]];
        
        CLLocationDistance dist = [stationLoc distanceFromLocation:userLoc];
        //If station is far then STATION_LIMIT_METERS meters do not save it
        if (dist > STATION_LIMIT_METERS) {
            continue;
        } else if (dist < smallestDist) {
            smallestDist = dist;
            nearestStation = station;
        }
    }
}

@end
