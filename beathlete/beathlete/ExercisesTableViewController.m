//
//  ExercisesTableViewController.m
//  beathlete
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ExercisesTableViewController.h"
#import "Exercises+CoreDataClass.h"
#import "AppDelegate.h"
@import CoreData;
#import "ExerciseDetailViewController.h"

@interface ExercisesTableViewController ()
@property (nonatomic) NSSet<Exercises*>* exercises;
@property (nonatomic) NSArray<Exercises*>* exercisesArray;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@end

@implementation ExercisesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    if(self.partToList!=nil){
        [self fetchAllExercises];
    }


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllExercises];
    [self.tableView reloadData];

}
-(void)fetchAllExercises{
    self.exercises=self.partToList.exercises;
    self.exercisesArray =[self.exercises allObjects];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.exercisesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellExercise" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=self.exercisesArray[indexPath.row].exerciseName;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
       if([segue.identifier isEqualToString:@"ShowExerciseDetail"]){
        ExerciseDetailViewController *controller=(ExerciseDetailViewController*)segue.destinationViewController;
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
        Exercises *selectedExercise= self.exercisesArray[indexPath.row];
        controller.self.exerciseToShowDetail=selectedExercise;
    }

}


@end
