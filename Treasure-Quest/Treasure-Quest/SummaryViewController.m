//
//  SummaryViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "SummaryViewController.h"
#import "FoursquareAPI.h"

@interface SummaryViewController ()

@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *token = @"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY";
    
    if (token)
    {
        [FoursquareAPI getFoursquareData:@"query" completionHandler:^(NSArray *results, NSError *error) {
            if (error)
            {
                NSLog(@"%@", error.localizedDescription);
            }
            self.searchResults = results;
        }];
    }
}

@end
