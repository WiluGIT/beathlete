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
@interface ProgressAddViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
- (IBAction)openCamera:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate=self;
        [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        pickerController.allowsEditing=YES;
        [self presentViewController:pickerController animated:YES completion:nil];
        
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"We have problem" message:@"Your device doest not have a camera!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image=image;
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
