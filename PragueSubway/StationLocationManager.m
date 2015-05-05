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

@interface StationLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, atomic) NSArray *stations;

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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
}

@end
