//
//  ProgressAddViewController.m
//  beathlete
//
//  Created by Admin on 19/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ProgressTableViewController.h"
@import CoreData;
#import "AppDelegate.h"
#import "Measurments+CoreDataProperties.h"
#import "ProgressDetailViewController.h"
@interface ProgressTableViewController ()<UITableViewDataSource>
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<Measurments*>* measurmentsArray;
@end

@implementation ProgressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=NSLocalizedString(@"Measurments", nil);
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
    [self fetchAllMeasurments];
}
-(void) fetchAllMeasurments{
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Measurments"];
    self.measurmentsArray=[self.context executeFetchRequest:request error:nil];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllMeasurments];
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.measurmentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMeasurment" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *weightDouble = [NSString stringWithFormat:@"%.1f", self.measurmentsArray[indexPath.row].weight];
    cell.textLabel.text=weightDouble;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *newDate = [dateFormatter stringFromDate:self.measurmentsArray[indexPath.row].measurmentDate];
    cell.detailTextLabel.text=newDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        Measurments *measurment = self.measurmentsArray[indexPath.row];
        [self.context deleteObject:measurment];
        [self.delegate saveContext];
        [self fetchAllMeasurments];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ShowMeasurmentDetail"]){
        ProgressDetailViewController *controller=(ProgressDetailViewController*)segue.destinationViewController;
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
        Measurments *selectedMeasurment= self.measurmentsArray[indexPath.row];
        controller.self.measurmentToShowDetail=selectedMeasurment;
    }
}


@end
