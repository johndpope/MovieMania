//
//  CellImageOnly.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellButtonsScroll.h"
#import "ActionRequest.h"
#import "TableProtoDefines.h"
@implementation CellButtonsScroll



@synthesize backgoundColor;
@synthesize buttonContainerView;
@synthesize cellsButtonsArray;
@synthesize buttonView;
//@synthesize reloadOnly;

//@synthesize buttonView;

//@synthesize buttonViewScrolls;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{

    backgoundColor=nil;

    if (cellsButtonsArray.count){
        for (int i=0; i<[self.cellsButtonsArray count]; i++) {
            [[self.cellsButtonsArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
        }
    }
    cellsButtonsArray=nil;
    buttonContainerView=nil;
    
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellButtonsScroll *)nCell
{
    nCell.enableUserActivity=TRUE;
    nCell.cellclassType=CELLCLASS_BUTTONS_SCROLL;
  //!  backgoundColor = [UIColor redColor];
    backgoundColor=TK_TRANSPARENT_COLOR;
//    nCell.cellsButtonsArray=[[NSMutableArray alloc]init];
    nCell.cellMaxHeight=DEF_CELLHEIGHT;   //sections won't display without some non 0 value here
   // nCell.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectZero];
    //UIScrollView* buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxwidth, maxheight)];//=[[UIView alloc]initWithFrame:CGRectZero];
    
  //  nCell.buttonView = [[HDButtonView alloc]initWithContainer:buttonContainerView buttonSequence:cellsButtonsArray rowNumbr:0 containerScrolls:YES withTVC:nil];
   // buttonContainerView.contentSize = CGSizeMake(returnedUIView.bounds.size.width,0.0);
  //  [buttonContainerView addSubview:returnedUIView];
    

    



}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Exposed Initialization
/////////////////////////////////////////
//+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray //buttonScroll:(BOOL)buttonsScroll;
{
    CellButtonsScroll* nCell=[[CellButtonsScroll alloc]init];    //calls makeUseDefaults
    nCell.cellsButtonsArray = [[NSMutableArray alloc] init];
    [nCell.cellsButtonsArray addObjectsFromArray:buttonArray];
    nCell.backgoundColor=  backColor;
 //   nCell.buttonViewScrolls = buttonsScroll;
    return nCell;
}
+ (id )initCellDefaults
{
    CellButtonsScroll* nCell=[[CellButtonsScroll alloc]init];    //calls makeUseDefaults
    
    return nCell;

}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellBackColor
{
    return self.backgoundColor;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    //ASSIGN THIS IN putMeInTableViewCell:
    
    //NSLog(@"CELLBUTTONSCROLL ht:%f",self.cellMaxHeight);
    return self.cellMaxHeight;//DAN THIS IS NEW>>>>IT MUST RETURN HEIGHT...
    
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //CALLED for individual Section's Cell content
    //will migrate to stackviews  (through cell's contentView)
    
    if (!cellsButtonsArray.count)
        return;
    
    //put my displayable contents in a passed table view cell
    //tvcPtr.textLabel.backgroundColor=self.backgoundColor;
 
    
 //   self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxW, maxH)];
    ActionRequest *aBtn =    [cellsButtonsArray objectAtIndex:0];
    
    self.cellMaxHeight = aBtn.buttonSize.height;//*1.5;
    self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxW, self.cellMaxHeight)];
//    cellsButtonsArray = [[NSMutableArray alloc] init];
    
//    HDButtonView* returnedUIView = [[HDButtonView alloc]initWithContainer:buttonContainerView buttonSequence:cellsButtonsArray rowNumbr:0 containerScrolls:buttonViewScrolls withTVC:(TableViewController *)tvcontrollerPtr];
    HDButtonView* returnedUIView = [[HDButtonView alloc]initWithContainer:buttonContainerView buttonSequence:cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcontrollerPtr];
    buttonContainerView.contentSize = CGSizeMake(returnedUIView.bounds.size.width,0.0);
    [buttonContainerView addSubview:returnedUIView];
 //   returnedUIView.center=buttonContainerView.center;
    
    // returnedUIView.backgroundColor=self.backgoundColor;
    self.buttonView = [NSArray arrayWithObject:returnedUIView];
    buttonContainerView.backgroundColor=self.backgoundColor;//mah 070616
    
    buttonContainerView.backgroundColor=[UIColor orangeColor];
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    tvcellPtr.backgroundColor=[UIColor blueColor];
    
    [tvcellPtr addSubview:buttonContainerView];
 //   buttonContainerView.center=tvcellPtr.center;
    
//    returnedUIView.userInteractionEnabled=NO;
//    buttonContainerView.userInteractionEnabled=NO;
//    tvcellPtr.userInteractionEnabled=NO;
    
    
    //DAN - the height should be set by your container.... the max height 1 screens worth is provided by maxHeight just as a boundary
   // self.cellMaxHeight=buttonContainerView.frame.size.height ;    //put the height your cell uses here
    
    
  
    
}
-(UIScrollView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    
    //CALLED for Section Header, Footer   or Table Header, Footer
    //will migrate to stackviews
    
 //   BOOL thisViewScrolls = buttonViewScrolls;
    //return  UIView to display this stuff
    
    // Dan return button view
    if (!cellsButtonsArray.count)
        return nil;
    ActionRequest *aBtn = [cellsButtonsArray objectAtIndex:0];
    self.cellMaxHeight = aBtn.buttonSize.height;//*1.5;
    NSLog(@"buttonView maxwidth %d",maxwidth);
    self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxwidth, self.cellMaxHeight)];// maxheight)];
    
  
//    cellsButtonsArray = [[NSMutableArray alloc] init];
    
//    HDButtonView* returnedUIView = [[HDButtonView alloc]initWithContainer:buttonContainerView buttonSequence:cellsButtonsArray rowNumbr:0 containerScrolls:thisViewScrolls withTVC:(TableViewController *)tvcPtr];
    
    HDButtonView* returnedUIView = [[HDButtonView alloc]initWithContainer:buttonContainerView buttonSequence:cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcPtr];
    buttonContainerView.contentSize = CGSizeMake(returnedUIView.bounds.size.width,0.0);
    [buttonContainerView addSubview:returnedUIView];
    self.buttonView = [NSArray arrayWithObject:returnedUIView];
//    buttonContainerView.scrollEnabled = thisViewScrolls;
    buttonContainerView.backgroundColor=self.backgoundColor;
    
  //  returnedUIView.backgroundColor=self.backgoundColor;
    return buttonContainerView;
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
