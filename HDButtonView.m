//
//  HDButtonView.m
//  MusicMania
//
//  Created by Dan Hammond on 4/20/13.
//
//


#import "HDButtonView.h"
//#import "SpritesAndButtons.h"
//#import "UMALog.h"
//#import "MMMovieViewController.h"
//#import "GlobalMemory.h"
//#import "MMSegmentObject.h"
//#import "SpriteAndButtonDefs.h"
//#import "SpritesAndButtons.h"
//#import "EasyEditor.h"
//#import "HMIAPHelper.h"
//#import "ViewController.h"
//#import "GlobalTableProto.h"
#import "ActionRequest.h"
#import "TableViewController.h"
#import "GlobalTableProto.h"
#import "Runtime.h"
#import "SectionDef.h"
#import "CellButtonsScroll.h"
#import "CellTypesAll.h"
#import "CellContentDef.h"

#define kControlViewsBackgroundAlpha  0.6
//#define kAutoScroll 1
@implementation HDButtonView
{
 //   int         buttonTag;
    NSTimer     *buttonTimer;
//    GlobalMemory *gm;
//    MMMovieViewController   *mvc;
    float   buttonWidth;
    float   buttonHeight;
    float   buttonViewWidth;
    float   buttonSpacing;
    float   buttonViewHeight;
    BOOL    isColumn;
    UITableViewController *tvc;
    BOOL containerScrolls;
    ActionRequest *currentButtonInCenter;
    ActionRequest *selectedButton;
    UIColor *textColor;
    UIColor *backColor;
//    UIImageView *selectedBtnBox;
//   NSMutableArray  *btnSequence;
//    int     rowNumber;
   }
@synthesize buttonSequence, containerView, rowNumber, selectedBtnBox;

