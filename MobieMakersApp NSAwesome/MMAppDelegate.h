//
//  MMAppDelegate.h
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 2/25/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectModel *myManagedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *myManagedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *myPersistentStoreCoordinator;

@end
