//
//  LocationRecord.h
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationRecordOld : NSObject
@property (nonatomic, retain) NSString *locationName;
@property (nonatomic, retain) NSString *locationStreetAddress;
@property (nonatomic, retain) NSString *locationCity;
@property (nonatomic, retain) NSString *locationState;
@property (nonatomic, retain) NSString *locationZip;
@property (nonatomic, retain) NSString *locationDate;
@property (nonatomic, retain) NSMutableDictionary *locationProducts;
//@property (nonatomic, retain) NSString *implodedProductNames;
@end