//- (id)initWithContainer:(UIView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr containerScrolls:(BOOL)containerScrolls withTVC:(TableViewController *)tvcPtr
- (id)initWithContainer:(UIScrollView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr withTVC:(TableViewController *)tvcPtr// leftJustifyPartial:(BOOL)
{
    tvc = tvcPtr;
//    [self addTestButtonsToArray:btnSequence];
    self.containerView = container;
    
    self.buttonSequence = btnSequence;
    self.rowNumber = rowNmbr;
    textColor = [GlobalTableProto sharedGlobalTableProto].viewTextColor;
    backColor =  [GlobalTableProto sharedGlobalTableProto].viewBackColor;
    
    
    
//    self.containerViewScrolls = containerScrolls;
    ActionRequest *firstButton = [buttonSequence objectAtIndex:0];
    buttonViewWidth =  containerView.bounds.size.width;
    buttonViewHeight = containerView.bounds.size.height;
 //   buttonViewHeight = 100;
    buttonWidth = firstButton.buttonSize.width;// buttonViewHeight;
    buttonHeight = firstButton.buttonSize.height;
    isColumn = NO;
    if (buttonViewHeight > buttonViewWidth)
        isColumn = YES;
    if (isColumn)
        buttonWidth = buttonViewWidth;
 //   buttonSpacing = buttonWidth/2;
    buttonSpacing = buttonWidth/10;
    
//    if (kAutoScroll){
        containerScrolls = NO;
    
    if (buttonViewWidth < (buttonSequence.count * (buttonWidth + buttonSpacing))){
            containerScrolls = YES;
        
    }else{
        buttonSpacing = buttonWidth/4;
    }
            
    if (containerScrolls){
        buttonViewWidth = (buttonSequence.count+ 2) * (buttonWidth + buttonSpacing);
        self.containerView.delegate = self;
        self.containerView.decelerationRate=UIScrollViewDecelerationRateFast;
        }
    CGRect frame = CGRectMake( 0,0,buttonViewWidth , container.bounds.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        UIImage *yellowBoxImage =  [UIImage imageNamed:@"select1.png"];
        selectedBtnBox = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,firstButton.buttonSize.width ,firstButton.buttonSize.height)];
        [selectedBtnBox setImage:yellowBoxImage];
        selectedBtnBox.backgroundColor = [UIColor clearColor];
        
        
        [self addButtonsToView];//:containerScrolls ];//] buttonSequence:btnSequence];
        
    }
    return self;
    
    
}
-(UIView *)addButtonsToView
{
    ActionRequest *aBtn;
    UIView * newButtonView = self;
    newButtonView.backgroundColor = backColor;// [UIColor blackColor];
    int     numberOfButtonsToMake =(int) buttonSequence.count;
    float   buttonYOffset = 0;
    
    
    if (isColumn)
        buttonYOffset = buttonWidth/8;
    self.backgroundColor = backColor;//[UIColor blackColor];
    //   self.backgroundColor = [UIColor greenColor] ;
    float buttonViewXOffset = buttonViewWidth/2 - numberOfButtonsToMake * (buttonWidth/2 + buttonSpacing/2) + buttonSpacing/2;
    if (isColumn)
        buttonViewXOffset = buttonViewHeight/2 - numberOfButtonsToMake * (buttonWidth/2 + buttonSpacing/2) + buttonSpacing/2;
    if (containerScrolls){
        //  buttonViewXOffset =  containerView.bounds.size.width/2 - buttonWidth/2;
        buttonViewXOffset = 0.0;  //dan 4/16/16
        
    }
    //    NSLog(@"newButtonView backgroundImageView.center = (%3.2f, %3.2f)", backgroundImageView.center.x,backgroundImageView.center.y);
    UIButton *nextButton;
    //    UIButton *nextLabel;
    UILabel *nextLabel;
    for (int i = 0; i < numberOfButtonsToMake; i ++){
        aBtn = [buttonSequence objectAtIndex:i];
        //        [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary setObject:aBtn forKey:[NSString stringWithFormat:@"%li",aBtn.buttonTag]];
        aBtn.buttonArrayPtr = buttonSequence;
        
        if (![aBtn.buttonName isEqualToString:BUTTONS_FILLER_NAME]){
            aBtn.buttonOrigin = CGPointMake(buttonViewXOffset,buttonYOffset);
            if (isColumn)
                aBtn.buttonOrigin = CGPointMake(buttonYOffset, buttonViewXOffset);
            [HDButtonView makeUIButton:aBtn inButtonSequence:buttonSequence];// isColumn:NO];
            nextButton=aBtn.uiButton;
            [newButtonView addSubview:nextButton];
            [nextButton addTarget: self action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpInside];
            [nextButton addTarget: self action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpOutside];
        }
        
        
        if (aBtn.buttonLabel && ![aBtn.buttonName isEqualToString:BUTTONS_FILLER_NAME]){
            CGRect labelFrame = CGRectMake(0,0,buttonWidth , buttonHeight*0.35);// buttonWidth - buttonHeight );
            labelFrame.origin = CGPointMake(buttonViewXOffset, buttonHeight*0.65);
            //            nextLabel = [[UIButton alloc] initWithFrame:labelFrame];
            nextLabel = [[UILabel alloc] initWithFrame:labelFrame];
            //            nextLabel.tag = nextButton.tag;
            nextLabel.hidden = NO;
            
            //            nextLabel.userInteractionEnabled = YES;
            //            nextLabel.backgroundColor = [UIColor whiteColor];
            
            nextLabel.font = [UIFont systemFontOfSize:12];
            nextLabel.text = aBtn.buttonLabel;
            nextLabel.backgroundColor = backColor;
            nextLabel.textColor = textColor;
            nextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            nextLabel.numberOfLines = 0;
            [newButtonView addSubview:nextLabel];
        }
        buttonViewXOffset = buttonViewXOffset + buttonWidth + buttonSpacing;
    }
    
    if (containerScrolls && aBtn.reloadOnly){
        [self initButtonInCenterToRow0Btn0];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapGestureReceived:) name:@"TapGestureReceived" object:nil];
    return self;
}

