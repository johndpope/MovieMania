//
//  GlobalTableProto.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"


#import "TableProtoDefines.h"
#import "TableDef.h"
#import "SectionDef.h"
#import "CellTextDef.h"
#import "CellContentDef.h"
#import "CellInputField.h"
#import "ActionRequest.h"
//#import "LocationRecord.h"
//#import "ProductRecord.h"
#import <UIKit/UIKit.h>
#import "Transaction.h"//NEW
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YTPlayerView.h"
#import "YTViewController.h"

#import "PurchaseRecord.h"

@class Runtime;
@interface GlobalTableProto : NSObject <YTPlayerViewDelegate>
@property (nonatomic, readwrite) BOOL debugFlag; //TRUE gives prevents automatic startup processing; exposes buttons

@property (nonatomic, readwrite) NSMutableArray *tablesToDisplayArray;
@property (nonatomic, retain) NSMutableDictionary *allButtonsDictionary;

@property (nonatomic, readwrite) NSMutableDictionary *allEntryFieldsDictionary;

@property (nonatomic, retain)  NSDate *selectedDate;
@property (nonatomic, retain)  NSMutableDictionary *selectedLocDict;
@property (nonatomic, retain)  NSMutableDictionary *selectedProdcuctDict;

extern NSString* const ConstDoneLoopingXactionResponseProcessed;

//@property (nonatomic, retain) ActionRequest *actionForReloadingView;
@property (nonatomic, readwrite) BOOL thisUserValid;

@property (strong, nonatomic) Runtime *liveRuntimePtr;
@property (nonatomic, readwrite) BOOL inAVPlayerVC;
@property (nonatomic, readwrite) UIColor *viewTextColor;
@property (nonatomic, readwrite) UIColor *viewBackColor;
@property (nonatomic, readwrite) UIColor *cellBackColor;
@property (nonatomic, readwrite) UIColor *headerBackColor;
@property (nonatomic, readwrite) CGSize sizeGlobalButton;   //manipulate based on IOS or TVOS
@property (nonatomic, readwrite) CGSize sizeGlobalPoster;   //manipulate based on IOS or TVOS
@property (nonatomic, readwrite) CGSize sizeGlobalVideo;   //manipulate based on IOS or TVOS
@property (nonatomic, readwrite) int sizeGlobalTextFontBig;    //manipulate based on IOS or TVOS
@property (nonatomic, readwrite) int sizeGlobalTextFontMiddle;    //manipulate based on IOS or TVOS
@property (nonatomic, readwrite) int sizeGlobalTextFontSmall;    //manipulate based on IOS or TVOS

@property (nonatomic, readwrite) NSString *globalZipCode;

@property (nonatomic, readwrite) CGRect currentActiveTVRect;
@property (nonatomic, readwrite) BOOL inTVOS;
//@property (nonatomic, readwrite) ActionRequest   *currentButtonInCenter;


@property (nonatomic, readwrite) BOOL runningSimulator;
extern NSString* const ConstIDentifyUserControllerSuccess ;
extern NSString* const ConstIDentifyUserControllerFailure ;
extern NSString* const ConstTVCDisplayVisible ;
extern NSString* const ConstTVCDisplayedNotifyRuntime;
extern NSString* const ConstUserTouchInput;
extern NSString* const ConstUserFocusMovie;
extern NSString* const ConstContinueLoopingTransaction;
extern NSString* const ConstNEWZIPstartOver;
extern NSString* const ConstUserSpeechUtterance;

//-(NSInteger) giveMeUniqueNSInteger;

//-(NSNumber *) giveMeUniqueNSNumber;
-(NSInteger) giveMeUniqueNSIntegerForDisplayTag;

+(GlobalTableProto *)sharedGlobalTableProto;
-(TableDef *)makeTVC:(ActionRequest *)pressedBtn;
//-(TableDef *)makeTVC2:(ActionRequest*)pressedBtn;
//-(TableDef *)makeTVC2m:(ActionRequest *)pressedButton ;  //myra changed this. hybrid can ref odbc movieInfo and TMS info

-(TableDef *)makeTVCInitDBs:(ActionRequest *)pressedButton;
/*
-(void)putLocationDictInParent:(ActionRequest *)aQuery locDict:(NSMutableDictionary *)aLocDict;
-(NSMutableDictionary *)fetchLocationDict:(ActionRequest *)aQuery;
-(void)putProductDictInParent:(ActionRequest *)aQuery productDict:(NSMutableDictionary *)aProductDict;
-(NSMutableDictionary *)fetchProductDict:(ActionRequest *)aQuery;
 */
-(void)logwhatsup;
@end
