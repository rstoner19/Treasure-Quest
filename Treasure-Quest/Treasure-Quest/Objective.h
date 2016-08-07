//
//  Objective.h
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Objective : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSNumber *range;
@property Boolean completed;
@property CLLocation *location;

+(instancetype)initWith: (NSString *)name imageURL:(NSString *)imageURL info:(NSString *)info category: (NSString *)category range: (NSNumber *)range latitude:(double)lat longitude:(double)lon;


@end
