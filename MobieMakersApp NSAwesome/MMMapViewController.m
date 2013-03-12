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
#import "FlickrAPI.h"


@interface MMMapViewController ()
{
    
    IBOutlet MKMapView *myMapView;
    MMAnnotation *myAnnotation;
    MMAnnotation *anotherAnnotation;
    FlickrAPI *myFlickerAPI;
    float newLatitude;
    float newLongitude;
}
@property NSMutableArray *arrayOfAnnotations;

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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startLocationUpdates];
    
    
    
    myFlickerAPI = [[FlickrAPI alloc] init];
    myFlickerAPI.delegate = self;
    
    NSString *flickrURLString =[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d251dca82f1f85f0b3de7d64bdb18e03&lat=%f&lon=%f&radius=30&extras=geo&per_page=20&format=json&nojsoncallback=1",newLatitude,newLongitude];
    [myFlickerAPI connectToFlickr:flickrURLString];

	NSLog(@"%@", incomingArray);

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
    NSLog(@"lat:%f - long:%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [self updatePersonalCoordinates:newLocation.coordinate];
    newLatitude=newLocation.coordinate.latitude;
    newLongitude=newLocation.coordinate.longitude;
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

-(void) finished:(NSMutableArray*) myArray;
{
    myFlickerAPI.myPhotos=myArray;
    incomingArray = myArray;
    
    for (int i =0; i<[incomingArray count]; i++) {
        CLLocationCoordinate2D mmCoordinate =
        {
            .latitude = [[[incomingArray objectAtIndex:i]valueForKey:@"latitude"] floatValue] ,
            .longitude = [[[incomingArray objectAtIndex:i]valueForKey:@"longitude"] floatValue]
        };
        
        MKCoordinateSpan defaultSpan =
        {
            .latitudeDelta = 0.2f,
            .longitudeDelta =0.2f
        };
        
        MKCoordinateRegion myRegion = {mmCoordinate, defaultSpan};
        
        myAnnotation = [[MMAnnotation alloc]init];
        myAnnotation.coordinate = mmCoordinate;
        myAnnotation.title =[[incomingArray objectAtIndex:i]valueForKey:@"title"];
        myAnnotation.subtitle =@"NSAwesome Lives Here!";
        
        [myMapView setRegion:myRegion];
        [myMapView addAnnotation:myAnnotation];
        [self performSelectorOnMainThread:@selector(reloadMap) withObject:nil waitUntilDone:FALSE];
    }
}

-(void) reloadMap
{
    [myMapView setRegion:myMapView.region animated:TRUE];
}


@end
