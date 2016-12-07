//
//  Transaction.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction


@synthesize description,queryTitle,errorLocalDescr,dbQandA,queryNumber;
@synthesize retRecordsAsDPtrs;
@synthesize viewActive;
@synthesize actReqPtr;
@synthesize transactionKey;
@synthesize loopingPosition,loopingActive;
@synthesize  storeloopingDataArrayPtr,storeKeyString,storeView,storeActReq,storeSentVariablesArrayPtr,storeStringSubstituted,storeDictForResults;
@synthesize storeKeyArrayPtr;
@synthesize queryReturns404IsError;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Destroy
/////////////////////////////////////////
-(void) killYourself
{
    description=nil;
    queryTitle=nil;
    errorLocalDescr=nil;
    //[dbQandA killYourself];   //this isn't using arc and I want it to be replaced
    dbQandA=nil;
    queryNumber=[NSNumber  numberWithInt:0];
    NSMutableDictionary *dptr;
    viewActive=nil;
    transactionKey=nil;
    
    storeStringSubstituted=nil;
    loopingActive=FALSE;
    loopingPosition=0;
    storeView=nil;
    storeKeyString=nil;
    storeloopingDataArrayPtr=nil;
    storeKeyArrayPtr=nil;
    storeSentVariablesArrayPtr=nil;
    storeActReq=nil;
    storeDictForResults=nil;
    
    for (int i=0; i< [retRecordsAsDPtrs count]; i++) {
        [dptr removeAllObjects];
        dptr=nil;
        
    }
    retRecordsAsDPtrs=nil;
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

-(id) initWithQTitle:(NSString *)title andQDescr:(NSString *) descr andNumber:(int) num
{
    self = [super init];
    if (self) {
        
        [self makeUseDefaults];
        queryTitle=title;
        description=descr;
        queryNumber=[NSNumber numberWithInt:num];
    }
    return self;
}

-(void) makeUseDefaults
{
   
    loopingPosition=0;
    loopingActive=FALSE;
    queryReturns404IsError=FALSE;   //if this query returns 404 (not Found status)  report as FATAL ERROR or not?

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NOTIFICATIONS
/////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Simple XAction Methods
/////////////////////////////////////////
-(BOOL) loopingTransactionOnView:(UIView *)inView actionReq:(ActionRequest *)stuffedActionPointer usingSendDataArray:(NSMutableArray *)variablesArray loopingKey:(NSString*)thisKey loopArrData:(NSMutableArray *)stringArray retDictWithLoopArrrDataKey:(NSMutableDictionary*)retDictPtr storingKeyArray:(NSMutableArray *)storingKeyArray
{
    //variablesArray is an array of key value pairs (type TransactionData) that are sent with query
    
    //stringArray contains an array of a single string that will replace the value for thisKey inside variablesArray each time this loops
    //  so can send array of moview titles and get back all the movie details for each movie by doing the same query over an over just replacing movie name
    
    
    viewActive=inView;
    
    actReqPtr=stuffedActionPointer;
    
    errorLocalDescr=nil;
    if (!loopingActive) {
        loopingActive=TRUE;
        loopingPosition=0;
        storeView=inView;
        storeKeyString=thisKey;
        storeloopingDataArrayPtr=stringArray;
        storeSentVariablesArrayPtr=variablesArray;
        storeActReq=stuffedActionPointer;
        storeDictForResults=retDictPtr;
        storeKeyArrayPtr=storingKeyArray;
    }
    else {
        
        loopingPosition=loopingPosition+1;   //?
        inView=storeView;
        viewActive=inView;
        thisKey=storeKeyString;
        stringArray=storeloopingDataArrayPtr;
        variablesArray=storeSentVariablesArrayPtr;
        retDictPtr=storeDictForResults;
        storingKeyArray=storeKeyArrayPtr;
        
        
        
        
        if (loopingPosition >= [stringArray count]) {
            //we are done.... go back to runtime
            
            loopingActive=FALSE;
            loopingPosition=0;
            storeView=nil;
            storeKeyString=nil;
            storeKeyArrayPtr=nil;
            storeloopingDataArrayPtr=nil;
            storeSentVariablesArrayPtr=nil;
            storeActReq=nil;
            storeStringSubstituted=nil;
            storeDictForResults=nil;
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstDoneLoopingXactionResponseProcessed  object:actReqPtr];
           // [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:actReqPtr];
            return TRUE;
        }
    }
    
    
    // Start request
    

    NSURL *url=[NSURL URLWithString:self.URL];
    
    
    //    self.actReqPtr.retRecordsAsDPtrs=nil;
    self.retRecordsAsDPtrs=nil;    //MYRA - should do kill logic here
    
    
    
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSLog(@"request to URL: %@",url);
    
    //   [request setPostValue:theUserID forKey:@"validUserID"];
    // [request setPostValue:theUserPW forKey:@"validUserPW"];
    TransactionData *fieldPtr;
    NSString *datastr;
    for (int var=0; var < [variablesArray count]; var++) {
        fieldPtr=[variablesArray objectAtIndex:var];
        datastr=fieldPtr.userDefinedData;
        if ([fieldPtr.queryKey isEqualToString:thisKey]) {
            datastr=[storingKeyArray objectAtIndex:loopingPosition];
            storeStringSubstituted=datastr;
        }
        [request setPostValue:datastr forKey:fieldPtr.queryKey];
        
        NSLog(@"request setPostValue: %@ forKey: %@",datastr, fieldPtr.queryKey);
    }
    
    
    
    
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewActive animated:YES];
   
    hud.label.text = @"Query Active...";
    if (HUD_SHOW_HOSTINFO) {
        hud.label.text=actReqPtr.errorDisplayText;
    }

    
    
    return TRUE;
}

