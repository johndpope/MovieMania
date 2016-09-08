//
//  SpritesAndButtons.m
//  MAHtst-ARC-ArchiveBuild
//
//  Created by Myra Hambleton on 3/19/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//
//
//    new for 2013
//    includes themes and buttons for sprites
//
#import "ActionRequest.h"
#import "GlobalTableProto.h"
//#import "CellTypesAll.h"

@implementation ActionRequest
{
    UITapGestureRecognizer *tapGesture;
}
//@synthesize hdButton, buttonIsOn, buttonName, buttonID, buttonLabel;

@synthesize buttonName, buttonLabel, buttonTag,buttonImage,  buttonSize, buttonIndex, buttonArrayPtr,  buttonIsOn, uiButton, nextTableView;
@synthesize transactionKey, dbResponseString;
@synthesize retRecordsAsDPtrs;
@synthesize  aTime;
@synthesize  reloadOnly;
//@synthesize dataBaseDictsPtrs;
@synthesize arrayIndex,loopDictPtr,aiKeyForResultDict,efLoopArrPtr; //loop through array for send, store results in dict with array key
@synthesize tableRow, tableSection;
@synthesize showingInfoDict;
@synthesize buttonDate;
@synthesize decryptDict;
@synthesize trailerPath;
@synthesize productDict,locDict;
@synthesize buttonType;
@synthesize errorDisplayText;
@synthesize buttonOrigin;

//@synthesize myButtonView;
//@synthesize buttonDate;

-(id) init
{
    self = [super init];
    if (self) {
        
//       dataBaseDictsPtrs = [[NSMutableDictionary alloc] init];
        arrayIndex=0;
        aiKeyForResultDict=nil;
/*
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
        tapGesture.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeSelect]];
        [self.uiButton addGestureRecognizer:tapGesture];
        [tapGesture setCancelsTouchesInView:NO];
        [tapGesture setDelegate:self];
*/
    }
    return self;
}
-(void)killYourself
{
    buttonName = nil;
    buttonLabel = nil;
//    dataRecordKey = nil;
//    dataRecords = nil;
    buttonImage = nil;
//    dataRecordKey = nil;
    buttonArrayPtr = nil;
 //   enteredTextArray = nil;
    uiButton = nil;
//    myParentCell = nil;
    transactionKey = nil;
    dbResponseString = nil;
//    dataBaseDict = nil;
//    aLocDict = nil;
//    aProductDict = nil;
//    [dataBaseDictsPtrs removeAllObjects];
//    dataBaseDictsPtrs = nil;
    
    [loopDictPtr removeAllObjects];
    loopDictPtr=nil;
    aiKeyForResultDict=nil;
    
    
    [decryptDict removeAllObjects];
    decryptDict=nil;
    [efLoopArrPtr removeAllObjects];
    efLoopArrPtr=nil;
}
-(void)tapRecognized:(id)sender
{
    UIButton * uiButtonPressed = sender;
    NSLog(@"ActionRequest touch up on Button Number %li",(long)uiButtonPressed.tag );
    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];
}
-(void)touchDownOnButton:(id)sender
{
#if TARGET_OS_TV
    UIButton * uiButtonPressed = sender;
    NSLog(@"ActionRequest touch down on Button Number %li",(long)uiButtonPressed.tag );
    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];

#endif

}


-(void)touchUpOnButton:(id)sender
{
    UIButton * uiButtonPressed = sender;
    NSLog(@"ActionRequest touch up on Button Number %li",(long)uiButtonPressed.tag );
    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];
    
 //   NSNumber *touchedButton1 = [NSNumber numberWithInteger:uiButtonPressed.tag];
 //   NSString *tagString = [touchedButton stringValue];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];  // testing tvOS let HDButtonView send this
}
-(void)cellButtonTouched:(UIButton*)button
{
 //   NSLog(@"CELLTVCONTROL   cellButtonTouched:%p) Hit AL:%@  cell says section:%d row:%d ",self,button.accessibilityLabel,dispAsSection,dispAsRow);
    //SELF CONTAINS POINTER TO DATA
    
}

- (void)cellTapped:(UITapGestureRecognizer *)gesture {
    
//    NSLog(@"CELLTVCONTROL   cellTapped: %p  cell section:%d row:%d ",self,dispAsSection,dispAsRow);
    //SELF CONTAINS POINTER TO DATA
    
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Focus
/////////////////////////////////////////////////////////////////////////
/*
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    /* this gets called twice for every tv arrow movement.
     collectionViewController only gets called once  */
    
    // NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator:    section:%d  row:%d",dispAsSection,dispAsRow);
    
 //  UITableViewCell *nextInFocus_cellControlPtr= (UITableViewCell    *)context.nextFocusedView;
//    CustomTVCellControl *prevInFocus_cellControlPtr= (CustomTVCellControl *)context.previouslyFocusedView;
/*
    if (self == nextInFocus_cellControlPtr) {
        NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator: (NEXT)   section:%d  row:%d",dispAsSection,dispAsRow);
//        self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorSELECTED;
//        self.transform= CGAffineTransformMakeScale(1.1, 1.1);
        // self.highlighted=YES;
        // [self setSelected:YES];
    }
    if (self == prevInFocus_cellControlPtr) {
        NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator: (PREV)   section:%d  row:%d",dispAsSection,dispAsRow);
        // self.highlighted=NO;   these mess up in simulator
        //[self setSelected:NO];   these mess up in simulator  can get multiple highlighted
        self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorDESELECTED;
        self.transform= CGAffineTransformMakeScale(1.0, 1.0);
 */
        
//    }



   @end