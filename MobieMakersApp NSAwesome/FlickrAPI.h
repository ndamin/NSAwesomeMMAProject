//
//  FlickrAPI.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 3/6/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrAPIDelegate.h"



@interface FlickrAPI : NSObject
{
}

@property (strong, nonatomic)NSMutableArray *myPhotos;
@property (strong, nonatomic)id<FlickrAPIDelegate> delegate;


-(void)connectToFlickr:(NSString*)urlString;

@end
