//
//  NavCtrl.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NavCtrl :  UINavigationController <UINavigationControllerDelegate>

@property (nonatomic,copy) dispatch_block_t completionBlock;
- (void) replaceLastWith:(UIViewController *) controller;
-(id) initWithRoot:(UIViewController*)rootvc;
@end
