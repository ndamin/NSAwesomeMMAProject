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

@interface MMViewController : UIViewController 
{
    CLLocationManager *awesomeLocationManager;
}
-(void)savedArrayOfPhotos:(NSMutableArray*)flickPhotoDatas;



@end
