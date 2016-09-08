//
//  AppDelegate.m
//  IOSExample
//

#import "AppDelegate.h"
#import "MasterViewController.h"//IOSViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*  UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
     UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
     navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
     splitViewController.delegate = self;
     return YES;*/
    
    self.gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    
    
    self.gGTPptr.runningSimulator = NO;
    
    uint devicei = [DeviceDetection detectDevice];
    if (MODEL_IPAD_SIMULATOR == devicei || MODEL_IPHONE_SIMULATOR == devicei)
        self.gGTPptr.runningSimulator = YES;
    
    
    NSLog(@"localeIdentifier: %@", [[NSLocale currentLocale] localeIdentifier]);
    NSLog(@"Full Locale Identifier %@",[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[[NSLocale currentLocale] localeIdentifier]]);
    NSArray *arr = [NSLocale preferredLanguages];
    for (NSString *lan in arr) {
        NSLog(@"%@: %@ %@",lan, [NSLocale canonicalLanguageIdentifierFromString:lan], [[[NSLocale alloc] initWithLocaleIdentifier:lan] displayNameForKey:NSLocaleIdentifier value:lan]);
    }
    
    application.statusBarHidden=NO;
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window.rootViewController = navController;
    self.gGTPptr.liveRuntimePtr=[[Runtime alloc]init];   //Runtime class creates tavleViewController and navController
    
    
    // self.window.rootViewController = self.gGTPptr.liveRuntimePtr.rtNavCtrler;
    self.window.rootViewController=self.gGTPptr.liveRuntimePtr.holdVCtrler;
    
    [self.window makeKeyAndVisible];
    [self.gGTPptr.liveRuntimePtr startRunTime];
    
    return YES;
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
