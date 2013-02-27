//
//  FlickrPhotoAPI.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 2/26/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlickrAPIDelegate <NSObject>

@required

-(void)flickrPicMethod;
-(void)findFlickrPhotoInfo:(NSURLResponse*) myResponse
                    myData:(NSData*) myData
                theirError:(NSError*) theirError;

@end

@interface FlickrPhotoAPI : NSObject

@end
