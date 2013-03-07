//
//  FlickrAPI.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 3/6/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrAPI : NSObject

@property (strong, nonatomic)NSMutableArray *myPhotos;


-(NSMutableArray*)connectToFlickr:(NSString*)urlString;

@end
