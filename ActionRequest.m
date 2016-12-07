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
@synthesize errNOTFOUNDLoopArrPtr;  //new keep track of what queries got  404 or 204

@synthesize tableRow, tableSection;
@synthesize showingInfoDict;
@synthesize buttonDate;
@synthesize decryptDict;
@synthesize trailerPath;
@synthesize productDict,locDict;
@synthesize buttonType;
@synthesize errorDisplayText;
@synthesize buttonOrigin;
@synthesize buttonIndexPath;

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
    
    [errNOTFOUNDLoopArrPtr removeAllObjects];
    errNOTFOUNDLoopArrPtr=nil;
    
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
    NSLog(@"ActionRequest tapRecognizer %li",(long)uiButtonPressed.tag );
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


-(void)primaryActionTriggered:(id)sender   //touchUpInside, touchUpOutside
{
    UIButton * uiButtonPressed = sender;
    NSLog(@"ActionRequest primary action triggered %li",(long)uiButtonPressed.tag );
    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];
}

-(void)touchUpOnButton:(id)sender
{
    UIButton * uiButtonPressed = sender;
    NSLog(@"ActionRequest touch up on Button Number %li",(long)uiButtonPressed.tag );
    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];
    
  //  NSLog(@"myra disable sending notification ConstUserTOUCHINPUT in ActionRequest touchUpOnButton");
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];  // testing tvOS let HDButtonView send this
}
-(void)cellButtonTouched:(UIButton*)button
{
    NSLog(@"ActionRequest   cellButtonTouched:") ;
    //SELF CONTAINS POINTER TO DATA
    
}

- (void)cellTapped:(UITapGestureRecognizer *)gesture {
    
    NSLog(@"ActionRequest  cellTapped:  ");
    //SELF CONTAINS POINTER TO DATA
    
}




   @end
