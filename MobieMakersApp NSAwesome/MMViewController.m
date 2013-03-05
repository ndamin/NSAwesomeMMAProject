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

@interface MMViewController ()
{
    __weak IBOutlet UITableView *photoResultsTable;
    NSDictionary *flickrPicResults;
    NSArray *flickrPic;
    MMAnnotation *myAnnotation;
    CLLocationDegrees newLatitude;
    CLLocationDegrees newLongitude;
}


@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startLocationUpdates];
    
}

//CONNECTS TO FLICKR API
-(void)flickrPicMethod
{
    NSString *flickrURLString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=82086ce95c1c5c816d22e7bc81888c57&lat=%f&lon=%f&radius=30&extras=geo&per_page=20&format=json&nojsoncallback=1",newLatitude,newLongitude];
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
    NSMutableURLRequest *flickrURLRequest = [NSMutableURLRequest requestWithURL:flickrURL];
    flickrURLRequest.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^ void(NSURLResponse *myResponse, NSData *myData, NSError *theirError)
     {
         [self findFlickrPhotoInfo:myResponse Data:myData Error:theirError];
     }];
    

}

-(void)findFlickrPhotoInfo:(NSURLResponse*) myResponse
                      Data:(NSData*) myData
                     Error:(NSError*) theirError
{
    {
        //This is where our code goes... We've got a block!
        if (theirError) {
            NSLog(@"%@", theirError.localizedDescription);
            
        } else {
            
            NSError *jsonError;
            id genericObjectThatIKnowIsAnArray = [NSJSONSerialization JSONObjectWithData:myData
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:&jsonError];
            
            flickrPicResults = (NSDictionary *) genericObjectThatIKnowIsAnArray;
            
            NSDictionary *flickrLayerDictionary = [flickrPicResults valueForKey:@"photos"];
            flickrPic = [flickrLayerDictionary valueForKey:(@"photo")];
            
            NSLog(@"%@", flickrPic);
            
            [photoResultsTable reloadData];
        }
    };
}

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
//    [awesomeLocationManager startUpdatingLocation];
    [awesomeLocationManager startMonitoringSignificantLocationChanges];
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
    newLatitude=newCoordinate.latitude;
    newLongitude=newCoordinate.longitude;
    
    [self flickrPicMethod];
    
}


    
//******************************Code to look at for when we move to mapView********************************
    
//    NSString *flickrURLString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=55ead9bd9fa6e1d0223fa46242fb58f0&lat=%f&lon=%f&radius=30&extras=geo&format=json&nojsoncallback=1",newLatitude,newLongitude];
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
    


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"mapSegue"]) {
//        MMMapViewController *mvc= [segue destinationViewController];
//        NSIndexPath *path = [photoResultsTable indexPathForSelectedRow];
//        NSDictionary *flickrPhotoRecord1 =[flickrPic objectAtIndex:path.row];
//        
//        NSString *idString=[flickrPhotoRecord1 valueForKey:@"id"];
//        NSString *serverString=[flickrPhotoRecord1 valueForKey:@"server"];
//        NSString *farmString=[flickrPhotoRecord1 valueForKey:@"farm"];
//        NSString *secretString=[flickrPhotoRecord1 valueForKey:@"secret"];
//        NSString *latitudeString=[flickrPhotoRecord1 valueForKey:@"latitude"];
//        NSString *longitudeString=[flickrPhotoRecord1 valueForKey:@"longitude"];
//        
//        NSString *photoURLString=[NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",farmString,serverString,idString,secretString];
//        
//        
//        mvc.photoString=photoURLString;
//        
//        
//    }
//    
//}
//************************End of test Code*****************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
