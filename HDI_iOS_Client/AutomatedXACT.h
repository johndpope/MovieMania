//
//  AutomatedXACT.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GlobalTableProto.h"


@interface AutomatedXACT : NSObject




//Define runtime portion of automated xactions (DB queries now)



@property (nonatomic, readwrite) NSString *buttonTitle; //legacy naming


-(void) killYourself;

@end
