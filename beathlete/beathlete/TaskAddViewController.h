//
//  TaskAddViewController.h
//  beathlete
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trainings+CoreDataClass.h"
#import "TrainingTasks+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskAddViewController : UIViewController
@property (nonatomic) Trainings* trainingTaskRoot;
//@property (nonatomic) TrainingTasks* trainingTaskToEdit;
@end

NS_ASSUME_NONNULL_END
