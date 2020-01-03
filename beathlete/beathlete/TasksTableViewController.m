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
@interface TasksTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
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
    self.navigationItem.title=NSLocalizedString(@"Press to mark as done", nil);
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

    
    if(self.trainingTasksArray[indexPath.row].taskDone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.trainingTasksArray[indexPath.row].taskDone=false;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.trainingTasksArray[indexPath.row].taskDone=true;
    }
    [self.delegate saveContext];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        TrainingTasks *trainingTask = self.trainingTasksArray[indexPath.row];
        [self.context deleteObject:trainingTask];
        [self.delegate saveContext];
        [self fetchAllTrainingTasks];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"AddTrainingTasks"]){
     TaskAddViewController *controller=(TaskAddViewController*)segue.destinationViewController;
     Trainings *selectedTraining= self.trainingRoot;
     controller.self.trainingTaskRoot=selectedTraining;
    }/*else if ([segue.identifier isEqualToString:@"EditTrainingTasks"]){
        TaskAddViewController *controller=(TaskAddViewController*)segue.destinationViewController;
        Trainings *selectedTraining= self.trainingRoot;
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
        TrainingTasks *selectedTrainingTaskToEdit = self.trainingTasksArray[indexPath.row];
        controller.trainingTaskToEdit=selectedTrainingTaskToEdit;
        controller.trainingTaskRoot=selectedTraining;
    }
    */
    
}


@end
