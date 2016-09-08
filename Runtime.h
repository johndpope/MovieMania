//
//  Runtime.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"
#import "TableViewController.h"
#import "ViewController.h"
#import "IDentifyUser.h"
#import "TestingUserViewController.h"
#import "ActionRequest.h"
//#import "PurchaseRecord.h"
//#import "ProductRecord.h"
//#import "LocationRecord.h"
#import "TableDef.h"

#import "NavCtrl.h"
#import "HoldViewController.h"
//#import "ProdDef.h"
#import "mUtils.h"
#import "DiskStore.h"

#import "Decrypt.h"

//#import "TestingUserViewController.h"
//#import "HDButton.h"
#import "Transaction.h"
@interface Runtime : NSObject




@property (nonatomic, readwrite) DiskStore *diskStorage;
@property (nonatomic, retain) NSMutableArray *allEnteredFields;

@property (nonatomic, readwrite) ViewController *rtStarupRVC;

@property (nonatomic, readwrite) TableViewController *rtTableViewCtrler;

@property (nonatomic, readwrite) NavCtrl *rtNavCtrler;
@property (nonatomic, readwrite) HoldViewController *holdVCtrler;




@property (nonatomic, retain)     NSMutableDictionary       *allLocationsHDI;

@property (nonatomic, readwrite)   NSMutableDictionary      *allProductDefinitions_HDI;
@property (nonatomic, readwrite)   NSMutableDictionary      *allProductInventory_HDI;



@property (nonatomic, readwrite) TestingUserViewController *myTestingVC;

@property (nonatomic, readwrite) NSArray *locationByIDkeys;


@property (nonatomic, readwrite)    NSMutableArray *movieNamesForImageDownloads;
@property (nonatomic, readwrite)       NSMutableDictionary       *movieImageDictionary;
@property (nonatomic, readwrite)BOOL movieImageDictionaryWTD;//writeToDisk

@property (nonatomic, retain)       NSMutableDictionary       *movieImageDictionaryPath;
@property (nonatomic, readwrite)    NSMutableArray         *movieTrailers;

@property (nonatomic, readwrite) NSMutableDictionary    *allMovieTrailersTMS;
@property (nonatomic, readwrite) NSMutableDictionary    *allMovieTrailersHDI;
@property (nonatomic, readwrite)BOOL allMovieTrailersHDIdictWTD;//writeToDisk


@property (nonatomic, retain) NSMutableDictionary *gImageDictionary; //global image dictionary - uses some cache?
@property (nonatomic, retain) NSMutableDictionary *gInputFieldsDictionary; //global input fields dictionary - holds what users enter through screens

@property (nonatomic,readwrite) GlobalTableProto *gGTPptr;

@property (nonatomic,readwrite) TableDef *activeTableDataPtr;
@property(nonatomic, readwrite) CGRect posWindowRect; //assigned once
@property(nonatomic, readwrite) CGRect posTopRect;   //reassigned based on active table
@property(nonatomic, readwrite) CGRect posCenterRect; //reassigned based on active table
@property(nonatomic, readwrite) CGRect posBottomRect; //reassigned based on active table


@property(nonatomic, readwrite) UIView *forNavHeaderUIView;
@property(nonatomic, readwrite) UIView *forNavFooterUIView;
@property(nonatomic, readwrite) UIView *forNavTVCview;

@property(nonatomic, readwrite)int queryMode;

@property(nonatomic, readwrite)int autoCounter;
@property(nonatomic, readwrite) AutomatedXACT *autoInUsePtr;



//-(void) authUserVC:(NSString *)userID  withPW:(NSString *)userPW withActionReq:(ActionRequest *)aQuery;
-(void)displayATVC:(TableDef *)thisTDataPtr pressedBtn:(ActionRequest *)pressedBtn;
-(void)startRunTime;
// for product string explode test
//-(NSMutableDictionary*) buildProductDictionary:(int)numberOfMoviesPerDay;
//-(ProductRecord *)buildProductFromDBDictionary:(NSDictionary*)aProductDict;
//-(NSMutableArray*)buildPurchaseDictionaryArrayForAProduct:(ActionRequest *)aProductTimeBtn;
//-(LocationRecord*)buildLocationFromDBDictionary:(NSDictionary*)aLocationDic;
//-(NSMutableDictionary*) convertLocationArrayToDictionary:(ActionRequest *)aQuery;
//-(void)reloadCurrentTVC:(ActionRequest*)pressedBtn;


-(void)logwhatsup;
@end
