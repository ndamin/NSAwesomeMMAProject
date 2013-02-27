//
//  MMViewController.m
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 2/25/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "MMViewController.h"
#import "MMMapViewController.h"

@interface MMViewController ()
{
    __weak IBOutlet UITableView *photoResultsTable;
    NSDictionary *flickrPicResults;
    NSArray *flickrPic;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self flickrPicMethod];
    
}


-(void)flickrPicMethod
{
    NSString *flickrURLString = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=84961b9f40aa1b75245e0802ab029191&lat=41.894032&lon=-87.634742&radius=3&extras=geo&format=json&nojsoncallback=1&api_sig=5a831bbfc80dee3a3fe8b2dbbb61b9a2";
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
    if (flickrPic == nil) {
        return 0;
    } else {
        return 20;
    }
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
