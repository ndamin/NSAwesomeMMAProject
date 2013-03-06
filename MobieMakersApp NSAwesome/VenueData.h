//
//  VenueData.h
//  MobieMakersApp NSAwesome
//
//  Created by RHINO on 3/6/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueData : NSObject
{
    NSDictionary *yelpObjectDict;
    NSArray *yelpBusinessArray;
    NSDictionary *yelpItemsDict;
    NSString *yelpName;
    NSString *yelpAddress;
    NSString *yelpPhone;
    NSString *yelpLatitude;
    NSString *yelpLongitude;
    NSString *yelpReviewCount;
    NSString *yelpIsClosed;
    NSURL *yelpRatingURL;
}

@end
