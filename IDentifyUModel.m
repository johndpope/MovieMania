//
//  IDentifyUModel.m
//  JSONModel
//


#import "IDentifyUModel.h"
#import "JSONKeyMapper.h"

@implementation IDentifyUModel

+(JSONKeyMapper*)keyMapper
{
    //data returned is   {"unlock_code":"allValid"}
    //mapperFromUnderscoreCaseToCamelCase  means   unlock_code is unlockCode
    //
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end