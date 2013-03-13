//
//  HistoryOfPhotos.h
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 3/13/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryOfPhotos : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * photoURL;

@end
