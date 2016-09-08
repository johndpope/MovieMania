//
//  ProductRecord.m
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "ProductRecordOld.h"

@implementation ProductRecordOld
@synthesize productName, productInfoDict, productImage, productTimes,purchaseRecords;
@synthesize locationName, locationZip, implodedTimes, locationDate, productID;

-(id) init
{
    self = [super init];
    if (self) {
        productTimes= [[NSMutableArray alloc] init];
        purchaseRecords = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
