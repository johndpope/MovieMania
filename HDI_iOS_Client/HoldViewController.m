//
//  ViewController.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "HoldViewController.h"


@interface HoldViewController ()

@end

@implementation HoldViewController

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  [self.view setOpaque:NO];
    self.view.backgroundColor = [UIColor yellowColor];//;[UIColor blueColor];
   // self.view.frame=CGRectMake(0, 0, 50, 50);
   // self.view.bounds=self.view.frame;
    
    // Get device unique ID
 //   UIDevice *device = [UIDevice currentDevice];
  //  NSString *uniqueIdentifier =[UIDevice currentDevice].identifierForVendor.UUIDString;


    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"");
}


//-(void )viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [super viewWillAppear:animated];
//}
/*
-(void) viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];
    NSLog(@"VIEWCONTROLLER %p viewDidLayoutSubViews %p", self,self.view);
    BOOL myViewLoaded=[self isViewLoaded];
    NSLog(@"VIEWCONTROLLER loaded? %d",myViewLoaded);
    NSLog(@"VIEWCONTROLLER window prop %@",self.view.window);
    // Get the subviews of the view
    NSArray *subviews = [self.view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0){
        
        return;
    }
    else{
        [self listSubviewsOfView:self.view];
    }

    
}


- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0){
        
        return;
    }
    
    for (UIView *subview in subviews) {
        
        NSLog(@"   %p VCSUBVIEW: %p", view,subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////
#pragma mark - Focus
///////////////////////////////////////////////////
/*- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    //user hits ESC (return from movie details),ARROW   AND when COLLECTION APPESRS after Return from Movie details
    
    
    NSString *classPREV;
    NSString *classNEXT;
    classPREV=NSStringFromClass([context.previouslyFocusedView class]);
    classNEXT=NSStringFromClass([context.nextFocusedView class]);
    
    NSLog(@"***HoldViewController didUpdateFocusInContext:   prevFoc %@   nextFoc(GO FOCUS)  %@",classPREV, classNEXT);
    
    
    
    
}
 */

@end
