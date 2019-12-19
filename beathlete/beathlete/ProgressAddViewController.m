//
//  ProgressAddViewController.m
//  beathlete
//
//  Created by Admin on 19/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ProgressAddViewController.h"
@import CoreData;
#import "AppDelegate.h"
#import "Measurments+CoreDataClass.h"
@interface ProgressAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *measurmentDatePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;
@end

@implementation ProgressAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context =self.delegate.persistentContainer.viewContext;
}
- (IBAction)saveMeasurment:(id)sender {
    double measurmentWeight=[self.weightTextField.text doubleValue];
    NSDate *measuremntDate=self.measurmentDatePicker.date;
    Measurments *measurment =[[Measurments alloc] initWithContext:self.context];
    measurment.weight=measurmentWeight;
    measurment.measurmentDate=measuremntDate;
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
