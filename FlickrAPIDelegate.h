//
//  FlickrAPIDelegate.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 3/7/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlickrAPIDelegate <NSObject>

@required

-(void) finished:(NSMutableArray*) myArray;


@end
