//
//  GymsTableViewController.m
//  beathlete
//
//  Created by Admin on 21/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "GymsTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Gym.h"
#import "GymDetailsViewController.h"

#define API_KEY @"AIzaSyBP5XZhM7zzlix80kcHWn6-WfHengj68VQ"
CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placeMark;

@interface GymsTableViewController ()<CLLocationManagerDelegate>
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSMutableArray<Gym*>* nerbyGyms;
@end

@implementation GymsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager=[[CLLocationManager alloc] init];
    geocoder=[[CLGeocoder alloc] init];
    [self initLocationManager];
    
}
- (IBAction)fetchGyms:(id)sender {
    NSString *searchTerm=@"silownia";
    if(self.nerbyGyms!=nil){
        [self.tableView reloadData];
    }else{
        if(self.latitude!=nil && self.longitude!=nil){
            NSString *stringUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=5000&keyword=%@&key=%@",self.latitude, self.longitude,searchTerm,API_KEY];
            //NSLog(@"lat: %@, long: %@",self.latitude,self.longitude);
            NSURL *url = [NSURL URLWithString:stringUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                if (data.length > 0 && connectionError == nil){
                NSDictionary *dicYourResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    NSLog(@"%@",dicYourResponse);
                    NSArray *responseValue =[dicYourResponse valueForKey:@"results"];
                    self.nerbyGyms=[[NSMutableArray alloc]init];
                    for(NSDictionary *groupDic in responseValue){
                        Gym *gym =[[Gym alloc]init];
                        for(NSString *key in groupDic){
                            if([gym respondsToSelector:NSSelectorFromString(key)]){
                                
                                [gym setValue:[groupDic valueForKey:key] forKey:key];
                            }
                        }
                        [self.nerbyGyms addObject:gym];
                    }

                }
            }];
        }
    }
    
    
}

-(void) initLocationManager{
    locationManager.delegate=self;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager*) manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@",error);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your location" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.view setBackgroundColor:[UIColor blueColor]];
    }];
    [alertController addAction:okButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //NSLog(@"didUpdateLocations");
    
    CLLocation *currentLocation = [locations lastObject];
    if(currentLocation!=nil){
        self.longitude= [NSString stringWithFormat:@"%.6f", currentLocation.coordinate.longitude];
        self.latitude= [NSString stringWithFormat:@"%.6f", currentLocation.coordinate.latitude];
    }
    [self.tableView reloadData];
    
    //NSLog(@"lat: %@, long: %@",self.latitude,self.longitude);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.nerbyGyms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GymCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=self.nerbyGyms[indexPath.row].name;
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ShowGymDetails"]){
         GymDetailsViewController *controller=(GymDetailsViewController*)segue.destinationViewController;
         UITableViewCell *cell = (UITableViewCell*) sender;
         NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
         Gym *selectedGym= self.nerbyGyms[indexPath.row];
         controller.self.gymToShowDetail=selectedGym;
     }
}


@end
