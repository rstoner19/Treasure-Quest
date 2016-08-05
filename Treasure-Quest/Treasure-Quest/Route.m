//
//  Route.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Route.h"

@implementation Route


+(void)load{
    [self registerSubclass];
    
}

+(NSString *)parseClassName{
    return @"Route";
}


@end
