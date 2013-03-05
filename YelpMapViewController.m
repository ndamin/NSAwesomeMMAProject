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
    NSString *yelpURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?term=restaurants&lat=41.894032&long=-87.634742&radius=10&limit=5&ywsid=05IugMsft6wGtb0DNA4e0w"];

    YKURL *yelpURL = [YKURL URLWithURLString:yelpURLString];
    [YKJSONRequest requestWithURL:yelpURL
                      finishBlock: ^void(id myData)
                      {
                          NSLog(@"%@", myData);
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