+(void)makeUIButton:(ActionRequest*)actionReq inButtonSequence:(NSMutableArray *)buttonSeq
{
    
    CGRect buttonFrame = CGRectMake(actionReq.buttonOrigin.x,actionReq.buttonOrigin.y,actionReq.buttonSize.width,actionReq.buttonSize.height);
    //    buttonFrame.origin = actionReq.buttonOrigin;
    UIButton *nextButton = [[UIButton alloc] initWithFrame:buttonFrame];
    
    actionReq.uiButton = nextButton;
    nextButton.tag = actionReq.buttonTag;
    nextButton.hidden = NO;
    nextButton.userInteractionEnabled =  YES;
    nextButton.backgroundColor = [UIColor darkGrayColor];//  backColor;// [UIColor blackColor];
    //    buttonViewXOffset = buttonViewXOffset + buttonWidth + buttonSpacing;
    
    nextButton.adjustsImageWhenHighlighted = YES;
    
    if (actionReq.buttonImage){
        
        [nextButton setImage:actionReq.buttonImage forState: UIControlStateNormal];
        nextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        nextButton.contentVerticalAlignment   = UIControlContentVerticalAlignmentFill;
        nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }else{
        [nextButton setTitle:actionReq.buttonName forState:UIControlStateNormal];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextButton.titleLabel.numberOfLines = 2;
        nextButton.alpha = 0.6;
        if (actionReq.buttonIsOn || (buttonSeq.count == 1))
            nextButton.alpha = 1.0;
    }
    [nextButton addTarget:actionReq action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpInside];
    [nextButton addTarget:actionReq action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpOutside];
#if TARGET_OS_TV
    [nextButton addTarget:actionReq action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventPrimaryActionTriggered];
 //   UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
//    [tapGesture setCancelsTouchesInView:NO];
//    [tapGesture setDelegate:self];
#endif
    [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary setObject:actionReq forKey:[NSString stringWithFormat:@"%li",actionReq.buttonTag]];
}

-(void)touchUpOnButton:(id)sender
{
    [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];

    UIButton * uiButtonPressed = sender;
    NSLog(@"HDButtonView touch up on Button Number %li",(long)uiButtonPressed.tag);
    NSNumber *touchedButton = [NSNumber numberWithInteger:uiButtonPressed.tag];
    NSString *tagString = [touchedButton stringValue];
    ActionRequest *pressedAction = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:tagString];
    
    if (pressedAction.reloadOnly){
        
        [self moveToButtonInCenter:pressedAction.buttonIndex];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];
}

