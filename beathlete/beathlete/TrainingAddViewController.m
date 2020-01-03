//
//  TrainingAddViewController.m
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TrainingAddViewController.h"
#import "Trainings+CoreDataClass.h"
@import CoreData;
#import "AppDelegate.h"

@interface TrainingAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *trainingNameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *trainingDatePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *trainingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainingDateLabel;

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;

@end

@implementation TrainingAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=NSLocalizedString(@"Add Training", nil);
    self.trainingNameLabel.text=NSLocalizedString(@"Training name", nil);
    self.trainingDateLabel.text=NSLocalizedString(@"Training date", nil);
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    // Do any additional setup after loading the view.
}
- (IBAction)saveTraining:(id)sender {
    NSString *trName=self.trainingNameTextField.text;
    NSDate *trDate=self.trainingDatePicker.date;
    Trainings *training =[[Trainings alloc] initWithContext:self.context];
    training.name=trName;
    training.date=trDate;
    [self.delegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
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
