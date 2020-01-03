//
//  ExerciseDetailViewController.m
//  beathlete
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ExerciseDetailViewController.h"

@interface ExerciseDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *ytLinkButton;


@end

@implementation ExerciseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=NSLocalizedString(@"Exercise Detail", nil);

    if(self.exerciseToShowDetail!=nil){
        [self fetchExerciseDetails];
    }
        
}

-(void)fetchExerciseDetails{
    self.exerciseNameLabel.text=self.exerciseToShowDetail.exerciseName;
    self.exerciseDescriptionLabel.text=self.exerciseToShowDetail.exerciseDescription;
    [self.exerciseDescriptionLabel sizeToFit];
}
- (IBAction)openYouTube:(id)sender {
    NSURL *url = [NSURL URLWithString:self.exerciseToShowDetail.hyperlink];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
