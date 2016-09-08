//
//  TestingUserViewController.h
//
//
//  
//

#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"




@interface TestingUserViewController : UIViewController 


@property (nonatomic, readwrite) UIStackView *stack1;
@property (nonatomic, readwrite) NSMutableArray *stacksUIViewArray;




@property (nonatomic, readwrite) UIStackView *stackLeft;
@property (nonatomic, readwrite) NSMutableArray *stackLeftUIViewArray;
@property (nonatomic, readwrite) UIStackView *stackRight;
@property (nonatomic, readwrite) NSMutableArray *stackRightUIViewArray;
@property (nonatomic, readwrite) UIStackView *stackSubContent;
@property (nonatomic, readwrite) NSMutableArray *stackSubContentUIViewArray;

@end
