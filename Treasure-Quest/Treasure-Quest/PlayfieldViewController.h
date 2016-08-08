//
//  PlayfieldViewController.h
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quest.h"

@interface PlayfieldViewController : UIViewController

@property(strong, nonatomic)NSString *questName;
@property(strong, nonatomic)NSString *gameDescription;
@property(strong, nonatomic)NSNumber *players;
@property(strong, nonatomic)NSNumber *objectives;


@end
