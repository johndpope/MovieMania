

#import "IDentifyUser.h"









@implementation IDentifyUser
{
    ActionRequest *aQuery;
}



@synthesize theUserPW,theUserID;
@synthesize viewActive;
@synthesize errorLocalDescr;
//@synthesize queryData;


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  PERFORM verification Processing

-(BOOL)startValidateUserUsingView:(UIView *)thisView forUser:(NSString *)userStr andPW:(NSString *)pwStr withQueryData:(ActionRequest*)queryData
{
    
    
 //  uncomment to bypass db check
 //   NSLog(@"TEMPORARY    ALL     GOOD");
 //   [self notifyITSallGOOD];
 //   return TRUE;
  
    
    self.viewActive=thisView;
    self.theUserID=userStr;
    self.theUserPW=pwStr;
    errorLocalDescr=nil;
    aQuery = queryData;
    
    // Start request
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost/~myra/" ]; //so it executes \Sites\index.html or index.php
    //NSURL *url = [NSURL URLWithString:@"http://localhost/~myra/TABLEproto/indexTEST" ]; //so it executes \Sites\indexTEST.html or indexTEST.php
    NSURL *url = [NSURL URLWithString:@"http://97.77.211.34/~Dwain/TABLEproto/indexTEST" ]; //so it executes \Sites\index.html or indexTEST.php

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    //  [request setPostValue:@"1" forKey:@"rw_app_id"];         //ray's example
    //  [request setPostValue:@"test" forKey:@"code"];           //ray's example
    //  [request setPostValue:@"test" forKey:@"device_id"];      //ray's example
    
    
    [request setPostValue:theUserID forKey:@"validUserID"];
    [request setPostValue:theUserPW forKey:@"validUserPW"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    // Start hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewActive animated:YES];
    hud.label.text = @"Redeeming code...";
    
    NSLog(@"doing verification for id: %@ PW: %@",theUserID, theUserPW);
    
    return TRUE;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    GlobalTableProto *gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    
    gGTPptr.thisUserValid=FALSE;
    
    
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
    NSLog(@"request.responseStatusCode %d",request.responseStatusCode);
    NSLog(@"request.responseStatusMessage %@",request.responseStatusMessage);
    NSLog(@"OLD request.responseString %@",request.responseString);    //this is json format   have to parse it
    NSLog(@"");
    
    
    //note request.responseStatusCode != 200   means no need to parse.....
    // CODE UI FOR THIS CONDITION  getting user to reenter?

    if (request.responseStatusCode != 200) {
        [self badResponseStatusCode:request];
    }
    else{
        [self parseRecievedResponse:request];
    }
    
    
    
    
     /*
    if (request.responseStatusCode == 400) {
        textView.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        textView.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSDictionary *responseDict = [responseString JSONValue];
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        if (unlockCode) {
            NSLog(@"unlockCode %@",unlockCode);
            
            if ([unlockCode compare:@"com.razeware.PromoTest.unlock.cake"] == NSOrderedSame) {
                textView.text = @"The cake is a lie! <GOOD NEWS>";
            } else {
                textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
            }
            
        }
        else{
            //unlockCode is nil
            NSLog(@"unlockCode is %@ so no comparison done",unlockCode);
        }
        
    } else {
        textView.text = @"Unexpected error";
     
    }*/
    
}
-(void) parseRecievedResponse:(ASIHTTPRequest *)request
{
    //PARSE DB response in JSONformat
    
    GlobalTableProto *gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    NSError* jsonParsingError = nil;
    IDentifyUModel *identity;
    identity=[[IDentifyUModel alloc] initWithString:request.responseString error:&jsonParsingError];
    if(jsonParsingError){
        NSLog(@"JSONParsing Error: %@", jsonParsingError.localizedDescription);
        self.errorLocalDescr=jsonParsingError.localizedDescription; //just because I want to save it
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:nil];
    }
    else{
        NSLog(@"identity.unlockCode is %@",identity.unlockCode);
        self.errorLocalDescr=nil;
        gGTPptr.thisUserValid=YES;
        
        
        //send notification
        [self notifyITSallGOOD];
    }

}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    //error recving response from http .... like db not avail or internet not avail
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
    NSError *error = [request error];
    
    NSLog(@"requestFailed Fatal Error: %@",error.localizedDescription);
    
    self.errorLocalDescr=error.localizedDescription; //just because I want to save it

    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:nil];
 /*
    self.myLabel.text =[NSString stringWithFormat:@"Fatal Error: %@", error.localizedDescription];
    theUserPW=nil;
    theUserID=nil;
    pwTextField.text=nil;
    idTextField.text=nil;
   // textView.text = error.localizedDescription;
  */
}
- (void)badResponseStatusCode:(ASIHTTPRequest *)request
{
    // called when NOT 200 - like bad sql - invalid parms,
    
    [MBProgressHUD hideHUDForView:self.viewActive animated:YES];
   
    NSError *error = [request error];
    NSLog(@"badResponseStatusCode- user try again");
    NSLog(@"requestFailed Fatal Error:%@ ",error.localizedDescription);
    
    self.errorLocalDescr=error.localizedDescription; //just because I want to save it
    aQuery.nextTableView = TVC0;
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:aQuery];
    /*
    theUserPW=nil;
    theUserID=nil;
    pwTextField.text=nil;
    idTextField.text=nil;
        self.myLabel.text = [NSString stringWithFormat:@"code: %d  Please Try Again!", request.responseStatusCode];
    
    // textView.text = error.localizedDescription;
     */
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  NOTIFY

- (void)notifyITSallGOOD
{
    aQuery.nextTableView = TVC1;
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:aQuery];
    NSLog(@"IDentifyUserViewController notifyITSallGOOD");
}

- (void)notifyITSallBAD
{
    aQuery.nextTableView = TVC0;
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:aQuery];
}
@end
