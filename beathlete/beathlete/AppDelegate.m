//
//  AppDelegate.m
//  beathlete
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Parts+CoreDataClass.h"
#import "Exercises+CoreDataClass.h"
@interface AppDelegate ()
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //get location of database
    NSArray *url = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSLog(@"%@",[url objectAtIndex:0]);
    //initialize context
    self.context = self.persistentContainer.viewContext;
    
    //call database initialization
    [self createInitialAppData];
    //[self deleteAllRecords:@"Exercises"];
    return YES;
}

-(void) createInitialAppData{
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Parts"];
    NSArray *parts=[self.context executeFetchRequest:request error:nil];
    if([parts count]==0){
        //Body parts
        Parts *part1= [[Parts alloc] initWithContext:self.context];
        part1.name=@"Chest";
        Parts *part2= [[Parts alloc] initWithContext:self.context];
        part2.name=@"Shoulders";
        Parts *part3= [[Parts alloc] initWithContext:self.context];
        part3.name=@"Arms";
        Parts *part4= [[Parts alloc] initWithContext:self.context];
        part4.name=@"Back";
        Parts *part5= [[Parts alloc] initWithContext:self.context];
        part5.name=@"buttocks";
        Parts *part6= [[Parts alloc] initWithContext:self.context];
        part6.name=@"Legs";
        
        NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Exercises"];
        NSArray *exercises=[self.context executeFetchRequest:request error:nil];
        if([exercises count]==0){
            //Exercises for each part
            //Chest
            Exercises *exercise1 = [[Exercises alloc] initWithContext:self.context];
            exercise1.exerciseName=@"Bench Press";
            exercise1.exerciseDescription=@"The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench. The exercise uses the pectoralis major, the anterior deltoids, and the triceps, among other stabilizing muscles. A barbell is generally used to hold the weight, but a pair of dumbbells can also be used.";
            exercise1.hyperlink=@"https://www.youtube.com/watch?v=XSza8hVTlmM";
            exercise1.part=part1;
            
            Exercises *exercise2 = [[Exercises alloc] initWithContext:self.context];
            exercise2.exerciseName=@"Chest Fly";
            exercise2.exerciseDescription=@"The chest fly or pectoral fly (abbreviated to pec fly) primarily works the pectoralis major muscles to move the arms horizontally forward. If medially (internally) rotated, it is assisted in this by the anterior (front) head of the deltoideus in transverse flexion. If laterally (externally) rotated, the contribution of the deltoid is lessened and the pec major is strongly emphasized as the transverse adductor.";
            exercise2.hyperlink=@"https://www.youtube.com/watch?v=oGxc2ph8Fnw";
            exercise2.part=part1;
            
            //Shoulders
            Exercises *exercise3 = [[Exercises alloc] initWithContext:self.context];
            exercise3.exerciseName=@"Face Pull";
            exercise3.exerciseDescription=@"Face pulls target the posterior deltoids of the shoulder, which are often neglected by other shoulder exercises. You use a cable pulley machine to pull the weight toward straight toward your forehead. Exercising the rear delts will prevent muscular imbalance and build overall shoulder strength.";
            exercise3.hyperlink=@"https://www.youtube.com/watch?v=eFxMixk_qPQ&t=2s";
            exercise3.part=part2;
            
            Exercises *exercise4 = [[Exercises alloc] initWithContext:self.context];
            exercise4.exerciseName=@"OverHead Press";
            exercise4.exerciseDescription=@"The Overhead Press is a full body, compound exercise. Your shoulders and arms press the weight over your head while your legs, lower back and abs balance you. The Overhead Press is one of the best exercises to build strong, muscular and healthy shoulders with bigger arms.";
            exercise4.hyperlink=@"https://www.youtube.com/watch?v=2yjwXTZQDDI";
            exercise4.part=part2;
            
            //Arms
            Exercises *exercise5 = [[Exercises alloc] initWithContext:self.context];
            exercise5.exerciseName=@"Dumbbell Biceps Curl";
            exercise5.exerciseDescription=@"This exercise will increase the strength of your biceps and forearms. Therefore, you will improve your overall martial arts punching and grappling strength.";
            exercise5.hyperlink=@"https://www.youtube.com/watch?v=ykJmrZ5v0Oo";
            exercise5.part=part3;
            
            Exercises *exercise6 = [[Exercises alloc] initWithContext:self.context];
            exercise6.exerciseName=@"Dip";
            exercise6.exerciseDescription=@"A dip is an upper-body strength exercise. Narrow, shoulder-width dips primarily train the triceps, with major synergists being the anterior deltoid, the pectoralis muscles (sternal, clavicular, and minor), and the rhomboid muscles of the back.";
            exercise6.hyperlink=@"https://www.youtube.com/watch?v=2z8JmcrW-As";
            exercise6.part=part3;
            
            //Back
            Exercises *exercise7 = [[Exercises alloc] initWithContext:self.context];
            exercise7.exerciseName=@"Deadlift";
            exercise7.exerciseDescription=@"The deadlift is a weight training exercise in which a loaded barbell or bar is lifted off the ground to the level of the hips, torso perpendicular to the floor, before being placed back on the ground. It is one of the three powerlifting exercises, along with the squat and bench press.";
            exercise7.hyperlink=@"https://www.youtube.com/watch?v=r4MzxtBKyNE";
            exercise7.part=part4;
            
            Exercises *exercise8 = [[Exercises alloc] initWithContext:self.context];
            exercise8.exerciseName=@"Pull Up";
            exercise8.exerciseDescription=@"A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up. As this happens, the elbows flex and the shoulders adduct and extend to bring the elbows to the torso.";
            exercise8.hyperlink=@"https://www.youtube.com/watch?v=eGo4IYlbE5g";
            exercise8.part=part4;
            
            //Buttocks
            Exercises *exercise9 = [[Exercises alloc] initWithContext:self.context];
            exercise9.exerciseName=@"Hip Thrust";
            exercise9.exerciseDescription=@"The hip thrust is a loaded glute bridge performed with the back resting on a bench, which increases the exercise range of motion. It is most commonly loaded with a barbell, elastic resistance bands, or a combination of the two. Biomechanically, the hip thrust is a horizontally-loaded (relative to the body, or anteroposteriorly) bent-leg hip extension exercise, with a peak level of contraction where the muscles are shortest, and with consistent tension placed on the hips throughout.";
            exercise9.hyperlink=@"https://www.youtube.com/watch?v=Zp26q4BY5HE";
            exercise9.part=part5;
            
            Exercises *exercise10 = [[Exercises alloc] initWithContext:self.context];
            exercise10.exerciseName=@"Bulgarian Split Squat";
            exercise10.exerciseDescription=@"As well as testing your balance to the max – which will improve core strength – the elevated split squat is a powerhouse of a leg workout, with your quads, calves and hamstrings all set to benefit. The glutes are also heavily involved in the exercise, so it works for anyone keen on perfecting their posterior.";
            exercise10.hyperlink=@"https://www.youtube.com/watch?v=2C-uNgKwPLE";
            exercise10.part=part5;
            
            //Legs
            Exercises *exercise11 = [[Exercises alloc] initWithContext:self.context];
            exercise11.exerciseName=@"Squat";
            exercise11.exerciseDescription=@"A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up. During the descent of a squat, the hip and knee joints flex while the ankle joint dorsiflexes; conversely the hip and knee joints extend and the ankle joint plantarflexes when standing up.";
            exercise11.hyperlink=@"https://www.youtube.com/watch?v=nhoikoUEI8U";
            exercise11.part=part6;
            
            Exercises *exercise12 = [[Exercises alloc] initWithContext:self.context];
            exercise12.exerciseName=@"Leg Curl";
            exercise12.exerciseDescription=@"The leg curl, also known as the hamstring curl, is an isolation exercise that targets the hamstring muscles.[1] The exercise involves flexing the lower leg against resistance towards the buttocks.";
            exercise12.hyperlink=@"https://www.youtube.com/watch?v=72xhLTC69kk";
            exercise12.part=part6;
        }
        [self saveContext];
    }


}
 
-(void) deleteAllRecords:(NSString*) tableToClear{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:tableToClear];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];

    NSError *deleteError = nil;
    [self.persistentContainer.persistentStoreCoordinator executeRequest:delete withContext:self.context error:&deleteError];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"beathlete"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
