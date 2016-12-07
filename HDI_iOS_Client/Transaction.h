//
//  Transaction.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

#import "GlobalTableProto.h"
#import "TransactionData.h"
#import "IDentifyUModel.h"
#import "ActionRequest.h"   //delete this later

@interface Transaction : NSObject

@property (nonatomic, readwrite) UIView *viewActive;
@property (nonatomic, readwrite) NSNumber* queryNumber;
@property (nonatomic, readwrite) NSString *queryTitle;
@property (nonatomic, readwrite) NSString *description;


@property (nonatomic, readwrite) NSString *transactionKey;



@property (nonatomic, readwrite) NSString *URL;




@property (nonatomic, readwrite) NSString *errorLocalDescr;   //just because I want to save it  ( can remove later)


@property (nonatomic, readwrite)  ASIHTTPRequest *dbQandA;  //db request contains answer too


@property (nonatomic, readwrite) ActionRequest *actReqPtr;   //for post notification


@property (nonatomic, readwrite) NSMutableArray *retRecordsAsDPtrs;  //returned array of dictionary pointers


@property (nonatomic, readwrite) int loopingPosition; //used by 
@property (nonatomic, readwrite) BOOL loopingActive;
@property (nonatomic, readwrite) UIView *storeView;
@property (nonatomic, readwrite) NSMutableArray *storeloopingDataArrayPtr;
@property (nonatomic, readwrite) NSMutableArray *storeKeyArrayPtr;
@property (nonatomic, readwrite) NSString *storeKeyString;
@property (nonatomic, readwrite) ActionRequest *storeActReq;
@property (nonatomic, readwrite) NSMutableArray *storeSentVariablesArrayPtr;
@property (nonatomic, readwrite) NSString *storeStringSubstituted; //this is typically key in response storage....
@property (nonatomic, readwrite) NSMutableDictionary *storeDictForResults;


@property (nonatomic, readwrite) BOOL queryReturns404IsError; //if this query returns 404 (not Found status)  report as FATAL ERROR or not?


-(void) killYourself;
-(id) initWithQTitle:(NSString *)title andQDescr:(NSString *) descr andNumber:(int) num;

-(BOOL) beginTransactionViewActive:(UIView *)inView carryAlongDummyData:(ActionRequest *)stuffedActionPointer usingDataArray:(NSMutableArray *)variablesArray;
-(BOOL) loopingTransactionOnView:(UIView *)inView actionReq:(ActionRequest *)stuffedActionPointer usingSendDataArray:(NSMutableArray *)variablesArray loopingKey:(NSString*)thisKey loopArrData:(NSMutableArray *)stringArray retDictWithLoopArrrDataKey:(NSMutableDictionary*)retDictPtr storingKeyArray:(NSMutableArray *)storingKeyArray;



-(BOOL) loopingTransactionViewActive:(UIView *)inView actReq:(ActionRequest *)actPointer usingDataArray:(NSMutableArray *)variablesArray;


@end
