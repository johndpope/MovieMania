//
//  NavCtrl.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "NavCtrl.h"

@implementation NavCtrl
{


//    NSMutableDictionary *allLocationsHDI;
//    NSArray             *allLocationKeys;

//    NSMutableDictionary *allMovieInfoOMDB;
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////

-(id) init
{
    self = [super init];
    if (self) {
        self.delegate=self;
        
       
                    
    }
    return self;
}


-(id) initWithRoot:(UIViewController*)rootvc
{
    self = [super initWithRootViewController:rootvc];
    if (self) {
        self.delegate=self;
        
        
        
    }
    return self;
}
- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // hide the nav bar 
   [navController setNavigationBarHidden:YES animated:animated];
    
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    
    NSLog(@"nav %p didShowViewController:%@ view:%p", navigationController,viewController, viewController.view);
    
    
 
    
    UIViewController *thisvc=self.visibleViewController;
    NSLog(@"NAVCTRL (didshow) visibleViewController: %p withtitle %@",thisvc,thisvc.title);
    UIViewController *fvc= [self topViewController];
    NSLog(@"NAVCtrl (didshow) topViewController:%p withtitle %@",fvc,fvc.title);
    UIViewController *pvc= [self presentedViewController];
    NSLog(@"NAVCtrl (didshow) presentedViewController:%p withtitle %@",pvc,pvc.title);
    
    
    UIViewController *avc;
    NSArray *vcs=[self viewControllers];
    for (int i=0; i<[vcs count]; i++) {
        avc=[vcs objectAtIndex:i];
        NSLog(@"NAVCtrl (didshow) vcs(%d):%p withtitle %@",i,avc,avc.title);

    }
    
    // Return if there are no subviews
//    NSArray *subviews = [viewController.view subviews];
//    if ([subviews count] == 0){
//        NSLog(@"NAVCTRL:thisviewController view: %p NO SUBVIEWS",viewController.view);
 //       return;
 //   }
  //  [self list2SubviewsOfView:viewController.view];
 //   if (self.completionBlock) {
  //      self.completionBlock();
  //      NSLog(@"HEY IM IN COMPLETION BLOCK");
  //      self.completionBlock = nil;
  //  }
}


-(void) viewDidLayoutSubviews
{
    
    NSLog(@"NAVCTRL %p viewDidLayoutSubViews %p", self,self.view);
    UIViewController *thisvc=self.visibleViewController;
    NSLog(@"NAVCTRL visibleViewController: %p withtitle %@",thisvc,thisvc.title);
    UIViewController *fvc= [self topViewController];
    NSLog(@"NAVCtrl topViewController:%p withtitle %@",fvc,fvc.title);
    // Get the subviews of the view
  //  NSArray *subviews = [self.view subviews];
    
    // Return if there are no subviews
 //   if ([subviews count] == 0){
 //       NSLog(@"NAVCTRL view: %p NO SUBVIEWS",self.view);
 //       return;
 //   }
 //   [self listSubviewsOfView:self.view];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark HELPER Methods
/////////////////////////////////////////
- (void) replaceLastWith:(UIViewController *) controller {
    NSMutableArray *stackViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [stackViewControllers removeLastObject];
    [stackViewControllers addObject:controller];
    [self setViewControllers:stackViewControllers animated:YES];
}
- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0){
        
        return;
    }
    
    for (UIView *subview in subviews) {
        
        NSLog(@"   %p NAVSUBVIEW: %p", view,subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}
- (void)list2SubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0){
        
        return;
    }
    
    for (UIView *subview in subviews) {
        
        NSLog(@"   %p NAVviewcntrollerview: %p", view,subview);
        
        // List the subviews of subview
        [self list2SubviewsOfView:subview];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark EXECUTION
/////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NOTIFICATIONS
/////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display TVCs
/////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Data Base Queries
/////////////////////////////////////////


@end
