//
//  YelpMapViewController.m
//  MobieMakersApp NSAwesome
//
//  Created by Ian Blue on 3/4/13.
//  Copyright (c) 2013 Ian Blue. All rights reserved.
//

#import "YelpMapViewController.h"
#import <YelpKit/YelpKit.h>

@interface YelpMapViewController ()
{
    NSDictionary *yelpObjectDict;
    NSArray *yelpBusinessArray;
    NSDictionary *yelpItemsDict;
    NSDictionary *yelpName;
    NSDictionary *yelpAddress;
    //We need to instanciate these below
    NSDictionary *yelpPhone;
    NSDictionary *yelpLatitude;
    NSDictionary *yelpLongitude;
    NSDictionary *yelpReviewCount;
    NSDictionary *yelpRatingURL;
    NSDictionary *yelpIsClosed;
}

@end

@implementation YelpMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self yelpConnectionMethod];
}

- (void)yelpConnectionMethod
{
    NSString *yelpURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?term=restaurants&lat=41.894032&long=-87.634742&radius=10&limit=20&ywsid=05IugMsft6wGtb0DNA4e0w"];

    YKURL *yelpURL = [YKURL URLWithURLString:yelpURLString];
               [YKJSONRequest requestWithURL:yelpURL
                                 finishBlock: ^void(id myData)
                      {
                          yelpObjectDict = (NSDictionary *)myData;
                          yelpBusinessArray = [yelpObjectDict objectForKey:@"businesses"];
                          yelpItemsDict = [yelpBusinessArray objectAtIndex:0];
                          
                          yelpName = [yelpItemsDict objectForKey:@"name"];
                          yelpAddress = [yelpItemsDict objectForKey:@"address1"];
                          
                          
                          NSLog(@"name is %@ and address is %@", yelpName, yelpAddress);
                      }
                        failBlock:^void(YKHTTPError *error)
                      {
                        
                      }
     ];
    
    NSLog(@"I will run next");
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
