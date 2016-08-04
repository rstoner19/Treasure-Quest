//
//  ProgressListViewController.m
//  Treasure-Quest
//
//  Created by Michael Sweeney on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "ProgressListViewController.h"
#import "Quest.h"
#import "Player.h"

@interface ProgressListViewController () <UITableViewDelegate, UITableViewDataSource>

- (IBAction)backButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Quest *currentQuest;

@end

@implementation ProgressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //GET quest
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //TODO: fill in logic
    return cell;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //TODO: fill in datasource count
    return 0;
}

- (IBAction)backButton:(UIButton *)sender {
}
@end
