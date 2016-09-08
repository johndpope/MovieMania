//
//  Decrypt.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableProtoDefines.h"
#import "ActionRequest.h"


@interface Decrypt : NSObject


+(void)performALLPreProcess:(ActionRequest*)arPtr;
//+(NSMutableArray *)performALLPreProcess:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray;

+(NSMutableArray *)arrFromDecryptDictForKey:(NSString *)hdiKey inDict:(NSMutableDictionary*)searchDict decryptDict:(NSMutableDictionary*)decryptDict;

+(NSString *)valForHDIKey:(NSString *)hdiKey inDict:(NSMutableDictionary*)searchDict decryptDict:(NSMutableDictionary*)decryptDict;

+(NSString *)convertDictionaryToJSON:(NSMutableDictionary*)myDict;

-(void) killYourself;

@end
