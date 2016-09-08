//
//  AppDelegate.h
//  IOSExample
//
//  Created by Myra Hambleton on 8/24/16.
//  
//

#import <UIKit/UIKit.h>
#import "Runtime.h"
#import "DeviceDetection.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GlobalTableProto *gGTPptr;
@end

