//
//  PurchaseRecord.h
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TheaterRecord.h"
//#import "MovieRecord.h"
//#import "LocationRecord.h"
//#import "ProductRecord.h"
@interface PurchaseRecord : NSObject
@property (nonatomic, retain) NSMutableDictionary *purchaseLocDict;
@property (nonatomic, retain) NSMutableDictionary *aProductDict;
@property (nonatomic, retain) NSString *purchaseDate;
@property (nonatomic, retain) NSString *purchaseTime;
@property (nonatomic, retain) NSMutableArray *allPurchaseTypes;
@end
