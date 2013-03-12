//
//  FlickrAPI.m
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 3/6/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "FlickrAPI.h"
#import "Photo.h"

@implementation FlickrAPI

@synthesize myPhotos;
@synthesize delegate;


//FlickrAPI class houses a method, connectToFlickr, which takes an NSString, connects to the FlickrAPI, gets the needed data and translates it to a usable table for our application to extract data from.
-(void)connectToFlickr:(NSString*)urlString
{
    //Declaring and setting NSURL object which takes in a urlString and converts it to a URL
    NSURL *flickrURL = [NSURL URLWithString:urlString];
    //Declaring and setting NSMutableURLReqeust which takes in a URL and converst it to a URL Request
    NSMutableURLRequest *flickrURLRequest =[NSMutableURLRequest requestWithURL:flickrURL];
    
    //method call which allows API call to "get" data
    flickrURLRequest.HTTPMethod =@"GET";
    
    //Calling class method sendAsynchronousRequest... on NSURLConnection
    //Takes in 3 parameters: flickrURLRequest for sendAsynchrounousRequest, class method mainQueue of NSOperationQueue for queue, block for completionHandler (see block below)
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                            //Block parameter that returns nothing and takes in a NSURLResponse object, NSData Object, and NSError object from the HTTPMethod call from above
                           completionHandler:^void (NSURLResponse *myResponse, NSData *myData, NSError *myError)
                            {
                                //if statement that checks for errors.  If errors exist, a log message is returned as stated below.
                                if (myError)
                                {
                                    NSLog(@"%@",myError.localizedDescription);
                                }
                                
                                //Declaring jsonError to use in class method below
                                NSError *jsonError;
                                
                                //Class method on NSJSONSerioalization that takes in JSON Data and creates a foundation that can be fed into the generic object declared as jsonObject.
                                id jsonObject =[NSJSONSerialization JSONObjectWithData:myData
                                                                               options:NSJSONReadingAllowFragments
                                                                                 error:&jsonError];
                                //typecasting jsonObject as a Dictionary
                                NSDictionary *flickrDictionary = (NSDictionary*)jsonObject;
                                
                                //Declaration, instantiation, and drilling through flickrDictionary data to setup flickrAPIArray
                                NSArray * flickrAPIArray;
                                flickrAPIArray = [[NSArray alloc]init];
                                flickrAPIArray=[[flickrDictionary valueForKey:@"photos"]valueForKey:@"photo"];
                                //instantiation of myPhotos array
                                myPhotos =[[NSMutableArray alloc]init];
                              
                                //For loop that runs through flickrAPIArray, collects needed data, and places into a Photo object, currentPhoto.
                                for (int i =0; i<[flickrAPIArray count]; i++)
                                {
                                    Photo *currentPhoto;
                                    currentPhoto = [[Photo alloc]init];
                                    currentPhoto.latitude=[(NSNumber*)[[flickrAPIArray objectAtIndex:i]valueForKey:@"latitude"]floatValue];
                                    currentPhoto.longitude=[(NSNumber*)[[flickrAPIArray objectAtIndex:i]valueForKey:@"longitude"]floatValue];
                                    currentPhoto.title=[[flickrAPIArray objectAtIndex:i]valueForKey:@"title"];
                                    [myPhotos addObject:currentPhoto];
                                }
                                
                                //Execute method, "finished", on the delegate, taking in myPhotos array
                                //Delegate is MMMapViewController
                                //User----->Go to MMMapViewController to the method "finsihed".
                                [delegate finished:myPhotos];
                                
                            }];
}




@end
