//
//  ProgressDetailViewController.m
//  beathlete
//
//  Created by Admin on 20/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "ProgressDetailViewController.h"

@interface ProgressDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *weightText;
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UILabel *photoText;

@end

@implementation ProgressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.weightText.text=NSLocalizedString(@"Weight:", nil);
    self.dateText.text=NSLocalizedString(@"Date:", nil);
    self.photoText.text=NSLocalizedString(@"Photo:", nil); self.navigationItem.title=NSLocalizedString(@"Measurment Detail", nil);
    if(self.measurmentToShowDetail!=nil){
        [self fetchMeasurmentDetail];
    }
}
-(void) fetchMeasurmentDetail{
    self.weightLabel.text=[NSString stringWithFormat:@"%.1f",self.measurmentToShowDetail.weight];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *newDate = [dateFormatter stringFromDate:self.measurmentToShowDetail.measurmentDate];
    self.dateLabel.text=newDate;
    NSData *data = self.measurmentToShowDetail.image;
    UIImage *image = [UIImage imageWithData:data];
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
