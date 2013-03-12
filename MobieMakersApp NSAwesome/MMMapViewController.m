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
    [self startLocationUpdates];
}

//Notifies the view controller that its view was added to a view hierarchy.  Runs after viewDidLoad.  Placed this in here b/c the map was showing up incorrectly and required a reload.  The enables the map to re-load once, therefore not requiring a reload.  Animated Indicates it can be changed.
//WE DO NOT KNOW WHAT THIS EXACTLY DOES.  
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self startLocationUpdates];
    
    
    //instantiating FlickrAPI object
    myFlickerAPI = [[FlickrAPI alloc] init];
    //setting MMMapViewController as the delegate of the FlickrAPI object.
    myFlickerAPI.delegate = self;
    
    //Declaring and setting NSString object to a URLString to feed into our API call.
    //NSString object takes in float values newLatitude and newLongitude.
    NSString *flickrURLString =[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d251dca82f1f85f0b3de7d64bdb18e03&lat=%f&lon=%f&radius=30&extras=geo&per_page=20&format=json&nojsoncallback=1",newLatitude,newLongitude];
    
    //Passing in flickrURLString into class method "connectToFlickr"
    [myFlickerAPI connectToFlickr:flickrURLString];
    
    //User---->Switch to FlickrAPI class to follow the flow

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


//method from FlickrAPIDelegate that takes in a NSMutableArray and determines each picture coordinate to place on the map.
-(void) finished:(NSMutableArray*) myArray;
{
    //setting myFlickrAPI.myphotos array to myArray
    myFlickerAPI.myPhotos=myArray;
    //setting incomingArray to myArray
    incomingArray = myArray;
    
    //For loop that goes through the incommingArray and sets coordinates for each photo to place onto the map.
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
        
        
        //setting our map region with our established CLLLocationCoordinate and MKCoordinateSpan
        MKCoordinateRegion myRegion = {mmCoordinate, defaultSpan};
        
        
        //instantiation of myAnnotation, and setting coordinate, title, and subtitle of the object
        myAnnotation = [[MMAnnotation alloc]init];
        myAnnotation.coordinate = mmCoordinate;
        myAnnotation.title =[[incomingArray objectAtIndex:i]valueForKey:@"title"];
        myAnnotation.subtitle =@"NSAwesome Lives Here!";
        
        //set myMapView region to myRegion, adding the annotation myAnnotation
        [myMapView setRegion:myRegion];
        [myMapView addAnnotation:myAnnotation];

    }
}

-(void) reloadMap
{
    [myMapView setRegion:myMapView.region animated:TRUE];
}


@end
