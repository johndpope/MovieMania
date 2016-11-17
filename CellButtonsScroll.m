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
{
  
}



@synthesize backgoundColor;
@synthesize buttonContainerView;
@synthesize cellsButtonsArray;
@synthesize buttonView;
@synthesize indicateSelItem;
@synthesize isCollectionView;
@synthesize useCellButtonsViewHolder;
 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{

    self.backgoundColor=nil;

    if (self.cellsButtonsArray.count){
        for (int i=0; i<[self.cellsButtonsArray count]; i++) {
            [[self.cellsButtonsArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
        }
    }
    self.cellsButtonsArray=nil;
    self.buttonContainerView=nil;
    
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
    
    nCell.indicateSelItem=NO;
    nCell.enableUserActivity=TRUE;
    nCell.cellclassType=CELLCLASS_BUTTONS_SCROLL;
  //!  backgoundColor = [UIColor redColor];
    self.backgoundColor=TK_TRANSPARENT_COLOR;
//    nCell.cellsButtonsArray=[[NSMutableArray alloc]init];
    nCell.cellMaxHeight=DEF_CELLHEIGHT;   //sections won't display without some non 0 value here
      

    



}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Exposed Initialization
/////////////////////////////////////////
//+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray isCollectionView:(BOOL)isCollectionView //buttonScroll:(BOOL)buttonsScroll;
{
    CellButtonsScroll* nCell=[[CellButtonsScroll alloc]init];    //calls makeUseDefaults
    nCell.cellsButtonsArray = [[NSMutableArray alloc] init];
    [nCell.cellsButtonsArray addObjectsFromArray:buttonArray];
    nCell.backgoundColor=  backColor;
    nCell.isCollectionView=isCollectionView;
    nCell.useCellButtonsViewHolder= YES;
    
    
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
    
    if (!self.cellsButtonsArray.count)
        return;
    
    
    //remove subviews in my contentView, because it is for another cell
    [[tvcellPtr.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];    //new
        
    //put my displayable contents in a passed table view cell
    //tvcPtr.textLabel.backgroundColor=self.backgoundColor;
 
    
 //   self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxW, maxH)];
    ActionRequest *aBtn =    [self.cellsButtonsArray objectAtIndex:0];
    
    self.cellMaxHeight = aBtn.buttonSize.height;//*1.5;
    
    
    if (self.buttonContainerView) {
        self.buttonContainerView=nil;   //kill it?
    }
    if (self.buttonView) {
        self.buttonView=nil; //kill it?
    }
    
    self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxW, self.cellMaxHeight)];
    if (!buttonContainerView) {
        NSLog(@"");
    }
    if (useCellButtonsViewHolder) {
        CellButtonsViewHolder * cellButtonsVH = [[CellButtonsViewHolder alloc]initWithContainer:self.buttonContainerView buttonSequence:self.cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcontrollerPtr asCollectionView:isCollectionView];
        self.buttonView = [NSArray arrayWithObject:cellButtonsVH];
        self.buttonContainerView.contentSize = CGSizeMake(cellButtonsVH.bounds.size.width,0.0);
        [self.buttonContainerView addSubview:cellButtonsVH];
        self.buttonContainerView.backgroundColor= [UIColor clearColor];
        tvcellPtr.backgroundColor=[UIColor clearColor];
        tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
        [tvcellPtr addSubview:self.buttonContainerView];
        return;
    }
    
    
    
    if(!isCollectionView){
        
        HDButtonView* returnedUIView = [[HDButtonView alloc]initWithContainer:self.buttonContainerView buttonSequence:self.cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcontrollerPtr];
        self.buttonContainerView.contentSize = CGSizeMake(returnedUIView.bounds.size.width,0.0);
        [self.buttonContainerView addSubview:returnedUIView];
        self.buttonView = [NSArray arrayWithObject:returnedUIView];
    }
    if(isCollectionView){
        
        CollectionViewHolder * collectionVH= [[CollectionViewHolder alloc]initWithContainer:self.buttonContainerView buttonSequence:self.cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcontrollerPtr];
        self.buttonView = [NSArray arrayWithObject:collectionVH];
        self.buttonContainerView.contentSize = CGSizeMake(collectionVH.bounds.size.width,0.0);
        [self.buttonContainerView addSubview:collectionVH];
        
        
    }
    self.buttonContainerView.backgroundColor= [UIColor clearColor];
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    [tvcellPtr addSubview:self.buttonContainerView];
  
    
}

-(UIScrollView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    
    //CALLED for Section Header, Footer   or Table Header, Footer
    //will migrate to stackviews
    
 //   BOOL thisViewScrolls = buttonViewScrolls;
    //return  UIView to display this stuff
    
    // Dan return button view
    if (!self.cellsButtonsArray.count)
        return nil;
    ActionRequest *aBtn = [self.cellsButtonsArray objectAtIndex:0];
    self.cellMaxHeight = aBtn.buttonSize.height;//*1.5;
    NSLog(@"CellBUttonScroll putMeVisibleMaxWidth %d indicateSel %d",maxwidth,self.indicateSelItem);
    
    if (self.buttonContainerView) {
        self.buttonContainerView=nil;
    }
    
    
    self.buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, maxwidth, self.cellMaxHeight)];// maxheight)];
    
    if (!buttonContainerView) {
        NSLog(@"");
    }
    CellButtonsViewHolder* returnedUIView = [[CellButtonsViewHolder alloc]initWithContainer:self.buttonContainerView buttonSequence:self.cellsButtonsArray rowNumbr:0  withTVC:(TableViewController *)tvcPtr asCollectionView:NO];//[GlobalTableProto sharedGlobalTableProto].inTVOS];
    self.buttonContainerView.contentSize = CGSizeMake(returnedUIView.bounds.size.width,0.0);
    [self.buttonContainerView addSubview:returnedUIView];
    self.buttonView = [NSArray arrayWithObject:returnedUIView];
//    buttonContainerView.scrollEnabled = thisViewScrolls;
    self.buttonContainerView.backgroundColor=self.backgoundColor;
    
  //  returnedUIView.backgroundColor=self.backgoundColor;
    return self.buttonContainerView;
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
