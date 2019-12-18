//
//  TasksTableViewController.m
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TasksTableViewController.h"
@import CoreData;
#import "AppDelegate.h"
#import "TrainingTasks+CoreDataClass.h"
#import "TaskAddViewController.h"
@interface TasksTableViewController ()<UITableViewDataSource>{
}
@property (nonatomic) NSSet<TrainingTasks*>* trainingTasks;
@property (nonatomic) NSArray<TrainingTasks*>* trainingTasksArray;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    if(self.trainingRoot!=nil){
         [self fetchAllTrainingTasks];
     }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllTrainingTasks];
    [self.tableView reloadData];

}
-(void)fetchAllTrainingTasks{
    self.trainingTasks=self.trainingRoot.trainingTasks;
    self.trainingTasksArray =[self.trainingTasks allObjects];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.trainingTasksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTask" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=self.trainingTasksArray[indexPath.row].taskName;
    cell.detailTextLabel.text=self.trainingTasksArray[indexPath.row].taskDescription;
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        Trainings *training = self.trainings[indexPath.row];
        [self.context deleteObject:training];
        [self.delegate saveContext];
        [self fetchAllTrainings];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"AddTrainingTasks"]){
     TaskAddViewController *controller=(TaskAddViewController*)segue.destinationViewController;
     Trainings *selectedTraining= self.trainingRoot;
     controller.self.trainingTaskRoot=selectedTraining;
    }
}


@end
