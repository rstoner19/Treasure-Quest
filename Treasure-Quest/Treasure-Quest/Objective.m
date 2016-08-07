//
//  Objective.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Objective.h"

@implementation Objective

+(instancetype)initWith: (NSString *)name imageURL:(NSString *)imageURL info:(NSString *)info category: (NSString *)category range: (NSNumber *)range latitude:(double)lat longitude:(double)lon{
    
    Objective *newObjective = [[Objective alloc]init];
    newObjective.name = name;
    newObjective.imageURL = imageURL;
    newObjective.info = info;
    newObjective.category = category;
    newObjective.location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];

    return newObjective;
}


@end
