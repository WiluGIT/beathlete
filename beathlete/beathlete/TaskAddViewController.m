//
//  TaskAddViewController.m
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TaskAddViewController.h"
@import CoreData;
#import "AppDelegate.h"
#import "TrainingTasks+CoreDataClass.h"

@interface TaskAddViewController ()
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *exerciseDetailsTextField;

@end

@implementation TaskAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
}
- (IBAction)saveTrainingTask:(id)sender {
    NSString *taskName=self.exerciseNameTextField.text;
    NSString *taskDescription=self.exerciseDetailsTextField.text;
    TrainingTasks *task =[[TrainingTasks alloc] initWithContext:self.context];
    task.taskName=taskName;
    task.taskDescription=taskDescription;
    task.taskDone=false;
    task.training=self.trainingTaskRoot;
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
