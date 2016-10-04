//
//  Decrypt.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "Decrypt.h"

@implementation Decrypt









///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Destroy
/////////////////////////////////////////
-(void) killYourself
{

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////

-(id) init
{
    self = [super init];
    if (self) {
        
        [self makeUseDefaults];
    }
    return self;
}


-(void) makeUseDefaults
{
    
   


}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Execution Methods
/////////////////////////////////////////
+(NSMutableArray *)performMERGEPprocess:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray
{
    NSMutableArray *returnArrayOfDict;

    NSMutableDictionary *mergeDefDict;
    

    
    NSMutableDictionary *alreadyTherePtr;
    NSMutableDictionary *idsUniqueInDict=[[NSMutableDictionary alloc]init];
    NSMutableArray *alreadyArray;
    NSMutableArray *newArray;
    NSMutableArray *checkitArr;
    NSString *statickey2Unique;
    NSString *val2Unique;  //value of statickey2unique
    
    
            //go thru array of dictionaries
            //create unique dictionary of dictionaries [MAKES UNIQUE-ISM EASY]
            //merge whatever fields are told
            //turn unique dictionary back into array of dictionaries to return
            
            mergeDefDict=[decryptDict valueForKey:kDECRYPT_P_MERGEPROCESS];
            NSArray * addKeysArr=[mergeDefDict  objectForKey:kDECRYPT_P_MERGEFIELDS ];
            
            statickey2Unique=[mergeDefDict valueForKey:kDECRYPT_P_MERGEONKEY];
            
            
            
            
            int looper=0;
            
            for (NSMutableDictionary *aRecord in thisDataArray)   //thidDataArray is an array of dictionaries
            {
                looper++;
                val2Unique=[aRecord objectForKey:statickey2Unique];
                alreadyTherePtr=[idsUniqueInDict objectForKey:val2Unique];
                if (alreadyTherePtr) {
                    //merge alreadyThere and aRecord    the value of key 'showtimes' is an array.  addObjectsFromArray
                    //LOOP THROUGH ARRAY OF KEYS THAT ADD....
                    
                    
                    for (NSString *kstr in addKeysArr)
                    {
                        alreadyArray=[alreadyTherePtr objectForKey:kstr];
                        // NSLog(@"alreadyArray %p count %lu",alreadyArray,(unsigned long)[alreadyArray count]);
                        newArray=[aRecord objectForKey:kstr];
                        [alreadyArray addObjectsFromArray:newArray];
                        // NSLog(@"alreadyArray %p count %lu",alreadyArray,(unsigned long)[alreadyArray count]);
                        NSLog(@"FOUND DUP");
                        checkitArr=[alreadyTherePtr objectForKey:kstr];
                        //NSLog(@"checkitArr %p count %lu",checkitArr,(unsigned long)[checkitArr count]);
                        // NSLog(@"");
                    }
                    
                    
                }
                else{  //add it its not already in there
                    [idsUniqueInDict setObject:aRecord forKey:val2Unique];
                }
            }//end for all data in array of dictionaries
            returnArrayOfDict=[[NSMutableArray alloc]init];
            for(id key in idsUniqueInDict) {
                id value = [idsUniqueInDict objectForKey:key];
                [returnArrayOfDict addObject:value];
            }
    
    return returnArrayOfDict ;

}
+(void) performFLATTEN_ARRAY_INTOSTRING_process:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray
{
    /* "HDI_PROCESS FLATTENARRAY_TOSTRING" :[
     {"genres" : ","},
     {"topCast" : ","},
     {"directors" : ","},
     {"advisories" : ","},
     ],
     */
    NSMutableArray *modifyDefinitionArrOfDict=[decryptDict valueForKey:kDECRYPT_P_FLATTEN_ARRAY_TOSTRING];
    
    NSString *thisUniqueKey=[decryptDict valueForKey:kDECRYPT_REQ_UNIQUEKEY];  //"rootId" actual data key found in decrypt record
    
    //thisUiniqueKey is how to get stuff in thisDataArray (array of dictionaries)
    NSArray *allKeysArr;
    NSString *stringDelimeter;
    NSString *thisKey2Flatten;
    NSArray *arrayValOfKey2Flatten;
    
    
    for (NSMutableDictionary *aRecord in modifyDefinitionArrOfDict)   //thidDataArray is an array of dictionaries
    {
        allKeysArr=[aRecord allKeys];
        thisKey2Flatten=[allKeysArr objectAtIndex:0];  //its an array, but ALWAYS only of size 1 element
        stringDelimeter=[aRecord valueForKey:thisKey2Flatten];
  
            for (NSMutableDictionary *dataRecord in thisDataArray)   //thidDataArray is an array of dictionaries
            {
                arrayValOfKey2Flatten=[dataRecord objectForKey:thisKey2Flatten];
                NSString* newValFlatString=@"";
                
                if ([arrayValOfKey2Flatten count]) {
                    newValFlatString = [arrayValOfKey2Flatten componentsJoinedByString:stringDelimeter];
                }
                [dataRecord setObject:newValFlatString forKey:thisKey2Flatten];
                
                
            }//end for all data loop
            
        
    }//end for all modify fields loop

}
+(void) performREPLACE_STRING_TRAILS_process:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray
{
    NSMutableArray *modifyDefArrayOfDictionaries=[decryptDict valueForKey:kDECRYPT_P_REPLACE_FIELD_STRINGTRAILS];
    /* 
     "HDI_OPT Process" : [
        "           ",
        "HDI_PROCESS REPLACEFIELDstringTrails"
        ],
     "HDI_PROCESS REPLACEFIELDstringTrails" :[
                                             {"title" : "3D"},
                                             {"bogusKey" : "BogusValue"}
                                             ],
    */
    
    NSString *thisUniqueKey=[decryptDict valueForKey:kDECRYPT_REQ_UNIQUEKEY];  //"rootId" actual data key found in decrypt record
    
    //thisUiniqueKey is how to get stuff in thisDataArray (array of dictionaries)
        NSArray *allKeysArr;
    
    
    NSString *valToFind;
    NSString *thisKey2;
   
    
    NSString *valOfSearchKey;
    NSString *isThisIt;
    
    for (NSMutableDictionary *aRecord in modifyDefArrayOfDictionaries)   //thidDataArray is an array of dictionaries
    {
        allKeysArr=[aRecord allKeys];
        thisKey2=[allKeysArr objectAtIndex:0];  //its an array, but ALWAYS only of size 1 element
        valToFind=[aRecord valueForKey:thisKey2];
        if (valToFind) {
            int lengthOfFindString=(int)[valToFind length];
            for (NSMutableDictionary *aRecord in thisDataArray)   //thidDataArray is an array of dictionaries
            {
                valOfSearchKey=[aRecord objectForKey:thisKey2];
                int lengthOfSearchKeyVal = (int)[valOfSearchKey length];
                if (lengthOfSearchKeyVal > lengthOfFindString) {
                   

                    isThisIt=[valOfSearchKey substringFromIndex:lengthOfSearchKeyVal - lengthOfFindString];
                    
                    if ([isThisIt isEqualToString:valToFind]) {
                        NSString *newStr;
                        
                        newStr = [valOfSearchKey substringToIndex:[valOfSearchKey length]-lengthOfFindString];
                        
                        [aRecord setObject:newStr forKey:thisKey2];
                    }
                }
                
                
  
                
            }//end for loop
 
        }//end if valToFind
    }//end for loop
    
    
    
}

+(void) performREMOVE_STRING_BEGINS_process:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray
{
    NSMutableArray *returnArrayOfUniqueKeysToDeleteFromDict;
    NSMutableArray *removeArrayOfDictionaries;
    NSArray *allKeysArr;

   /*
    "HDI_PROCESS REMOVERECORDstringBegins" : [
    {"tmsId" : "EV"},
    {"bogusKey" : "BogusValue"}
    ],
    
    */
     NSString *thisUniqueKey=[decryptDict valueForKey:kDECRYPT_REQ_UNIQUEKEY];  //"rootId" actual data key found in decrypt record
    
    NSString *valToFind;
    NSString *thisKey2;
    NSString *checkIDValue;
    BOOL found=FALSE;
    removeArrayOfDictionaries=[decryptDict valueForKey:kDECRYPT_P_REMOVE_RECORD_STRINGBEGINS];
    for (NSMutableDictionary *aRecord in removeArrayOfDictionaries)   //thidDataArray is an array of dictionaries
    {
        allKeysArr=[aRecord allKeys];
        thisKey2=[allKeysArr objectAtIndex:0];  //its an array, but ALWAYS only of size 1 element
        valToFind=[aRecord valueForKey:thisKey2];
            //remove all records with thisKey  if value begins with string   valToFind
        if (valToFind) {
            
            returnArrayOfUniqueKeysToDeleteFromDict=[self buildArrayOfDeleteRecordsIfKey:thisKey2 hasBeggingStringContaining:valToFind onDataResponse:thisDataArray usingUniqueKey:thisUniqueKey];
            for (NSString *aUniqueKeyHasValue in returnArrayOfUniqueKeysToDeleteFromDict)   //thidDataArray is an array of dictionaries
            {
                NSLog(@"delete this record %@",aUniqueKeyHasValue);
                
            
                found=FALSE;
                NSMutableDictionary *loopDictPtr;
                for (int index=0; index < [thisDataArray count]; index++) {
                    loopDictPtr=[thisDataArray objectAtIndex:index];
                    checkIDValue=[loopDictPtr valueForKey:thisUniqueKey];//[obj objectForKey:@"rootId"];
                    
                    if ([checkIDValue isEqualToString:aUniqueKeyHasValue]) {
                        //do nothing, no key to file it in
                        found=TRUE;
                        [thisDataArray removeObjectAtIndex:index];
                        index=(int)[thisDataArray count];
                    }


                }
                
                
                NSLog(@"");
            }
        }

                               
        NSLog(@"");
        
    }
}
+(NSMutableArray *) buildArrayOfDeleteRecordsIfKey:(NSString *)thisKey hasBeggingStringContaining:(NSString *) thisValue onDataResponse:(NSMutableArray*)thisDataArray usingUniqueKey:(NSString*)uniqueKey

{
    
    NSString *answer;
    NSString *valOfUniqueKey;
    
    NSMutableArray *postProcessRemoveArray=[[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *aRecord in thisDataArray)   //thidDataArray is an array of dictionaries
    {
        answer=[aRecord objectForKey:thisKey];
        valOfUniqueKey=[aRecord objectForKey:uniqueKey];
        if ([[answer substringToIndex:2] isEqualToString:thisValue]) {
            //remove aRecord from thisDataArray
            [postProcessRemoveArray addObject: valOfUniqueKey];
        }
        
    }
    
    return postProcessRemoveArray ;
    
}
+(void) dumpSpecialTMS:(NSMutableArray*)thisDataArray
{
    
    NSString *valOfTitle;
    NSString *valOfTMSid;
    NSString *valOfrootId;
    
    for (NSMutableDictionary *aRecord in thisDataArray)   //thidDataArray is an array of dictionaries
    {
        valOfTitle=[aRecord objectForKey:@"title"];
        valOfTMSid=[aRecord objectForKey:@"tmsId"];
        valOfrootId=[aRecord objectForKey:@"rootId"];
        NSLog(@"ID:%@ root:%@ Title: %@",valOfTMSid,valOfrootId,valOfTitle);
        
    }
    NSLog(@"");
}
//+(NSMutableArray *)performALLPreProcess:(NSMutableDictionary *)decryptDict onDataResponse:(NSMutableArray*)thisDataArray
+(void)performALLPreProcess:(ActionRequest*)arPtr
{
    NSMutableArray *thisDataArray=arPtr.retRecordsAsDPtrs;   //array of dictionaries
    NSMutableDictionary *decryptDict=arPtr.decryptDict;
    
    NSMutableArray *returnArrayOfDict;
    NSMutableArray *processArray=[decryptDict valueForKey:kDECRYPT_OPT_PROCESS];
    
    
   // NSLog(@"*****BEGIN  count:%lu",(unsigned long)[thisDataArray count]);
   // [self dumpSpecialTMS:thisDataArray];
    
    
    for (NSString *whatProcess in processArray) {
        if ([whatProcess isEqualToString:kDECRYPT_P_MERGEPROCESS]) {
            returnArrayOfDict=[self performMERGEPprocess:decryptDict onDataResponse:thisDataArray];
            //DESTROY thisDataArray
            [thisDataArray removeAllObjects];
            thisDataArray=nil;
            thisDataArray=returnArrayOfDict;
            arPtr.retRecordsAsDPtrs=returnArrayOfDict;
          }
        
        if([whatProcess isEqualToString:kDECRYPT_P_REMOVE_RECORD_STRINGBEGINS]) {
            [self performREMOVE_STRING_BEGINS_process:decryptDict onDataResponse:thisDataArray];
        }
        
        if([whatProcess isEqualToString:kDECRYPT_P_REPLACE_FIELD_STRINGTRAILS]) {
            [self performREPLACE_STRING_TRAILS_process:decryptDict onDataResponse:thisDataArray];

        }
        
        if([whatProcess isEqualToString:kDECRYPT_P_FLATTEN_ARRAY_TOSTRING]) {
            [self performFLATTEN_ARRAY_INTOSTRING_process:decryptDict onDataResponse:thisDataArray];
            
        }
        
        //NSLog(@"****AFTER %@  count:%lu",whatProcess,(unsigned long)[thisDataArray count]);
        //[self dumpSpecialTMS:thisDataArray];
        
     }//end all processes
    
   // NSLog(@"*****FINAL count:%lu",(unsigned long)[thisDataArray count]);
   // [self dumpSpecialTMS:thisDataArray];
 
}
+(NSString *)valForHDIKey:(NSString *)hdiKey inDict:(NSMutableDictionary*)searchDict decryptDict:(NSMutableDictionary*)decryptDict
{
    NSString *answer=nil;
    NSArray *allKeys=[decryptDict allKeys];
    NSString *customKey=nil;
    
    if ([allKeys containsObject:hdiKey]) {
        customKey=[decryptDict valueForKeyPath:hdiKey];
        if (customKey) {
            answer=[searchDict valueForKeyPath:customKey];
        }
    }
    return answer;
    
}
+(NSNumber *)numForHDIKey:(NSString *)hdiKey inDict:(NSMutableDictionary*)searchDict decryptDict:(NSMutableDictionary*)decryptDict
{
    NSNumber *answer=nil;
    NSArray *allKeys=[decryptDict allKeys];
    NSString *customKey=nil;
    
    if ([allKeys containsObject:hdiKey]) {
        customKey=[decryptDict valueForKeyPath:hdiKey];
        if (customKey) {
            answer=[searchDict valueForKeyPath:customKey];
        }
    }
    return answer;
    
}

+(NSMutableArray *)arrFromDecryptDictForKey:(NSString *)hdiKey inDict:(NSMutableDictionary*)searchDict decryptDict:(NSMutableDictionary*)decryptDict
{
    NSMutableArray *answer=nil;
    NSArray *allKeys=[decryptDict allKeys];
   NSString *customKey=nil;
    
    if ([allKeys containsObject:hdiKey]) {
        customKey=[decryptDict valueForKeyPath:hdiKey];
        if (customKey) {
            answer=[searchDict valueForKeyPath:customKey];
        }
        
        
     }
    return answer;
    
}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////
+(NSString *)convertDictionaryToJSON:(NSMutableDictionary*)myDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    if (! jsonData) {
        jsonString=nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
