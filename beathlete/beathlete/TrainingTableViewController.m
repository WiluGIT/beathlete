//
//  TrainingTableViewController.m
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TrainingTableViewController.h"
#import "Trainings+CoreDataClass.h"
@import CoreData;
#import "AppDelegate.h"
#import "TasksTableViewController.h"

@interface TrainingTableViewController ()<UITableViewDataSource>{
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@property (nonatomic) NSArray <Trainings*>* trainings;
@end

@implementation TrainingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    // Do any additional setup after loading the view.
    [self fetchAllTrainings];
}
-(void) fetchAllTrainings{
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Trainings"];
    self.trainings=[self.context executeFetchRequest:request error:nil];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllTrainings];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.trainings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTraining" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=self.trainings[indexPath.row].name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *newDate = [dateFormatter stringFromDate:self.trainings[indexPath.row].date];
    cell.detailTextLabel.text=newDate;

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        Trainings *training = self.trainings[indexPath.row];
        NSSet<TrainingTasks*>* trainingTasksToDelete=training.trainingTasks;
        for (TrainingTasks *task in trainingTasksToDelete) {
            [self.context deleteObject:task];
        }
        [self.context deleteObject:training];
        [self.delegate saveContext];
        [self fetchAllTrainings];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
       if([segue.identifier isEqualToString:@"ShowTrainingTasks"]){
        TasksTableViewController *controller=(TasksTableViewController*)segue.destinationViewController;
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
        Trainings *selectedTraining= self.trainings[indexPath.row];
        controller.self.trainingRoot=selectedTraining;
    }
}


@end
