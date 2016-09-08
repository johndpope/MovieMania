//
//  SpritesAndButtons.h
//  MAHtst-ARC-ArchiveBuild
//
//  Created by Myra Hambleton on 3/19/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "ProductRecord.h"
//@class CellTypesAll;
#import "HDButtonView.h"
//@class ActionRequest;

@interface ActionRequest : NSObject // <UIGestureRecognizerDelegate>//<NSCoding>

///////////////////////////////////////////////////

@property (nonatomic, readwrite, nullable)          NSString *buttonName;  //used for char key in dictionary
@property (nonatomic, readwrite)                    int buttonType;
@property (nonatomic, readwrite, nullable)          UIButton *uiButton;   //Dan
@property (nonatomic, readwrite)                    BOOL buttonIsOn;      //Dan
@property (nonatomic, readwrite, nullable)          NSString *buttonLabel;
@property (nonatomic, readwrite)                    NSInteger location; // cell, header, footer,..
@property (nonatomic, readwrite)                    NSInteger tableSection;
@property (nonatomic, readwrite)                    NSInteger tableRow;
@property (nonatomic, readwrite)                    NSInteger buttonIndex;
@property (nonatomic, readwrite)                    NSInteger buttonTag;
@property (nonatomic, readwrite, nullable)          UIImage *buttonImage;
@property (nonatomic, readwrite)                    CGSize buttonSize;
@property (nonatomic, readwrite)                    CGPoint buttonOrigin;
@property (nonatomic, readwrite, nullable)          NSMutableArray *buttonArrayPtr;
//@property (nonatomic, readwrite, nullable)          HDButtonView *myButtonView;

@property (nonatomic, readwrite)                    NSInteger nextTableView;
@property (nonatomic, readwrite, nullable)          NSString *transactionKey;
@property (nonatomic, readwrite, nullable)          NSString *dbResponseString;

//@property (nonatomic, readwrite, nullable)          NSMutableDictionary *dataBaseDictsPtrs;
@property (nonatomic, retain, nullable)             NSMutableDictionary *productDict;
@property (nonatomic, retain, nullable)             NSMutableDictionary *locDict;
@property (nonatomic, readwrite, nullable)          NSMutableDictionary *showingInfoDict;
@property (nonatomic, readwrite, nullable)          NSString *aTime;
@property (nonatomic, readwrite)                    BOOL reloadOnly;
@property (nonatomic, readwrite, nullable)          NSDate *buttonDate;
//created by Transaction.m
@property (nonatomic, readwrite, nullable)          NSMutableArray *retRecordsAsDPtrs;  //returned array of dictionary pointers
@property (nonatomic, readwrite)                    int arrayIndex;
@property (nonatomic, readwrite, nullable)          NSString *aiKeyForResultDict;
@property (nonatomic, readwrite, nullable)          NSMutableArray *efLoopArrPtr;
@property (nonatomic, readwrite, nullable)          NSMutableDictionary *loopDictPtr;
@property (nonatomic, readwrite, nullable)          NSMutableDictionary *decryptDict;
@property (nonatomic, readwrite, nullable)          NSString *trailerPath;
@property (nonatomic, readwrite, nullable)          NSString *errorDisplayText;

-(void)killYourself;
-(void)touchUpOnButton:(id)sender;
-(void)touchDownOnButton:(id)sender;
-(void)initButton;
@end
