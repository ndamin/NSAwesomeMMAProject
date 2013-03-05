//
//  MMMapViewController.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 2/26/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MMMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    //declare GPS Variables
    CLLocationManager *awesomeLocationManager;
}
@property (strong, nonatomic) NSMutableArray *incomingArray;

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

- (void)startLocationUpdates;
- (void)updatePersonalCoordinates:(CLLocationCoordinate2D)newCoordinate;





@end
