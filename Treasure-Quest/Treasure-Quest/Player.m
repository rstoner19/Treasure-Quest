//
//  Player.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Player.h"

@implementation Player


@dynamic currentLocation;
@dynamic user;
@dynamic speed;



+(void)load{
    [self registerSubclass];
    
}

+(NSString *)parseClassName{
    return @"Player";
}


@end