-(BOOL) loopingTransactionViewActive:(UIView *)inView actReq:(ActionRequest *)actPointer usingDataArray:(NSMutableArray *)variablesArray
{
    if (!loopingActive) {
        loopingActive=TRUE;
    }
    
    viewActive=inView;
    
    actReqPtr=actPointer;   //this holds dict pointer for multiple results in looping xaction
    errorLocalDescr=nil;
     NSURL *url=[NSURL URLWithString:self.URL];
    self.retRecordsAsDPtrs=nil;    //MYRA - should do kill logic here
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSLog(@"LOOPING request to URL: %@",url);
    
    //   [request setPostValue:theUserID forKey:@"validUserID"];
    // [request setPostValue:theUserPW forKey:@"validUserPW"];
    TransactionData *fieldPtr;
    for (int var=0; var < [variablesArray count]; var++) {
        fieldPtr=[variablesArray objectAtIndex:var];
        [request setPostValue:fieldPtr.userDefinedData forKey:fieldPtr.queryKey];
        
        NSLog(@"LOOPING request setPostValue: %@ forKey: %@",fieldPtr.userDefinedData, fieldPtr.queryKey);
    }
    
    NSLog(@"***sending actReqPtr %p actreqPtr.loopDictPtr %p",actReqPtr, actReqPtr.loopDictPtr);
    
    
    sleep(0.3);
    
    
    [request setDelegate:self];
    [request startAsynchronous];
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewActive animated:YES];
    hud.label.text = @"Query Active...";
    
    if (HUD_SHOW_HOSTINFO) {
        hud.label.text=actReqPtr.errorDisplayText;
    }

    return TRUE;
}