-(void)removeSelectedButtonBoxFromAllRows:(ActionRequest*)aQuery
{
    if(!aQuery)
        return;
   TableDef *currentTableDef = [GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.activeTableDataPtr;
    SectionDef *currentSection = [currentTableDef.tableSections objectAtIndex:aQuery.tableSection];
    NSMutableArray *currentSectionCells = currentSection.sCellsContentDefArr;
    CellButtonsScroll *aButtonsCell;
    CellContentDef *ccDefPtr;
    
    HDButtonView *aMMBtnView;
    for (ccDefPtr in currentSectionCells){
        if([ccDefPtr.ccCellTypePtr isKindOfClass:[CellButtonsScroll class]]){
            aButtonsCell = (CellButtonsScroll*) ccDefPtr.ccCellTypePtr;
            aMMBtnView = [aButtonsCell.buttonView objectAtIndex:0];  // had to put this in array to avoid forward refs
            [aMMBtnView.selectedBtnBox removeFromSuperview];
        }
    }
}

-(void)initButtonInCenterToRow0Btn0
{
    TableDef *currentTableDef = [GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.activeTableDataPtr;
    SectionDef *currentSection = [currentTableDef.tableSections objectAtIndex:0];//aQuery.tableSection];
    NSMutableArray *currentSectionCells = currentSection.sCellsContentDefArr;
    CellContentDef *ccDefPtr = [currentSectionCells objectAtIndex:0];
    CellButtonsScroll* firstButtonRow = (CellButtonsScroll*)ccDefPtr.ccCellTypePtr;
    ActionRequest *firstButton = [firstButtonRow.cellsButtonsArray objectAtIndex:0];
    currentButtonInCenter = firstButton;
    [currentButtonInCenter.uiButton addSubview:selectedBtnBox];
    
}

////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  Scroll View processing
////////////////////////////////////////////////////////////////////////////////////////

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   //  [selectedBtnBox removeFromSuperview];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    if (!decelerate){
        [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
 //       [selectedBtnBox removeFromSuperview];
        CGPoint offset = scrollView.contentOffset;
        CGPoint offsetsv = scrollView.contentOffset;
        
        NSLog(@"controlContainerLine1.contentOffset = (%4.2f, %4.2f)", offset.x,offset.y);
        NSLog(@"scrollView.contentOffset = (%4.2f, %4.2f)", offsetsv.x,offsetsv.y);
 //       if (offset.x > containerView.bounds.size.width*1.25)
 //           offset.x = 0;
        [self updateButtonInCenter:offset];// forScrollView:scrollView];
        if (currentButtonInCenter.reloadOnly){
            NSNumber *touchedButton = [NSNumber numberWithInteger:currentButtonInCenter.uiButton.tag];
            [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
  // [selectedBtnBox removeFromSuperview];
    CGPoint offset = scrollView.contentOffset;
    CGPoint offsetsv = scrollView.contentOffset;
    
    NSLog(@"scrollView.contentOffset = (%4.2f, %4.2f)", offset.x,offset.y);
    NSLog(@"scrollView.contentOffset = (%4.2f, %4.2f)", offsetsv.x,offsetsv.y);
   
 //   if (offset.x > containerView.bounds.size.width*1.25)
 //       offset.x = 0;
    [self updateButtonInCenter:offset];// forScrollView:scrollView];
    if (currentButtonInCenter.reloadOnly){
        NSNumber *touchedButton = [NSNumber numberWithInteger:currentButtonInCenter.uiButton.tag];
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];
    }
   
}
 
-(void)updateButtonInCenter:(CGPoint)offset
{

 //   CGPoint adjustedOffSet = CGPointMake(offset.x+containerView.bounds.size.width/2,offset.y);
    CGPoint adjustedOffSet;// = CGPointMake(offset.x+containerView.bounds.size.width/2,containerView.bounds.size.height/2);
    int selectedButton = 0;
    float closestDistance = 9999;
    
    for (int i = 0; i < buttonSequence.count; i++){
        ActionRequest *aSab = [buttonSequence objectAtIndex:i];
        adjustedOffSet = CGPointMake(offset.x+aSab.uiButton.bounds.size.width/2, offset.y);
        int testDistance = [self distanceBetweenTwoPoints:adjustedOffSet buttonPos:aSab.uiButton.center];
        if ( testDistance < closestDistance){
            closestDistance= testDistance;
            selectedButton = i;//+1;
        }
    }
    
    [self moveToButtonInCenter:selectedButton];// forScrollView:scrollView];// withCurrentSA:currentSpriteAction];
  }
-(void)moveToButtonInCenter:(NSInteger)currentCenterBtnNumber //forScrollView:(UIScrollView*)scrollView
{
  
    ActionRequest *aBtn;
//    [selectedBtnBox removeFromSuperview];
    for (int i = 0; i < buttonSequence.count; i++){
        aBtn= [buttonSequence objectAtIndex:i];
        aBtn.buttonIsOn = NO;
        if (aBtn.buttonIndex == currentCenterBtnNumber){
            currentButtonInCenter = [buttonSequence objectAtIndex:currentCenterBtnNumber];
            currentButtonInCenter.buttonIsOn = YES;
            if (currentButtonInCenter.reloadOnly)
              [currentButtonInCenter.uiButton addSubview:selectedBtnBox];
        }
        
        
    }
    

    
    CGPoint scrollViewOffset = CGPointMake((currentCenterBtnNumber)*(currentButtonInCenter.uiButton.bounds.size.width+buttonSpacing),0);
    
    NSLog(@"moveToButtonInCenter = (%4.2f,%4.2f)",scrollViewOffset.x, scrollViewOffset.y);
    
    [UIView animateWithDuration:0.1f animations:^{
        //       [mvc.controlContainerLine1 setContentOffset:scrollViewOffset];
        containerView.contentOffset = scrollViewOffset;
    }
                     completion:nil];
//    if (currentButtonInCenter.reloadOnly)
//        [[GlobalTableProto sharedGlobalTableProto].liveRuntimePtr reloadCurrentTVC:currentButtonInCenter];
    
    //        CGPoint scrollViewOffset = CGPointMake((currentCenterBtnNumber)*(currentButtonInCenter.sabUIButton.bounds.size.width*1.5),currentButtonInCenter .sabUIButton.center.y);
    //        mvc.controlContainerLine1.contentOffset = scrollViewOffset;
}
-(float)distanceBetweenTwoPoints:(CGPoint)currentPosition buttonPos:(CGPoint)buttonPos
{
    float distance = sqrt(pow((currentPosition.x - buttonPos.x), 2.0) + pow((currentPosition.y - buttonPos.y), 2.0));
    //   DDLogDan(@"Distance Between Sprite Touches = %3.2f", distance);
    return distance;
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - GestureRecognizer
/////////////////////////////////////////////////////////////////////////

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
       // NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator:    section:%d  row:%d",dispAsSection,dispAsRow);
 //   if ([context.nextFocusedView isKindOfClass:[UITableViewCell class]]){
 //       return;
 //   }
        if ([context.previouslyFocusedView isKindOfClass:[UIButton class]]){
         
        UIButton *cellPrev = (UIButton* )context.previouslyFocusedView;
//         cellPrev.superview.backgroundColor=[UIColor clearColor];
        NSString *prevTag = [NSString stringWithFormat:@"%li",cellPrev.tag];
        ActionRequest *prevButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:prevTag];
        NSLog(@"preButton.buttonName = %@",prevButton.buttonName);
        
         [coordinator addCoordinatedAnimations:^{
             context.previouslyFocusedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
             //cellPrev.imageView .transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:nil];
        
        
     }
    if ([context.nextFocusedView isKindOfClass:[UIButton class]]){
        UIButton *cellNext = (UIButton* )context.nextFocusedView;
//        cellNext.superview.backgroundColor=[UIColor greenColor];
        NSString *nextTag = [NSString stringWithFormat:@"%li",cellNext.tag];
        ActionRequest *nextButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:nextTag];
        NSLog(@"nextButton.buttonName = %@",nextButton.buttonName);
        currentButtonInCenter=nextButton;
        selectedButton=nextButton;
        [coordinator addCoordinatedAnimations:^{
            context.nextFocusedView.transform = CGAffineTransformMakeScale(1.6, 1.6);
            // cellNext.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:nil];
        
        if (nextButton.reloadOnly){
            
            currentButtonInCenter=selectedButton;
            [self moveToButtonInCenter:currentButtonInCenter.buttonIndex];
        }
        
    }
    
/*
    if ([context.previouslyFocusedView isKindOfClass:[UITableViewCell class]]){
        
        UITableViewCell *thisTVC = (UITableViewCell*)context.previouslyFocusedView;
        thisTVC.backgroundColor=[UIColor clearColor];
        NSLog(@"");
        
    }
    if ([context.nextFocusedView isKindOfClass:[UITableViewCell class]]){
        UITableViewCell *thisTVC = (UITableViewCell*)context.nextFocusedView;
        thisTVC.backgroundColor=[UIColor greenColor];
        NSLog(@"");
    }
    */
    if ([context.previouslyFocusedView isKindOfClass:[UIView class]]){
        UIView *thisView = (UIView*)context.previouslyFocusedView;
        thisView.backgroundColor=[UIColor clearColor];
        NSLog(@"");
        
    }
    if ([context.nextFocusedView isKindOfClass:[UITableViewCell class]]){
        UITableViewCell *thisTVC = (UITableViewCell*)context.nextFocusedView;
        thisTVC.backgroundColor=[UIColor greenColor];
        NSLog(@"");
           
    }
    

    return;
   
  

}

- (void)tapGestureReceived:(UITapGestureRecognizer *)gesture {

    if (!selectedButton)
        return;
    NSNumber *touchedButton = [NSNumber numberWithInteger:selectedButton.buttonTag];
    
    //   NSNumber *touchedButton1 = [NSNumber numberWithInteger:uiButtonPressed.tag];
    //   NSString *tagString = [touchedButton stringValue];
    
    
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];  // testing tvOS let HDButtonView send this
    
    return;
   }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"COLLECTIONviewCNTRLR GestureAsking permission");
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    //NSLog(@"COLLECTIONviewCNTRLR Gesturerecv touch");
    //NSLog(@"%@", NSStringFromCGPoint([touch locationInView:self.view]));
      return YES;
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"COLLECTIONviewCNTRLR handleLongPress");
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
}
-(void)didSwipeRight: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Right");
    NSLog(@"");
}

