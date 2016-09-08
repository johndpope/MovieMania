//
//  TransactionData.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface TransactionData : NSObject



@property (nonatomic, readwrite) NSString *queryKey;  //the query field itself like @"validUserID"   or @"validUserPW"
@property (nonatomic, readwrite) NSString *userDefinedData;//default data in here?   becomes placeholder text for UIInputFields??





-(void) killYourself;




@end