-(BOOL) beginTransactionViewActive:(UIView *)inView carryAlongDummyData:(ActionRequest *)stuffedActionPointer usingDataArray:(NSMutableArray *)variablesArray
{
    
    //variablesArray is an array of key value pairs (type TransactionData) that are sent with query
    
    
    viewActive=inView;
    
    actReqPtr=stuffedActionPointer;
    NSLog(@"***sending actReqPtr %p actreqPtr.loopDictPtr %p",actReqPtr, actReqPtr.loopDictPtr);
   //my array of TransactionData contains query field and user data
  //  self.theUserID=userStr;
  //  self.theUserPW=pwStr;
    errorLocalDescr=nil;
    
    
    // Start request
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost/~myra/" ]; //so it executes \Sites\index.html or index.php
    //NSURL *url = [NSURL URLWithString:@"http://localhost/~myra/TABLEproto/indexTEST" ]; //so it executes \Sites\indexTEST.html or indexTEST.php
   // NSURL *url = [NSURL URLWithString:@"http://97.77.211.34/~Dwain/TABLEproto/indexTEST" ]; //so it executes \Sites\index.html or indexTEST.php
    NSURL *url=[NSURL URLWithString:self.URL];
    
    
//    self.actReqPtr.retRecordsAsDPtrs=nil;
    self.retRecordsAsDPtrs=nil;    //MYRA - should do kill logic here
    
    
    
    
    //DAN's machine
 //   NSURL *    url = [NSURL URLWithString:@"http://localhost/~DanHammond/indexTEST" ];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSLog(@"request to URL: %@",url);

    //   [request setPostValue:theUserID forKey:@"validUserID"];
   // [request setPostValue:theUserPW forKey:@"validUserPW"];
    TransactionData *fieldPtr;
    for (int var=0; var < [variablesArray count]; var++) {
        fieldPtr=[variablesArray objectAtIndex:var];
        [request setPostValue:fieldPtr.userDefinedData forKey:fieldPtr.queryKey];
        
        NSLog(@"request setPostValue: %@ forKey: %@",fieldPtr.userDefinedData, fieldPtr.queryKey);
    }
    
    
    //DELETE  BELOW=======================FORCES AN ERROR======================
   // NSLog(@"TEST  TEST  TEST   TEST   TEST    TEST    TEST    TEST   TEST");
   // NSLog(@"TESTING HOST ERROR PROCESSING ------ FORCED ERROR -----");
   // [self requestFailed:request];
  //  return TRUE;
    //=========================DELETE ABOVE
    
    
    
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewActive animated:YES];
    hud.label.text = @"Query Active...";
    if (HUD_SHOW_HOSTINFO) {
        hud.label.text=actReqPtr.errorDisplayText;
    }
    
    
    
    return TRUE;

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    //   GlobalTableProto *gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    
    //   gGTPptr.thisUserValid=FALSE;
    
    
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
    NSLog(@"*****************************FINISH");
    
    NSLog(@"request.responseStatusCode %d",request.responseStatusCode);
    NSLog(@"request.responseStatusMessage %@",request.responseStatusMessage);
    NSLog(@"(requestFinished)request.responseString %@",request.responseString);    //this is json format   have to parse it
    NSLog(@"");
    
    
    //note request.responseStatusCode != 200   means no need to parse.....
    // CODE UI FOR THIS CONDITION  getting user to reenter?
    
    
    if(request.responseStatusCode == 200){
        [self parseRecievedResponse:request];    //all GOOOD
        return;
    }
    if ((request.responseStatusCode == 404) || (request.responseStatusCode ==204)) {
        //NOT FOUND....JUST GO ON? NOT FATAL?
        if (self.queryReturns404IsError) {
            [self badResponseStatusCode:request];
        }
        else{
            [self parseNOTFOUNDresponse:request];    //ITS ok....NO JSON TO PROCESS., handle looping state
        }
        
        return;
    }
    [self badResponseStatusCode:request];
    
    /*
     if (request.responseStatusCode != 200) {
     [self badResponseStatusCode:request];
     
     }
     else{
     [self parseRecievedResponse:request];
     
     
     
     }
     
     */
    
    
    
    
    
}

- (id)JSONObjectWithDataFixed:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    id object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
    
    if (opt & NSJSONReadingMutableContainers) {
        return [self JSONMutableFixObject:object];
    }
    
    return object;
}

- (id)JSONMutableFixObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        // NSJSONSerialization creates an immutable container if it's empty (boo!!)
        if ([object count] == 0) {
            object = [object mutableCopy];
        }
        
        for (NSString *key in [object allKeys]) {
            [object setObject:[self JSONMutableFixObject:[object objectForKey:key]] forKey:key];
        }
    } else if ([object isKindOfClass:[NSArray class]]) {
        // NSJSONSerialization creates an immutable container if it's empty (boo!!)
        if (![object count] == 0) {
            object = [object mutableCopy];
        }
        
        for (NSUInteger i = 0; i < [object count]; ++i) {
            [object replaceObjectAtIndex:i withObject:[self JSONMutableFixObject:[object objectAtIndex:i]]];
        }
    }
    
    return object;
}

