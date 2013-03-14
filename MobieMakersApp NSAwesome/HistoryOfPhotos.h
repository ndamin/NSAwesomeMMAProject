//
//  HistoryOfPhotos.h
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 3/14/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryOfPhotos : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * title;

@end
