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
#import "Exercises+CoreDataClass.h"
@interface TaskAddViewController ()<UITableViewDataSource, UISearchBarDelegate,UITableViewDelegate>
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *exerciseDetailsTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *exerciseSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic) bool isFiltered;
@property (nonatomic) NSArray <Exercises*>* exercisesToFilter;
@property (nonatomic) NSMutableArray <Exercises*>* filteredExercises;
@end

@implementation TaskAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    /*
    if(self.trainingTaskToEdit!=nil){
        self.exerciseNameTextField.text=self.trainingTaskToEdit.taskName;
        self.exerciseDetailsTextField.text=self.trainingTaskToEdit.taskDescription;
    }
    */
    self.isFiltered=false;
    [self fetchAllExercises];
}
-(void) fetchAllExercises{
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Exercises"];
    self.exercisesToFilter=[self.context executeFetchRequest:request error:nil];
}
- (IBAction)saveTrainingTask:(id)sender {
    NSString *taskName=self.exerciseNameTextField.text;
    NSString *taskDescription=self.exerciseDetailsTextField.text;
    /*
    if(self.trainingTaskToEdit!=nil){
          //NSPredicate *predicate =[NSPredicate predicateWithFormat:@"number == ta"];
          //request.predicate=predicate;
        NSSet<TrainingTasks*>* trainigTasks = self.trainingTaskRoot.trainingTasks;
          
          for (TrainingTasks* task in trainigTasks) {
              if(task==self.trainingTaskToEdit){
                  task.taskName=taskName;
                  task.taskDescription=taskDescription;
              }
          }
    }else{

    }
     */
    TrainingTasks *task =[[TrainingTasks alloc] initWithContext:self.context];
    task.taskName=taskName;
    task.taskDescription=taskDescription;
    task.taskDone=false;
    task.training=self.trainingTaskRoot;
    [self.delegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        self.isFiltered=false;
    }else{
        self.isFiltered=true;
        self.filteredExercises=[[NSMutableArray alloc] init];
        for(Exercises *exercise in self.exercisesToFilter){
            NSRange nameRange= [exercise.exerciseName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound){
                [self.filteredExercises addObject:exercise];
            }
        }
    }
    [self.searchTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(self.isFiltered){
        return self.filteredExercises.count;
    }
    return self.exercisesToFilter.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellExerciseSearch" forIndexPath:indexPath];
    
    // Configure the cell...
    if(self.isFiltered){
        cell.textLabel.text=self.filteredExercises[indexPath.row].exerciseName;
    }else{
        cell.textLabel.text=self.exercisesToFilter[indexPath.row].exerciseName;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *exName;
    if(self.isFiltered){
        exName=self.filteredExercises[indexPath.row].exerciseName;
        
    }else{
        exName=self.exercisesToFilter[indexPath.row].exerciseName;
    }
    self.exerciseNameTextField.text=exName;
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
