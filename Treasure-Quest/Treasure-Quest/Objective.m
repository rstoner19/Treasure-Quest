//
//  Objective.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/5/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Objective.h"

@implementation Objective

+(instancetype)initWith: (NSString *)name imageURL:(NSString *)imageURL info:(NSString *)info category: (NSString *)category range: (NSNumber *)range location:(CLLocationCoordinate2D)location {
    
    Objective *newObjective = [[Objective alloc]init];
    newObjective.name = name;
    newObjective.imageURL = imageURL;
    newObjective.info = info;
    newObjective.category = category;
    newObjective.location = location;
    newObjective.completed = NO;
    

    return newObjective;
}


@end
