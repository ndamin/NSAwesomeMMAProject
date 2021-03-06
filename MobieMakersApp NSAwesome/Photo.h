//
//  Photo.h
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 2/25/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (strong, nonatomic) NSString *picID;
@property (strong, nonatomic) NSString *farmID;
@property (strong, nonatomic) NSString *serverID;
@property (strong, nonatomic) NSString *secret;

@property (strong, nonatomic) NSString *photoURL;

@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;
@property (strong, nonatomic) NSString *title;

@end
