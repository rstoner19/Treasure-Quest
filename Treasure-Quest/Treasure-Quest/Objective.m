//
//  Objective.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Objective.h"

@interface Objective ()


@end

@implementation Objective
@dynamic name;
@dynamic imageURL;
@dynamic info;
@dynamic category;
@dynamic completed;
//@dynamic location;
@dynamic range;
@dynamic latitude;
@dynamic longitude;


+(void)load{
    [self registerSubclass];
    
}

+(NSString *)parseClassName{
    return @"Objective";
}







+(instancetype)initWith: (NSString *)name imageURL:(NSString *)imageURL info:(NSString *)info category: (NSString *)category range: (NSNumber *)range latitude:(double)lat longitude:(double)lon{

    Objective *newObjective = [[Objective alloc]init];
    newObjective.name = name;
    newObjective.imageURL = imageURL;
    newObjective.info = info;
    newObjective.category = category;
    newObjective.completed = NO;
    //newObjective.location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
    newObjective.latitude = lat;
    newObjective.longitude = lon;

    return newObjective;
}


@end
