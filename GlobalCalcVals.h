//
//  GlobalCalcVals.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//
//
//     DATA holder.....
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableProtoDefines.h"
//D O    N O T   I M P O R T   A N Y T H I N G   E L S E
//




@interface GlobalCalcVals : NSObject



@property (nonatomic, readwrite) CGFloat tableCreatedHeight;
@property (nonatomic, readwrite) CGFloat tableCreatedWidth;


//@property (nonatomic, retain) TableViewController *tvc;

+(GlobalCalcVals *)sharedGlobalCalcVals;
-(UIStackView *) makeComplexStackView;

@end