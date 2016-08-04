//
//  ViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Test record creation on server
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"dog"] = @"nova";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        
//        if (!error) {
//            [NSOperationQueue mainQueue]addOperationWithBlock:^{
//                //            NSLog(@"Success!");
//
//            }
//
//        } else {
//            NSLog(@"ERROR: %@", error.localizedDescription);
//        }
//        
//        
//    }];

}

@end
