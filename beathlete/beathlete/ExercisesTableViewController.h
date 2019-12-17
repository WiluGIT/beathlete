//
//  ExercisesTableViewController.h
//  beathlete
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parts+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExercisesTableViewController : UITableViewController
@property (nonatomic) Parts* partToList;
@end

NS_ASSUME_NONNULL_END
