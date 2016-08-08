//
//  SetupViewController.m
//  Treasure-Quest
//
//  Created by Rick  on 8/4/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "SetupViewController.h"
#import "ViewController.h"
#import "PlayfieldViewController.h"

@interface SetupViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic)UIBarButtonItem *nextButton;

@property (weak, nonatomic) IBOutlet UITextField *questNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *questDesciptionTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *playersPickerView;


@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView {
    self.playersPickerView.delegate = self;
    self.playersPickerView.dataSource = self;
    self.playersPickerData = @[@"1", @"2", @"3", @"4", @"5", @"6"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayFieldViewController"]) {
        NSNumber *players = [self.playersPickerData objectAtIndex:[self.playersPickerView selectedRowInComponent:0]];
        NSString *questName = self.questNameTextField.text;
        NSString *description = self.questDesciptionTextField.text;
        
        PlayfieldViewController *playfieldViewController = (PlayfieldViewController *)segue.destinationViewController;
        playfieldViewController.players = players;
        if ([questName isEqualToString:@""]) {
            playfieldViewController.questName = @"My Quest";
        } else { playfieldViewController.questName = questName; }
        if ([description isEqualToString:@""]) {
            playfieldViewController.gameDescription = @"A race to find the locations first!";
        } else { playfieldViewController.gameDescription = description; }
    }
    
}

#pragma mark - PickerView Datasource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.playersPickerData.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.playersPickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

}


@end
