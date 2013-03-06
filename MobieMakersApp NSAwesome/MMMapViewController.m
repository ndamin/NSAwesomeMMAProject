//
//  MMMapViewController.m
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 2/26/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "MMMapViewController.h"
#import "MMAnnotation.h"
#import "Photo.h"
#import "MMViewController.h"


@interface MMMapViewController ()
{
    
    IBOutlet MKMapView *myMapView;
    MMAnnotation *myAnnotation;
    MMAnnotation *anotherAnnotation;
    
}
@property NSMutableArray *arrayOfAnnotations;
@property Photo *currentPhoto;
@property NSMutableArray *myPhotos;


@end

@implementation MMMapViewController
@synthesize incomingArray;

@synthesize arrayOfAnnotations;

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
    NSLog(@"Here comes the array from the main controller!!! %@", incomingArray);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	NSLog(@"%@", incomingArray);
   
    for (int i =0; i<[incomingArray count]; i++) {
        CLLocationCoordinate2D mmCoordinate =
        {
            .latitude = [[[incomingArray objectAtIndex:i]valueForKey:@"latitude"] floatValue] ,
            .longitude = [[[incomingArray objectAtIndex:i]valueForKey:@"longitude"] floatValue]
        };
        
        MKCoordinateSpan defaultSpan =
        {
            .latitudeDelta = 0.02f,
            .longitudeDelta =0.02f
        };
        
        MKCoordinateRegion myRegion = {mmCoordinate, defaultSpan};
        
        myAnnotation = [[MMAnnotation alloc]init];
        myAnnotation.coordinate = mmCoordinate;
        myAnnotation.title =@"MobileMakers";
        myAnnotation.subtitle =@"NSAwesome Lives Here!";
        
        [myMapView setRegion:myRegion];
        [myMapView addAnnotation:myAnnotation];
        
        
        
    }
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
//    NSLog(@"updatePersonalCoordinates: Lat:%f - Long:%f", newCoordinate.latitude,newCoordinate.longitude);
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
