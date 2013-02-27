//
//  MMAnnotation.h
//  MobieMakersApp NSAwesome
//
//  Created by Nirav Amin on 2/27/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MMAnnotation : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;


@end
