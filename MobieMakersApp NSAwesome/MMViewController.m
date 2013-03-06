//
//  MMViewController.m
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 2/25/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "MMViewController.h"
#import "MMMapViewController.h"
#import "MMAnnotation.h"
#import "Photo.h"
#import "FlickrAPI.h"

@interface MMViewController ()
{
    __weak IBOutlet UITableView *photoResultsTable;
    NSDictionary *flickrPicResults;
    NSArray *flickrPic;
    MMAnnotation *myAnnotation;
    CLLocationDegrees newLatitude;
    CLLocationDegrees newLongitude;
    MMMapViewController *mvc;
    FlickrAPI *flickrAPITable;
}

@property (strong,nonatomic) Photo *currentPhoto;
@property (strong,nonatomic) NSMutableArray *myPhotos;
@property (strong, nonatomic) NSMutableArray *flickPhotoDatas;



@end

@implementation MMViewController

@synthesize currentPhoto;
@synthesize myPhotos;
@synthesize flickPhotoDatas;

- (void)viewDidLoad
{
    myPhotos=[[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    [self startLocationUpdates];
    
    
}

//CONNECTS TO FLICKR API
//-(void)flickrPicMethod
//{
//    NSString *flickrURLString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d251dca82f1f85f0b3de7d64bdb18e03&lat=%f&lon=%f&radius=30&extras=geo&per_page=20&format=json&nojsoncallback=1",newLatitude,newLongitude];
//    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
//    NSMutableURLRequest *flickrURLRequest = [NSMutableURLRequest requestWithURL:flickrURL];
//    flickrURLRequest.HTTPMethod = @"GET";
//    
//    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^ void(NSURLResponse *myResponse, NSData *myData, NSError *theirError)
//     {
//         [self findFlickrPhotoInfo:myResponse Data:myData Error:theirError];
//     }];
//    
//
//}
//
//-(void)findFlickrPhotoInfo:(NSURLResponse*) myResponse
//                      Data:(NSData*) myData
//                     Error:(NSError*) theirError
//{
//    {
//        //This is where our code goes... We've got a block!
//        if (theirError) {
//            NSLog(@"%@", theirError.localizedDescription);
//            
//        } else {
//            
//            NSError *jsonError;
//            id genericObjectThatIKnowIsAnArray = [NSJSONSerialization JSONObjectWithData:myData
//                                                                                 options:NSJSONReadingAllowFragments
//                                                                                   error:&jsonError];
//            
//            flickrPicResults = (NSDictionary *) genericObjectThatIKnowIsAnArray;
//            
//            NSDictionary *flickrLayerDictionary = [flickrPicResults valueForKey:@"photos"];
//            flickrPic = [flickrLayerDictionary valueForKey:(@"photo")];
//            
//            NSLog(@"%@", flickrPic);
//            
//            
//            for (int i =0; i<[flickrPic count]; i++) {
//                currentPhoto=[[Photo alloc]init];
//                currentPhoto.latitude=[(NSNumber*)[[flickrPic objectAtIndex:i]valueForKey:@"latitude"] floatValue];
//                currentPhoto.longitude = [(NSNumber *)[[flickrPic objectAtIndex:i]valueForKey:@"longitude"]floatValue];
//                currentPhoto.title = [[flickrPic objectAtIndex:i]valueForKey:@"title"];
//                [myPhotos addObject:currentPhoto];
//                
//            }
//            [photoResultsTable reloadData];
//        }
//    };
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [flickrPic count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCustomCell = [tableView dequeueReusableCellWithIdentifier:@"photoCellIdentifier"];
    
    NSDictionary *actualPhotoDictionary = [flickrPic objectAtIndex:[indexPath row]];
    NSString *farmString = [actualPhotoDictionary valueForKey:@"farm"];
    NSString *serverString = [actualPhotoDictionary valueForKey:@"server"];
    NSString *idString = [actualPhotoDictionary valueForKey:@"id"];
    NSString *secretString = [actualPhotoDictionary valueForKey:@"secret"];
    NSString *fullPhotoString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_n.jpg" ,farmString,serverString, idString, secretString];
    
    NSURL *photoURL = [NSURL URLWithString:fullPhotoString];
    NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
    UIImage *photoImage = [UIImage imageWithData:photoData];
    UIView *photoView = [myCustomCell viewWithTag:25];
    UIImageView *photoImageView = (UIImageView *) photoView;
    photoImageView.image = photoImage;
    
    NSString *picLabel = [actualPhotoDictionary valueForKey:@"title"];
    UIView *actualPicLabel= [myCustomCell viewWithTag:26];
    UILabel *flickrPhotoLabel = (UILabel*) actualPicLabel;
    flickrPhotoLabel.text = picLabel;
    
    return myCustomCell;
}

- (void)startLocationUpdates
{
    if (awesomeLocationManager==nil) {
        awesomeLocationManager = [[CLLocationManager alloc]init];
    }
    awesomeLocationManager.delegate = self;
    
    //firehose of updates
    //[awesomeLocationManager startUpdatingLocation];
    [awesomeLocationManager startMonitoringSignificantLocationChanges];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"lat:%f - long:%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [self updatePersonalCoordinates:newLocation.coordinate];
}

- (void)updatePersonalCoordinates:(CLLocationCoordinate2D)newCoordinate
{
    flickrAPITable=[[FlickrAPI alloc]init];
    myAnnotation.coordinate = newCoordinate;
    //NSLog(@"updatePersonalCoordinates: Lat:%f - Long:%f", newCoordinate.latitude,newCoordinate.longitude);
    newLatitude=newCoordinate.latitude;
    newLongitude=newCoordinate.longitude;
    
    NSString *flickrURLString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d251dca82f1f85f0b3de7d64bdb18e03&lat=%f&lon=%f&radius=30&extras=geo&per_page=20&format=json&nojsoncallback=1",newLatitude,newLongitude];
    [flickrAPITable connectToFlickr:flickrURLString];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imageModalSegue"])
    {
        mvc = [segue destinationViewController];
        mvc.incomingArray = self.myPhotos;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
