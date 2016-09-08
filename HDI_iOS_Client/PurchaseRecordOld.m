//
//  PurchaseRecord.m
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "PurchaseRecordOld.h"

@implementation PurchaseRecordOld
@synthesize  aProductDict,allPurchaseTypes, purchaseDate, purchaseTime;
//@synthesize purchaseLocRec;
@synthesize purchaseLocDict;

-(id) init
{
    self = [super init];
    if (self) {
//       productNames = [[NSMutableArray alloc] init];
//       productPrices = [[NSMutableArray alloc] init];
//       productQuantities = [[NSMutableArray alloc] init];
//        productInfo = [[NSMutableDictionary alloc] init];
        allPurchaseTypes = [[NSMutableArray alloc] init];
    }
    return self;
  }

@end