-(void) parseRecievedResponse:(ASIHTTPRequest *)request
{
    //PARSE DB response in JSONformat
   // You have to check the return object of NSJSONSerialization to see if it is a dictionary or an array
    
    NSError* jsonParsingError = nil;
  
    //THIS ON ISN"T RETURNING MUTEABLE STUFF.
    /*
    id jsonMadeObject = [NSJSONSerialization
                                 JSONObjectWithData:request.responseData //1
                                 options:kNilOptions
                                 error:&jsonParsingError];
    if ([jsonMadeObject isKindOfClass:[NSArray class]]){
        NSLog(@"yes we got an Array"); // cycle thru the array elements
        self.retRecordsAsDPtrs = [[NSMutableArray alloc] init];
        NSDictionary *aDictionary;
        NSMutableDictionary *aMutableDict;
        for (aDictionary in jsonMadeObject){
            aMutableDict = [[NSMutableDictionary alloc] initWithDictionary:aDictionary];
            [self.retRecordsAsDPtrs addObject:aMutableDict];
            
        }
        
    }
    else{
        if ([jsonMadeObject isKindOfClass:[NSDictionary class]]){
            NSLog(@" we got an dictionary  PUT IT IN NEW ARRAY"); // cycle thru the dictionary elements
            self.retRecordsAsDPtrs=[[NSMutableArray alloc]init];
            NSMutableDictionary *aMutableDict= [[NSMutableDictionary alloc] initWithDictionary:jsonMadeObject];
            
            [self.retRecordsAsDPtrs addObject:aMutableDict];
            
        }
        else{
            
            NSLog(@"JSONParsing Error(neither array nor dictionary!): %@", jsonParsingError.localizedDescription);
            self.errorLocalDescr=jsonParsingError.localizedDescription; //just because I want to save it
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:actReqPtr];
            //CAN'T DEAL WITH THIS
            return;  // Dan
        }
    }*/

    
    id jsonMadeObject = [self
                                JSONObjectWithDataFixed:request.responseData
                                options:NSJSONReadingMutableContainers
                                error:&jsonParsingError];
    
    
    
    if ([jsonMadeObject isKindOfClass:[NSMutableArray class]]){
        NSLog(@"yes we got amuteable Array"); // cycle thru the array elements
        self.retRecordsAsDPtrs = [[NSMutableArray alloc] initWithArray:jsonMadeObject];
      //  NSMutableDictionary *aDictionary;
      //  NSMutableDictionary *aMutableDict;
      //  for (aDictionary in jsonMadeObject){
      //      aMutableDict = [[NSMutableDictionary alloc] initWithDictionary:aDictionary];
      //      [self.retRecordsAsDPtrs addObject:aMutableDict];
            
      //  }
        

        NSLog(@"");
    }
    else{
        if ([jsonMadeObject isKindOfClass:[NSMutableDictionary class]]) {
            NSLog(@" we got an dictionary  PUT IT IN NEW ARRAY"); // cycle thru the dictionary elements
            self.retRecordsAsDPtrs=[[NSMutableArray alloc]init];
            NSMutableDictionary *aMutableDict= [[NSMutableDictionary alloc] initWithDictionary:jsonMadeObject];
            
            [self.retRecordsAsDPtrs addObject:aMutableDict];
            NSLog(@"");
        }
        else{
            
            NSLog(@"JSONParsing Error(neither array nor dictionary!): %@", jsonParsingError.localizedDescription);
            self.errorLocalDescr=jsonParsingError.localizedDescription; //just because I want to save it
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:actReqPtr];
            //CAN'T DEAL WITH THIS
            return;  // Dan
        }


    }
 
    
       
    
    
  /*  //DUMP THIS TO SEE IT:
    
    
    
    //this is an array of dictionaries.   So if get 10 records back, there are 10 dictionaries held in the JSON array
    int looper=0;
    
    NSLog(@"TOTAL RECORDS RECVD %lu",(unsigned long)[self.retRecordsAsDPtrs count]);
    
    for (NSDictionary *aRecord in self.retRecordsAsDPtrs)
    {
        looper++;
        
        
        
        for( NSString *aKey in [aRecord allKeys] )
        {
            // do something like a log:
            NSLog(@"RET REC %d - DBKEY: %@  DBVAL:%@",looper,aKey,[aRecord objectForKey:aKey]);
        }
        
    }
    
    */
    self.actReqPtr.retRecordsAsDPtrs=self.retRecordsAsDPtrs;
    
    //FIND OUR DECRYPTor, move to appropriate spot,remove from array of dPtrs
    int looper=0;
    int found=-1;
    
    for (NSMutableDictionary *aRecord in self.retRecordsAsDPtrs)
    {
        if ([aRecord objectForKey:kDECRYPT_REQ_REVKEY] ) {
            found=looper;
        }
        looper++;
    }
    if (found>=0) {
        self.actReqPtr.decryptDict=[self.retRecordsAsDPtrs objectAtIndex:found];
        [self.actReqPtr.retRecordsAsDPtrs removeObjectAtIndex:found];
        NSLog(@"");
    }
    else{
        //no decrypt key
        NSLog(@"");
    }
    
    
    
    if (loopingActive) {
        //do something with this data
        
        NSLog(@"***RECV actReqPtr %p   actReqPtr.loopDictPtr %p",actReqPtr, actReqPtr.loopDictPtr);
        [actReqPtr.loopDictPtr setObject:[retRecordsAsDPtrs objectAtIndex:0] forKey:actReqPtr.aiKeyForResultDict];
       // [self loopingTransactionOnView:storeView actionReq:storeActReq usingSendDataArray:storeSentVariablesArrayPtr loopingKey:storeKeyString loopArrData:storeloopingDataArrayPtr retDictWithLoopArrrDataKey:storeDictForResults storingKeyArray:storeKeyArrayPtr];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstContinueLoopingTransaction  object:actReqPtr];
        
        
        request=nil;
        
        
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:actReqPtr];
    }
    return;
    
}


