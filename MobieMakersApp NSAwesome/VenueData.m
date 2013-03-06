//
//  VenueData.m
//  MobieMakersApp NSAwesome
//
//  Created by RHINO on 3/6/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "VenueData.h"
#import <YelpKit/YelpKit.h>

@implementation VenueData

- (void)yelpConnectionMethod
{
    NSString *yelpURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?term=restaurants&lat=41.894032&long=-87.634742&radius=10&limit=20&ywsid=05IugMsft6wGtb0DNA4e0w"];
    
    YKURL *yelpURL = [YKURL URLWithURLString:yelpURLString];
    [YKJSONRequest requestWithURL:yelpURL
                      finishBlock: ^void(id myData)
     {
         yelpObjectDict = (NSDictionary *)myData;
         yelpBusinessArray = [yelpObjectDict objectForKey:@"businesses"];
         yelpItemsDict = [yelpBusinessArray objectAtIndex:0];
         
         yelpName = [yelpItemsDict objectForKey:@"name"];
         yelpAddress = [yelpItemsDict objectForKey:@"address1"];
         yelpPhone = [yelpItemsDict objectForKey:@"phone"];
         yelpLatitude = [yelpItemsDict objectForKey:@"latitude"];
         yelpLongitude = [yelpItemsDict objectForKey:@"longitude"];
         yelpReviewCount = [yelpItemsDict objectForKey:@"review_count"];
         yelpIsClosed = [yelpItemsDict objectForKey:@"is_closed"];
         yelpRatingURL = [yelpItemsDict objectForKey:@"rating_img_url_small"];
         
         NSLog(@"name is %@ and address is %@", yelpName, yelpAddress);
     }
                        failBlock:^void(YKHTTPError *error)
     {
         
     }
     ];
    
    NSLog(@"I will run next");
    
}

@end
