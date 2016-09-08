//
//  AppDelegate.h
//  TVOSExample
//
//

#import <UIKit/UIKit.h>
#import "Runtime.h"
#import "DeviceDetection.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GlobalTableProto *gGTPptr;
@end

