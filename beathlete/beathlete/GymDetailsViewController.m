//
//  GymDetailsViewController.m
//  beathlete
//
//  Created by Admin on 22/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "GymDetailsViewController.h"

@interface GymDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gymNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gymLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *gymName;
@property (weak, nonatomic) IBOutlet UILabel *gymLocation;

@end

@implementation GymDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.gymName.text=NSLocalizedString(@"Gym name", nil);
    self.gymLocation.text=NSLocalizedString(@"Gym location", nil);
    // Do any additional setup after loading the view.
    if(self.gymToShowDetail!=nil){
        [self fetchGymDetail];
    }
}

-(void) fetchGymDetail{
    NSString *gymName= self.gymToShowDetail.name;
    NSString *gymLocation= self.gymToShowDetail.vicinity;
    
    self.gymNameLabel.text=gymName;
    self.gymLocationLabel.text=gymLocation;
}
- (IBAction)openMap:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSString *gymLocation= self.gymToShowDetail.name;
    NSString *urlParam =[gymLocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",urlParam];
    [app openURL:[NSURL URLWithString: url]];
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
