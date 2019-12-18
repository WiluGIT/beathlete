//
//  TasksTableViewController.h
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trainings+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface TasksTableViewController : UIViewController
@property (nonatomic) Trainings* trainingRoot;
@end

NS_ASSUME_NONNULL_END