-(void)parseNOTFOUNDresponse:(ASIHTTPRequest *)request
{
    //from 404  NOT FOUND.  IS THIS AN ERROR? DEPENDS....
    
    
    if (loopingActive) {
        //do something with this data
        
        NSLog(@"***RECV actReqPtr %p   actReqPtr.loopDictPtr %p",actReqPtr, actReqPtr.loopDictPtr);
        
        //no data returned, so   retRecordsAsDPtrs is nil
        
        [actReqPtr.errNOTFOUNDLoopArrPtr addObject:actReqPtr.aiKeyForResultDict];
        // [actReqPtr.loopDictPtr setObject:[retRecordsAsDPtrs objectAtIndex:0] forKey:actReqPtr.aiKeyForResultDict];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstContinueLoopingTransaction  object:actReqPtr];
        
        
        request=nil;
        
        
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:actReqPtr];
    }
    return;
    
}





- (void)requestFailed:(ASIHTTPRequest *)request
{
    //error recving response from http .... like db not avail or internet not avail
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
    NSError *error = [request error];
    
    NSLog(@"requestFailed Fatal Error: %@",error.localizedDescription);
    
    self.errorLocalDescr=error.localizedDescription; //just because I want to save it
    
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:actReqPtr];
}


- (void)badResponseStatusCode:(ASIHTTPRequest *)request
{
    // called when NOT 200 - like bad sql - invalid parms,
    
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
    
    NSError *error = [request error];
    NSLog(@"badResponseStatusCode- user try again");
    NSLog(@"requestFailed Fatal Error:%@ ",error.localizedDescription);
    
    self.errorLocalDescr=error.localizedDescription; //just because I want to save it
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:actReqPtr];
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  NOTIFY

- (void)notifyITSallGOOD
{
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:actReqPtr];
    
}

- (void)notifyITSallBAD
{
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
