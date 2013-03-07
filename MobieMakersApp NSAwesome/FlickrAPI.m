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

-(NSMutableArray*)connectToFlickr:(NSString*)urlString
{
    
    NSURL *flickrURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *flickrURLRequest =[NSMutableURLRequest requestWithURL:flickrURL];
    flickrURLRequest.HTTPMethod =@"GET";
    
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void (NSURLResponse *myResponse, NSData *myData, NSError *myError)
                            {
                                if (myError)
                                {
                                    NSLog(@"%@",myError.localizedDescription);
                                }
                                NSError *jsonError;
                                id jsonObject =[NSJSONSerialization JSONObjectWithData:myData
                                                                               options:NSJSONReadingAllowFragments
                                                                                 error:&jsonError];
                                NSDictionary *flickrDictionary = (NSDictionary*)jsonObject;
                                NSArray * flickrAPIArray;
                                flickrAPIArray = [[NSArray alloc]init];;
                                flickrAPIArray=[[flickrDictionary valueForKey:@"photos"]valueForKey:@"photo"];
                              
                                
                                for (int i =0; i<[flickrAPIArray count]; i++)
                                {
                                    Photo *currentPhoto;
                                    currentPhoto = [[Photo alloc]init];
                                    currentPhoto.latitude=[(NSNumber*)[[flickrAPIArray objectAtIndex:i]valueForKey:@"latitude"]floatValue];
                                    currentPhoto.longitude=[(NSNumber*)[[flickrAPIArray objectAtIndex:i]valueForKey:@"longitude"]floatValue];
                                    currentPhoto.title=[[flickrAPIArray objectAtIndex:i]valueForKey:@"title"];
                                    myPhotos =[[NSMutableArray alloc]init];
                                    [myPhotos addObject:currentPhoto];
                                }
                                
                                
                            }];
}


@end
