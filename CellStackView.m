//
//  CellStackView.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellStackView.h"

@implementation CellStackView

@synthesize backgoundColor;
@synthesize cellStackViewArray;
@synthesize myActiveUIView;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{

    backgoundColor=nil;

    
    for (int i=0; i<[self.cellStackViewArray count]; i++) {
        [[self.cellStackViewArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
    }
    cellStackViewArray=nil;
    myActiveUIView=nil;
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellStackView *)nCell
{
    
    nCell.cellclassType=CELLCLASS_STACKVIEW;
    backgoundColor=[UIColor redColor];
    nCell.cellStackViewArray=[[NSMutableArray alloc]init];
    nCell.cellMaxHeight=DEF_CELLHEIGHT;   //sections won't display without some non 0 value here


}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Exposed Initialization
/////////////////////////////////////////
+ (id )initCellDefaults
{
    CellStackView* nCell=[[CellStackView alloc]init];    //calls makeUseDefaults
    
    return nCell;

}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellBackColor
{
    return self.backgoundColor;
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  helper
//////////////////
-(UILabel *)makeALabelwithString:(NSString *)thisString maxWidth:(CGFloat)maxW maxHeight:(CGFloat)maxH
{
    //self.myLabel = [[UILabel alloc] initWithFrame:myFrame];
    UILabel *title;
    title = [[UILabel alloc] init];
    // CGRect myFrame=CGRectMake(0, 0, maxW, maxH);
    //[title setFrame:myFrame];
   //1 title.layer.borderColor = [UIColor yellowColor].CGColor;
  //1  title.layer.borderWidth = 3.0;
    //title.layer.cornerRadius=8.0;
    //title.clipsToBounds=YES;
    
    title.text = thisString;
    title.font = [UIFont boldSystemFontOfSize:16.0f];
    title.textAlignment =  NSTextAlignmentCenter;
    title.backgroundColor=[UIColor redColor];
    title.textColor=[UIColor blackColor];
    title.userInteractionEnabled=NO;
    
    title.preferredMaxLayoutWidth=maxW;
    [title.heightAnchor constraintEqualToConstant:maxH].active = true;   //req'd for stack
    
    
    [title.widthAnchor constraintEqualToConstant:maxW].active = true;     //req'd for stack
    title.hidden=false;
    return title;
    
}
-(UILabel *)makeALabel2LinesString:(NSString *)thisString
{
    UILabel *title;
    title = [[UILabel alloc] init];
    title.text=thisString;
    title.textColor=[UIColor blackColor];
    title.backgroundColor=[UIColor yellowColor];
    title.frame=CGRectMake(0, 0,20,40);
    title.numberOfLines=2;
    //title.intrinsicContentSize=CGSizeMake(100, 20);
    return title;
}

-(UILabel *)makeALabelSimpleString:(NSString *)thisString
{
    UILabel *title;
    title = [[UILabel alloc] init];
    title.text=thisString;
    title.textColor=[UIColor blackColor];
    title.backgroundColor=[UIColor blueColor];
    title.frame=CGRectMake(0, 0,100,20);
    //title.intrinsicContentSize=CGSizeMake(100, 20);
    return title;
}
-(UIStackView *) makeSimpleStackView
{
    
    
    
    
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
    
    // UILabel *mlabel1 = [self makeALabelwithString:@"simple1" maxWidth:207 maxHeight:50  ];
    UILabel *mlabel1 = [self makeALabelSimpleString:@"simple 1"];
    // UILabel *mlabel2 = [self makeALabelwithString:@"simple2" maxWidth:207 maxHeight:50  ];
    UILabel *mlabel2 = [self makeALabelSimpleString:@"simple 2"];
    [labelsStack addArrangedSubview:mlabel1];
    [labelsStack addArrangedSubview:mlabel2];
    
    
    
    return labelsStack;
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    return 0;//self.cellMaxHeight;    //this will crash
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //CALLED for individual Section's Cell content
    //will migrate to stackviews  (through cell's contentView)
    
    
    
    //put my displayable contents in a passed table view cell
    tvcellPtr.textLabel.backgroundColor=self.backgoundColor;
    
  
    
}
-(void) vcWillDisplayHeaderView:(UIView *)view myVC:(UITableViewController *) tvc
{
    if (!myActiveUIView) {
        NSLog(@"cellstackView vcWIllDisplayHeaderView:    TOO SOON? myAcitveUIView is nil");
        return;
    }
    NSLog(@"cellstackView vcWIllDisplayHeaderView:");
    
    
    
    UILayoutGuide *viewsMargin = tvc.view.layoutMarginsGuide;
  //  UILayoutGuide *tempBackViewLMG=myActiveUIView.layoutMarginsGuide;
    [myActiveUIView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
       [myActiveUIView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    NSLog(@"");
    
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    
    //CALLED for Section Header, Footer   or Table Header, Footer
    //will migrate to stackviews
    
    
    //return  UIView to display this stuff
//    UIView* returnedUIView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, maxwidth, maxheight)];//=[[UIView alloc]initWithFrame:CGRectZero];
    
//    returnedUIView.backgroundColor=self.backgoundColor;
//    return returnedUIView;
   
    
    
    
    UIView *tempBackView=[[UIView alloc]init];
    
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:maxwidth].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:maxheight].active = true;
    
    tempBackView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
   //? [self.view addSubview: tempBackView];<<------?
    
    
    myActiveUIView=tempBackView;

    NSLog(@"");
    //!!!!!!!
//NOTE:
    //can't add constraints prior to putting it in as a subview......
    //
    
  //
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
 //   [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
 //   [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    
    return tempBackView;
    
    

    
    
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
