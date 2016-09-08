//
//  ProductRecord.h
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "LocationRecord.h"

@interface ProductRecordOld : NSObject
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) UIImage *productImage;
@property (nonatomic, retain) NSMutableDictionary *productInfoDict;
@property (nonatomic, retain) NSMutableArray *productTimes;
//@property (nonatomic, retain) LocationRecord *selectedLocation;
@property (nonatomic, retain) NSMutableArray *purchaseRecords;
@property (nonatomic, retain) NSString *locationName;
@property (nonatomic, retain) NSString *locationZip;
@property (nonatomic, retain) NSString *implodedTimes;
@property (nonatomic, retain) NSString *locationDate;
@property (nonatomic, retain) NSString *productID;

@end
