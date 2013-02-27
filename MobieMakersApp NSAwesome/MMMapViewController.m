//
//  MMMapViewController.m
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 2/26/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "MMMapViewController.h"
#import "MMAnnotation.h"

@interface MMMapViewController ()
{
    
    IBOutlet MKMapView *myMapView;
    MMAnnotation *myAnnotation;
}

@end

@implementation MMMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	CLLocationCoordinate2D mmCoordinate =
    {
        .latitude = 41.894032f,
        .longitude = -87.634742f
    };
    
    MKCoordinateSpan defaultSpan =
    {
        .latitudeDelta = 0.002f,
        .longitudeDelta =0.002f
    };
    
    MKCoordinateRegion myRegion = {mmCoordinate, defaultSpan};
    
    myAnnotation = [[MMAnnotation alloc]init];
    myAnnotation.coordinate = mmCoordinate;
    myAnnotation.title =@"MobileMakers";
    myAnnotation.subtitle =@"NSAwesome Lives Here!";
    
    [myMapView setRegion:myRegion];
    [myMapView addAnnotation:myAnnotation];
    
    [self startLocationUpdates];

}

- (void)startLocationUpdates
{
    if (awesomeLocationManager==nil) {
        awesomeLocationManager = [[CLLocationManager alloc]init];
    }
    awesomeLocationManager.delegate = self;
    
    //firehose of updates
    [awesomeLocationManager startUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"lat:%f - long:%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [self updatePersonalCoordinates:newLocation.coordinate];
}

- (void)updatePersonalCoordinates:(CLLocationCoordinate2D)newCoordinate
{
    myAnnotation.coordinate = newCoordinate;
    NSLog(@"updatePersonalCoordinates: Lat:%f - Long:%f", newCoordinate.latitude,newCoordinate.longitude);
    [self updateMapViewWithNewCenter:newCoordinate];
}

- (void)updateMapViewWithNewCenter:(CLLocationCoordinate2D)newCoodinate
{
    MKCoordinateRegion newRegion = {newCoodinate, myMapView.region.span};
    [myMapView setRegion:newRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
