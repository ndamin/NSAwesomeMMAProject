//
//  MMViewController.h
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 2/25/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Photo.h"
#import "FlickrAPIDelegate.h"

@interface MMViewController : UIViewController <FlickrAPIDelegate>
{
    CLLocationManager *awesomeLocationManager;
}

@property (strong, nonatomic) NSManagedObjectContext *myManagedObjectContext;


-(void)savedArrayOfPhotos:(NSMutableArray*)flickPhotoDatas;



@end
