//
//  LocationRecord.m
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 5/5/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "LocationRecordOld.h"

@implementation LocationRecordOld
@synthesize locationName, locationStreetAddress, locationCity, locationState, locationZip,  locationDate, locationProducts;//, implodedProductNames;
-(id) init
{
    self = [super init];
    if (self) {
        //       moviesShowing = [[NSMutableArray alloc] init];
      //  locationDate = @"Today";
        locationProducts = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

@end
