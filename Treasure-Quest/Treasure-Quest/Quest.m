//
//  Quest.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "Quest.h"

@implementation Quest

+(void)load{
    [self registerSubclass];
    
}

+(NSString *)parseClassName{
    return @"Quest";
}

@end
