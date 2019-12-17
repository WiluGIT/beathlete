//
//  ExerciseDetailViewController.h
//  beathlete
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercises+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExerciseDetailViewController : UIViewController
@property (nonatomic) Exercises* exerciseToShowDetail;
@end

NS_ASSUME_NONNULL_END
