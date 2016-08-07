//
//  FoursquareAPI.h
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^foursquareFetchCompletion)(NSArray *results, NSError *error);

@interface FoursquareAPI : NSObject

@property (strong, nonatomic)NSString* name;
@property (strong, nonatomic)NSString* location;
@property (strong, nonatomic)NSString* id;

+(void)getFoursquareData:(NSString *)userData completionHandler:(foursquareFetchCompletion)completionHandler;


@end