-(void)didSwipeLeft: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Left");
    NSLog(@"");
}
-(void)didSwipeUp: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Up");
    NSLog(@"");
}
-(void)didSwipeDown: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Down");
    NSLog(@"");
}


-(void)addButtonViewToContainer:(UIView *)container animated:(BOOL)animated
{
    CGPoint startingViewCenter = container.center;
    if (animated)
        startingViewCenter = CGPointMake(-container.bounds.size.width/2, container.bounds.size.height/2);
    [container addSubview:self];
    self.center = startingViewCenter;
    if (animated){        
        [UIView animateWithDuration:0.5f animations:^{
            CGPoint scrollViewOffset = CGPointMake(container.center.x,self.center.y);
            self.center = scrollViewOffset;
        }
        completion:nil];
    }
}
-(void)removeButtonViewFromContainer:(UIView *)container animated:(BOOL)animated
{
    
    if (animated) {
        [UIView animateWithDuration:1.0f animations:^{
            CGPoint scrollViewOffset = CGPointMake(-container.bounds.size.width/2,self.center.y);
            self.center = scrollViewOffset;
        }
                         completion:nil];
    }
            
    [self removeFromSuperview];

}


/*
+(void)updateThisButton:(ActionRequest *)thisButtonDef aSpriteAction:(MMSpriteAction *)aSpriteAction buttonIsOn:(BOOL)buttonIsOn

{
    int rowNumber = (int)thisButtonDef.hdButton.tag/kButtonRowModulus;
    
    
    #define  kFXNilButtonPlaceholder 99000
    #define kUserSpriteID  40
    //used as offset to button - must stay in numerical order for Theme class debug
    UIImage  *baseImg       = nil;
    UIImage  *someImg       = nil;
    thisButtonDef.buttonIsOn = buttonIsOn;
    

//    someImg = [[Purchased sharedPurchasedMemory] retPNGforIntegerButton:thisButtonDef withAction:aSpriteAction buttonIsOn:YES];
//    baseImg = [[Purchased sharedPurchasedMemory] retPNGforIntegerButton:thisButtonDef withAction:nil buttonIsOn:NO];
    UIButton   *thisUIButton = thisButtonDef.hdButton;
    if (thisButtonDef.buttonID != kFXNilButtonPlaceholder){
    
        [thisUIButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
        thisUIButton.hidden = NO;
        thisUIButton.userInteractionEnabled = YES;
        if (baseImg && !((thisButtonDef.buttonID == kUserSpriteID) && someImg))
                [thisUIButton setImage:baseImg forState:UIControlStateNormal];
        else{
                [thisUIButton setImage: someImg forState:UIControlStateNormal];
                thisUIButton.alpha = 0.6;
            }
            if(buttonIsOn){
            [thisUIButton setImage:someImg forState: UIControlStateNormal];
            thisUIButton.alpha = 1.0;
            }
            if (!someImg){
                thisUIButton.alpha = 1.0;
                thisUIButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
                [thisUIButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [thisUIButton setBackgroundImage:[UIImage imageNamed:@"Speed-Pitch Button Dark.png"] forState:UIControlStateNormal];
                [thisUIButton setTitle:thisButtonDef.buttonName forState:UIControlStateNormal];
                if (buttonIsOn){
                    [thisUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                if (rowNumber == kRow11Buttons) {
                    thisUIButton.layer.cornerRadius = thisUIButton.bounds.size.height/2.0f;
                    thisUIButton.layer.borderColor=[UIColor redColor].CGColor;
                    thisUIButton.layer.borderWidth=2.0f;
                    thisUIButton.backgroundColor = [UIColor lightGrayColor];
                    [thisUIButton setBackgroundImage:nil forState:UIControlStateNormal];
                    thisUIButton.titleLabel.font = [UIFont systemFontOfSize:15];
                    }
        
        }
//        }
    }else
        thisUIButton.hidden = YES;
}
 */
/*
+(void)enableThisSAB:(ActionRequest *)aSAB;
{
    aSAB.hdButton.userInteractionEnabled = YES;
}

+(void)disableThisSAB:(ActionRequest *)aSAB;

{
    aSAB.hdButton.userInteractionEnabled = NO;
}
*/
@end
