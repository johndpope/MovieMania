//
//  Runtime.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "Runtime.h"
#import "CustomTVCell.h"
#import "PurchaseRecord.h"
@implementation Runtime
{
    NSMutableArray *purchaseKeys;
    NSMutableArray *productTypes;
    NSMutableArray *productPrices;
    NSMutableArray *productQuantities;
    BOOL            loggedIn;
    BOOL            initializingLocDB;
    BOOL            initializingInvDB;
    BOOL            fetchingMovieInfo;

//    NSMutableDictionary *allLocationsHDI;
//    NSArray             *allLocationKeys;
    NSInteger     initDBRecordKeyIndex;
    NSMutableArray *movieNameArray;
    NSMutableDictionary *movieYearDictionary;  //corresponds to moviewNameArray for host transaction
    NSMutableArray *testProductArray;
    NSMutableDictionary *allMovieInfoOMDB;
    NSMutableDictionary *allProductInventory;
//    NSMutableDictionary *movieImageDictionary;
//    NSMutableDictionary *allMovieInfoOMDB;
}
//#import "IDentifyUser.h"
@synthesize rtNavCtrler;
@synthesize holdVCtrler;
@synthesize rtTableViewCtrler;
@synthesize rtStarupRVC;
//@synthesize tmsRootIDHelperDict;
//@synthesize prodDefInfoDict;
@synthesize gGTPptr;
@synthesize movieTrailers;
@synthesize allMovieTrailersTMS;
@synthesize allMovieTrailersHDI,allMovieTrailersHDIdictWTD;
@synthesize forNavFooterUIView,forNavHeaderUIView,forNavTVCview;
@synthesize gImageDictionary; //should this be in globals?

@synthesize activeTableDataPtr;
@synthesize posBottomRect,posCenterRect,posTopRect,posWindowRect;
@synthesize allEnteredFields;
@synthesize allLocationsHDI;

@synthesize locationByIDkeys;
@synthesize movieImageDictionary,movieImageDictionaryPath,movieNamesForImageDownloads,movieImageDictionaryWTD;
@synthesize queryMode,autoCounter,autoInUsePtr;


@synthesize allProductDefinitions_HDI,allProductInventory_HDI;

@synthesize gInputFieldsDictionary;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////

-(id) init
{
    self = [super init];
    if (self) {
       //
      
        forNavHeaderUIView=nil;
        forNavFooterUIView=nil;
        forNavTVCview=nil;
        autoCounter=0;
        autoInUsePtr=nil;
        self.gGTPptr=[GlobalTableProto sharedGlobalTableProto];
         posWindowRect=[[UIScreen mainScreen] bounds];    //this doesn't deal with orientation YET
        [self addNotificationsIWant];
        
        self.rtStarupRVC=[[ViewController alloc]init];
       // self.rtStarupRVC.title=@"dummyViewCOntroller";
        NSLog(@"rtStarupRVC %p and view %p",self.rtStarupRVC, self.rtStarupRVC.view);
       // self.rtNavCtrler=[[UINavigationController alloc]initWithRootViewController:self.rtStarupRVC];
        
      //  self.rtNavCtrler=[[NavCtrl alloc]initWithRoot:self.rtStarupRVC];
        
        self.holdVCtrler=[[HoldViewController alloc] init];
        
       // [self.rtNavCtrler prefersStatusBarHidden ];
       // self.rtNavCtrler.navigationBar.tintColor=[UIColor blueColor];//[GlobalTableProto sharedGlobalTableProto].viewBackColor;//063016
    
        
        purchaseKeys = [[NSMutableArray alloc] initWithObjects:kPurchaseTypeKey,kPurchasePriceKey,kPurchaseQuantityKey, nil];
        productTypes = [[NSMutableArray alloc] initWithObjects:@"Adult",@"Child",@"Matinee", nil];
        productPrices = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:12.5],[NSNumber numberWithFloat:6.50],[NSNumber numberWithFloat:8.50], nil];
        productQuantities = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0] , nil];//
        allEnteredFields = [[NSMutableArray alloc] init];
        allMovieInfoOMDB = [[NSMutableDictionary alloc] init];
        allProductInventory=[[NSMutableDictionary alloc] init];
        
        movieTrailers = [[NSMutableArray alloc] init];
       // allProductDefinitionsHDI = [[NSMutableDictionary alloc] init];
        //allProductInventoryHDI = [[NSMutableDictionary alloc] init];
        allProductInventory_HDI = [[NSMutableDictionary alloc] init];
        allProductDefinitions_HDI = [[NSMutableDictionary alloc] init];
        loggedIn = NO;
        initializingLocDB = NO;
        initializingLocDB = NO;
        fetchingMovieInfo = NO;
        

        movieNameArray = [NSMutableArray arrayWithObjects: @"The Angry Birds Movie",
                        @"The Nice Guys",
                        @"Money Monster",
                        @"Captain America: Civil War",
                        @"Neighbors 2: Sorority Rising",
                        @"Barbershop: The Next Cut",
                        @"Keanu",
                        @"The Boss",
                     //   @"The Huntsman: Winter's War",
                        @"Batman",
                        @"Zootopia",
                        nil];
        
        
        
        //unarchive movieImageDictionary from the disk
        movieImageDictionary=[[DiskStore sharedDiskStore] unArchiveAStoreDictionaryNamed:DISK_IMAGESTORE];
        movieNamesForImageDownloads=[[NSMutableArray alloc]init];
        movieImageDictionaryWTD=FALSE;
        if (!movieImageDictionary) {
            movieImageDictionary=[[NSMutableDictionary alloc]init]; //first time
            movieImageDictionaryWTD=TRUE;
        }
        
        
        
        gInputFieldsDictionary=[[DiskStore sharedDiskStore] unArchiveAStoreDictionaryNamed:DISK_EFSTORE];
        
        if (!gInputFieldsDictionary) {
            gInputFieldsDictionary=[[NSMutableDictionary alloc] init];
            gGTPptr.globalZipCode=DEFAULT_ZIPCODE;
        }
        else{
            gGTPptr.globalZipCode=[gInputFieldsDictionary objectForKey:EFKEY_ZIPCODE];
            if (!gGTPptr.globalZipCode) {
                gGTPptr.globalZipCode=DEFAULT_ZIPCODE;
            }
        }
        
 /*   do this if zip code gets corrupted on disk
        gGTPptr.globalZipCode=DEFAULT_ZIPCODE;  // dan get rid of this line of code
        [gInputFieldsDictionary setObject:gGTPptr.globalZipCode forKey:EFKEY_ZIPCODE];
        [[DiskStore sharedDiskStore] archiveAStoreDictionary:gInputFieldsDictionary withName:DISK_EFSTORE];
        
*/
        movieImageDictionaryPath=[[NSMutableDictionary alloc]init];
        
        
        
        //unarchive allMovieTrailersHDI from the disk
        allMovieTrailersHDI=[[DiskStore sharedDiskStore] unArchiveAStoreDictionaryNamed:DISK_TRAILERSTORE];
       
        allMovieTrailersHDIdictWTD=FALSE;
        if (!allMovieTrailersHDI  ) {
            allMovieTrailersHDI=[[NSMutableDictionary alloc]init];
           
            allMovieTrailersHDIdictWTD=TRUE;
        }
        
        self.gGTPptr.selectedDate=[NSDate date];
        self.gGTPptr.selectedProdcuctDict=nil;
        self.gGTPptr.selectedLocDict=nil;
        
    }
    return self;
}


-(void) addNotificationsIWant
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(chgVCbadUser:)    //method
                                                 name:ConstIDentifyUserControllerFailure          //const in TableProntoDefines.h
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userTouchInput:)
                                                 name:ConstUserTouchInput object:nil];
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processDataBaseResponse:)
                                                    name:ConstIDentifyUserControllerSuccess          //const in TableProntoDefines.h
                                                   object:nil];
                                                // name: @"DataBaseQueryResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneLoopingXactionResponseProcessed:)
                                                 name:ConstDoneLoopingXactionResponseProcessed          //const in TableProntoDefines.h
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tvcDisplayVisibleNotified:)    //method
                                                 name:ConstTVCDisplayedNotifyRuntime          //const in TableProntoDefines.h
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(continueXactLoop:)
                                                 name:ConstContinueLoopingTransaction          //const in TableProntoDefines.h
                                               object:nil];
    
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newZipStartOver:)
                                                 name:ConstNEWZIPstartOver
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processUserFocusMovie:)
                                                 name:ConstUserFocusMovie          //const in TableProntoDefines.h
                                               object:nil];

    
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display TVCs
/////////////////////////////////////////

-(void)logwhatsup
{
    
    
    UIViewController *thisvc=self.rtNavCtrler.visibleViewController;
    NSLog(@"RUNTIME.m  logwhatsup nav visibleViewController: %p withtitle %@",thisvc,thisvc.title);
    UIViewController *fvc= [self.rtNavCtrler topViewController];
    NSLog(@"RUNTIME.m  logwhatsup nav topViewController:%p withtitle %@",fvc,fvc.title);
    UIViewController *pvc= [self.rtNavCtrler presentedViewController];
    NSLog(@"RUNTIME.m  logwhatsup navRUNTIME.m  nav presentedViewController:%p withtitle %@",pvc,pvc.title);
}
-(CGFloat) whatStatusBarHeight
{
#if !TARGET_OS_TV
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
   CGFloat answer=MIN(statusBarSize.width, statusBarSize.height);
    
    return answer;
#else
    return  0.0;
#endif
}

-(void) correctPositioningForNavigation:(TableDef *)thisTDataPtr
{
    //posWindowRect already set
    //CLEAR previous settings
    posTopRect=CGRectZero;
    posCenterRect=CGRectZero;
    posBottomRect=CGRectZero;
    
    CGFloat fixedStatusBarHeight=[self whatStatusBarHeight];// + 20;
    
    //Initialize heights:
    CGFloat fixedHeaderHeight=0.0;
    CGFloat fixedFooterHeight=0.0;
    CGFloat allowTableHeight=0.0;
    //CGFloat offset=20.0;
    if (thisTDataPtr.tableHeaderFixed) {   //has to be fixed, otherwise let table have it
        fixedHeaderHeight=ceil( thisTDataPtr.fixedTableHeaderUIView.frame.size.height);   //calculated already
        
    }
    if (thisTDataPtr.tableFooterFixed) {   //has to be fixed, otherwise let table have it
        fixedFooterHeight=ceil( thisTDataPtr.fixedTableFooterUIView.frame.size.height); //calculated already
    }
    allowTableHeight=posWindowRect.size.height- fixedFooterHeight - fixedHeaderHeight - fixedStatusBarHeight  ;
    
    
    
    
    
    //Figure out rectangles
    posTopRect=CGRectMake(0, fixedStatusBarHeight,
                          posWindowRect.size.width,
                          fixedHeaderHeight);
    
//    posCenterRect=CGRectMake(0, fixedHeaderHeight + fixedStatusBarHeight,
 //                            posWindowRect.size.width,
 //                            allowTableHeight);
    posCenterRect=CGRectMake(2, fixedHeaderHeight + fixedStatusBarHeight,
                             posWindowRect.size.width-2,
                             allowTableHeight);

    
    posBottomRect=CGRectMake(0, allowTableHeight + fixedHeaderHeight + fixedStatusBarHeight,
                             posWindowRect.size.width,
                             fixedFooterHeight);
    
    
    NSLog(@"WINDOW %@",NSStringFromCGRect(posWindowRect));
    NSLog(@"HEADER %@",NSStringFromCGRect(posTopRect));
    NSLog(@"TABLE  %@",NSStringFromCGRect(posCenterRect));
    NSLog(@"FOOTER %@",NSStringFromCGRect(posBottomRect));
    NSLog(@"");
    
    
}


-(void) reloadForHeader
{
    if (self.activeTableDataPtr.fixedTableHeaderUIView) {
        
        
        
       // =   //all scrollable, no fixed header or footer
        
        UIView *returnedHeaderUIView=[self.activeTableDataPtr.tableHeaderContentPtr.ccCellTypePtr putMeVisibleMaxWidth:self.activeTableDataPtr.tvcCreatedWidth maxHeight:self.activeTableDataPtr.tvcCreatedHeight withTVC:nil];
        
        //***HEADER
        
        
            
        NSLog(@"");
            self.activeTableDataPtr.fixedTableHeaderUIView=returnedHeaderUIView;

        
        
        
        
        
        
        
        
        
        if (forNavHeaderUIView) {
            [forNavHeaderUIView removeFromSuperview];
            forNavHeaderUIView=nil;
        }

        [self.activeTableDataPtr.fixedTableHeaderUIView setFrame:posTopRect ];   //ALTER offset of for fixed header
        // [self.rtNavCtrler.view addSubview:thisTDataPtr.fixedTableHeaderUIView]; //ADD fixed header
        [self.holdVCtrler.view addSubview:self.activeTableDataPtr.fixedTableHeaderUIView]; //ADD fixed header
        NSLog(@"RUNTIME.M (FIXED HEADER RELOAD) NAV addSubView: %p",self.activeTableDataPtr.fixedTableHeaderUIView);
        forNavHeaderUIView=self.activeTableDataPtr.fixedTableHeaderUIView;
        
    }
    
    
    
    
}

-(void)displayATVC:(TableDef *)thisTDataPtr pressedBtn:(ActionRequest *)pressedBtn
{//THIS JUST CAUSES LOAD...IT's NOT UP YET
    
    
    
    
    //make this the active table
    if (forNavFooterUIView) {
        [forNavFooterUIView removeFromSuperview];
        forNavFooterUIView=nil;
    }
    if (forNavHeaderUIView) {
        [forNavHeaderUIView removeFromSuperview];
        forNavHeaderUIView=nil;
    }
    if (forNavTVCview) {
        [forNavTVCview removeFromSuperview];
        forNavTVCview=nil;
    }
    if(self.activeTableDataPtr){
        //some TABLE is already displayed
        [self.activeTableDataPtr killYourself];
      }
    self.activeTableDataPtr=thisTDataPtr;
    //load display settings and stuff for this table:    note could be from database, disk, wherever
    [self prepareTheActiveTableDataForDisplay:pressedBtn];
//    self.gGTPptr.selectedDate=[NSDate date];// dan - can't reset date here
//    self.gGTPptr.selectedProdcuctDict=nil;
//    self.gGTPptr.selectedLocDict=nil;
    
    //use tables VC
    
    self.rtTableViewCtrler =[[TableViewController alloc ]initWithTableDataPtr:thisTDataPtr usingTableViewStyle:UITableViewStyleGrouped viewFrame:CGRectMake(0, 0, posCenterRect.size.width, posCenterRect.size.height)];
    
    
  

    
    
    self.rtTableViewCtrler.view.backgroundColor=self.gGTPptr.viewBackColor;
    UITableView *thistv=(UITableView *)self.rtTableViewCtrler.view;
 //DOESN"T MATTER   thistv.backgroundView.backgroundColor=[UIColor blueColor];//self.gGTPptr.viewBackColor;
    thistv.backgroundColor=self.gGTPptr.viewBackColor; //[UIColor magentaColor]; to debugwith
#if !TARGET_OS_TV
    NSLog(@"displayATVC style  %ld",(long)thistv.separatorStyle);
#endif
   // thistv.separatorColor=[UIColor clearColor];
   // thistv.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    
    //self.rtNavCtrler.navigationBar.tintColor=[UIColor blueColor];//self.gGTPptr.viewBackColor;//063016
    //Based On thisTDataPtr, get figure out positioning
    [self correctPositioningForNavigation:thisTDataPtr];
    
    
   // UIView *dummyUIView=[[UIView alloc]initWithFrame:posWindowRect];
   // dummyUIView.backgroundColor=gGTPptr.viewBackColor;
   // [self.rtNavCtrler.view addSubview:dummyUIView];
   // [self.rtNavCtrler.view sendSubviewToBack:dummyUIView];

    
    if (thisTDataPtr.fixedTableHeaderUIView) {
        [thisTDataPtr.fixedTableHeaderUIView setFrame:posTopRect ];   //ALTER offset of for fixed header
       // [self.rtNavCtrler.view addSubview:thisTDataPtr.fixedTableHeaderUIView]; //ADD fixed header
        [self.holdVCtrler.view addSubview:thisTDataPtr.fixedTableHeaderUIView]; //ADD fixed header
        NSLog(@"RUNTIME.M (FIXED HEADER ADDED) NAV addSubView: %p",thisTDataPtr.fixedTableHeaderUIView);
        forNavHeaderUIView=thisTDataPtr.fixedTableHeaderUIView;
        
    }
    
    
    
    [self.rtTableViewCtrler.view setFrame:posCenterRect]; //ALTER offset for tableView
    gGTPptr.currentActiveTVRect=posCenterRect;
    
    NSLog(@"RUNTIME.M NAV.view(%p) addSubview tableViewController.view (%p)   tableviewcontroller (%p)",self.rtNavCtrler.view,self.rtTableViewCtrler.view,self.rtTableViewCtrler);
    
   // [self.rtNavCtrler replaceLastWith:self.rtTableViewCtrler];   // [self.rtNavCtrler.view addSubview:self.rtTableViewCtrler.view];
//NOTA    [self.holdVCtrler addChildViewController:self.rtTableViewCtrler];
    [self.holdVCtrler.view addSubview:self.rtTableViewCtrler.view];
    forNavTVCview=self.rtTableViewCtrler.view;
    
    
    if (thisTDataPtr.fixedTableFooterUIView) {
        [thisTDataPtr.fixedTableFooterUIView setFrame:posBottomRect ];   //ALTER offset of for fixed header
      //  [self.rtNavCtrler.view addSubview:thisTDataPtr.fixedTableFooterUIView]; //ADD fixed footer
        [self.holdVCtrler.view addSubview:thisTDataPtr.fixedTableFooterUIView];
        NSLog(@"RUNTIME.M (FIXED FOOTER ADDED) NAV addSubView: %p",thisTDataPtr.fixedTableFooterUIView);
        forNavFooterUIView=thisTDataPtr.fixedTableFooterUIView;
    }
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
  //  [self.rtNavCtrler prefersStatusBarHidden];
    return;
    
    
}
-(void) tvcDisplayVisibleNotified:(NSNotification *) notification
{
    //ok TVC is suppose to be visible, so HUD happy.
    //ONLY do this once per TVC loadup
    ActionRequest *startupAction = [[ActionRequest alloc] init];
    
    
   
    
    if ([activeTableDataPtr.autoXACTarray count])  {
        self.queryMode=kAUTOMATIC;
        autoCounter=0;
        autoInUsePtr=[activeTableDataPtr.autoXACTarray objectAtIndex:autoCounter];
        
        startupAction.buttonName=autoInUsePtr.buttonTitle;
        
        //EXECUTE AUTOMATION
        [self evaluateAction:startupAction];
        
        
    }
    else{
        self.queryMode=kUSERBUTTON;     //wait on user to press button, do return
        autoCounter=0;
        autoInUsePtr=nil;
        startupAction.buttonName=nil; //??
        return;
    }
    
    
    
    
    
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark EXECUTION LOOP
/////////////////////////////////////////
-(void)newZipStartOver:(NSNotification *)notification
{
    
    
    [[DiskStore sharedDiskStore]archiveAStoreDictionary:gInputFieldsDictionary withName:DISK_EFSTORE];
    
    ActionRequest *startupAction = [[ActionRequest alloc] init];
   ////// self.diskStorage=[DiskStore sharedDiskStore];//causes initialization to happen, disk is read
    //TRASH existing disk storage if this needs to replace it.
    startupAction.nextTableView = TVCInitDBs;   //new
    
    
    
    TableDef * thisTDataPtr = [self.gGTPptr makeTVCInitDBs:nil];  //new
    if (thisTDataPtr) {
        [self displayATVC:thisTDataPtr pressedBtn:startupAction];
    }
    
    

}
-(void)startRunTime
{
    
    [mUtils  logMyDocumentsDirectory];
   // [mUtils deleteLocalDirectory:DISK_DOCDEBUG ];
    [mUtils createLocalDirectory:DISK_DOCDEBUG];
    
    
    

    self.gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    ActionRequest *startupAction = [[ActionRequest alloc] init];
    self.diskStorage=[DiskStore sharedDiskStore];//causes initialization to happen, disk is read
 
    startupAction.nextTableView = TVCInitDBs;   //new
    
    
    
    TableDef * thisTDataPtr = [self.gGTPptr makeTVCInitDBs:nil];  //new
    if (thisTDataPtr) {
        [self displayATVC:thisTDataPtr pressedBtn:startupAction];
    }
    


}




-(void)setupTVCdata:(ActionRequest*)aQuery   //STUFFs our table like the db return should
{
    NSLog(@"setupTVCdata:");
    self.gGTPptr=[GlobalTableProto sharedGlobalTableProto];
//    ProductRecord *aProduct;
    NSMutableDictionary *aProductDict;
    switch (aQuery.nextTableView){
        case TVC1:
            break;
        case TVC2:
            break;
        case TVC3:
            break;
        case TVC4:
            break;
        case TVC5:
            break;
        case TVC8:
            aProductDict = aQuery.productDict;// [self.gGTPptr fetchProductDict:aQuery];

           [aProductDict setObject:[self buildPurchaseDictionaryArrayForAProduct:aQuery] forKey:kPurchaseDictionaryArrayKey];
            break;
        case TVC10:
            NSLog(@"");
            break;
            
        default:
            break;
            
    }
    
}

-(void) evaluateAction:(ActionRequest*)actionRequest //EXEcute a DB Query
{
    //can't do a transaction without a view displayed....HUD requires a view

    
    
    
    
    switch (queryMode) {
        case kAUTOMATIC:
            NSLog(@"        !!!!!! QUERYMODE AUTOMATIC");
            if ([autoInUsePtr.buttonTitle isEqualToString:@"MyraTest"]) {
                [self xactMyraTest:actionRequest];    //set dbtrans to nil(actionReq.transactionkey) because no host transaction... this moves it along
                [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:actionRequest];
                return;
                //NO RETURN>>>LET IT FALL THROUGH TO EXECUTE
            }
            
            
            if ([autoInUsePtr.buttonTitle isEqualToString:@"MovieInfo"]) {// NOT looping
               
                [self xactFetchallMovieInfoForZipCodeRequest:actionRequest];
                
            }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:@"CollectFREEmovieInformation"]) { //looping SO PUT RETURN IN IF HERE
                [self xactCollectFREEmovieInformation:actionRequest];
                return;   //looping xaction - calling special dbtrans execute, do not fall through
            
            }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:@"GetImages"]) {
                [self xactGetImages:actionRequest];    //set dbtrans to nil(actionReq.transactionkey) because no host transaction... this moves it along
                
                //NO RETURN>>>LET IT FALL THROUGH TO EXECUTE
            }
            if ([autoInUsePtr.buttonTitle isEqualToString:@"TVC1"]) {
                [self buildxactDoTVC1:actionRequest];
                //NO RETURN>>>LET IT FALL THROUGH TO EXECUTE
            }
        
        if ([autoInUsePtr.buttonTitle isEqualToString:@"TVC2"]) {
            [self buildxactDoTVC2:actionRequest];
            actionRequest.nextTableView=TVC2;
            //NO RETURN>>>LET IT FALL THROUGH TO EXECUTE
        }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:QueryMovieYouTubeTrailers]){
 //               if (!gGTPptr.inAVPlayerVC){
 //                   [self defineMovieTrailerQuery:actionRequest];
 //               }
                [self xactMovieTrailers:actionRequest];//LOOPING XACT, DO NOT FALL THROUGH
  //              return;
            }
  
            
       
        break;
        
        default: 
            NSLog(@"        !!!!!! QUERYMODE USERINPUT");
        break;
    }
    if (gGTPptr.debugFlag) {
        if ([actionRequest.buttonName isEqualToString:@"InitLoc"]){
            
            
            [self initLocationsDB:actionRequest];//;withDictionary:allLocationsHDI andRecordKeys:locationRecordKeys];
            return;
        }
        
        if ([actionRequest.buttonName isEqualToString:@"InitInv"]){
            [self initInventoryDB:actionRequest];//;withDictionary:allLocationsHDI andRecordKeys:locationRecordKeys];
            return;
        }
        if ([actionRequest.buttonName isEqualToString:@"MovieInfo"]){
            // [self xactFetchallMovieInfoOMDBRequest:actionRequest];
            [self fetchallMovieInfoOMDB:actionRequest];//old code
            return;
        }

    }
 
    Transaction *dbTransaction = nil;
    NSString *dictionaryKey = nil;
 
 //       dictionaryKey = [NSString stringWithFormat:@"Xaction%li",actionRequest.nextTableView];
        dictionaryKey = actionRequest.transactionKey;
        dbTransaction=activeTableDataPtr.dbAllTabTransDict [dictionaryKey];   //default transaction
    
     if(actionRequest){
        NSLog(@"actionRequest button name %@",actionRequest.buttonName);
    }

    
    if (dbTransaction) {
        //do real query
        actionRequest.arrayIndex=0;
        actionRequest.loopDictPtr=nil;
         [dbTransaction beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:actionRequest usingDataArray:activeTableDataPtr.tableVariablesArray];
          //notification is returned from dbTransaction when it completes or errors out
        
        
    }
    else{
        //fake a db Transaction one
        //?actionRequest.nextTableView = TVC0;   //stuff this?
        NSLog(@"do fake db xaction");
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:actionRequest];
    }
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NOTIFICATIONS
/////////////////////////////////////////
-(void) processInput:(NSNumber *)touchInput withTagString:(NSString*)tagString
{
    TableDef *currentTableDef = self.activeTableDataPtr;
    ActionRequest *pressedBtn = nil;
    pressedBtn = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:tagString];
    switch (pressedBtn.buttonType) {
        case kButtonTypeDate:
            self.gGTPptr.selectedDate=pressedBtn.buttonDate;
            pressedBtn.productDict=self.gGTPptr.selectedProdcuctDict;
            pressedBtn.locDict=self.gGTPptr.selectedLocDict;
            break;
        case kButtonTypeLocation:
            self.gGTPptr.selectedLocDict=pressedBtn.locDict;
            break;
        case kButtonTypeProduct:
            self.gGTPptr.selectedProdcuctDict=pressedBtn.productDict;
            break;
        case kButtonTypeShowTime:
            self.gGTPptr.selectedProdcuctDict=pressedBtn.productDict;
            self.gGTPptr.selectedLocDict=pressedBtn.locDict;
            break;
        case kButtonTypeTrailer:
            break;
            
        default:
            break;
    }
    if (pressedBtn.reloadOnly){
        
        NSLog(@"       reloadOnly");
        switch (pressedBtn.nextTableView){
            case TVC2://TVCScrollButtonPress:
                            NSLog(@"       TVC2");
                //[gGTPptr makeTVC2:pressedBtn];
                [gGTPptr makeTVC:pressedBtn];
                currentTableDef.cellDispPrepared = NO;
                [self prepareTheActiveTableDataForDisplay:pressedBtn];
                /*                   if (!gGTPptr.inAVPlayerVC){
                 [self defineMovieTrailerQuery:pressedBtn];
                 [self evaluateAction:pressedBtn];
                 }
                 */
                [currentTableDef showMeInDisplayReload:rtTableViewCtrler tvcCreatedWidth:currentTableDef.tvcCreatedWidth tvcCreatedHeight:currentTableDef.tvcCreatedHeight];
                break;
            case TVC21:
                NSLog(@"       TVC21");
                [gGTPptr makeTVC:pressedBtn];
                currentTableDef.cellDispPrepared = NO;
                [self prepareTheActiveTableDataForDisplay:pressedBtn];
//                [currentTableDef showMeInDisplayReload:rtTableViewCtrler tvcCreatedWidth:currentTableDef.tvcCreatedWidth tvcCreatedHeight:currentTableDef.tvcCreatedHeight];
                
                // [rtTableViewCtrler.tableView reloadData];
                 break;
            case TVC4://TVCScrollButtonPress:
                //[gGTPptr makeTVC2:pressedBtn];
                [gGTPptr makeTVC:pressedBtn];
                //                    rtTableViewCtrler.reloadOnly = YES;
                currentTableDef.cellDispPrepared = NO;
                [self prepareTheActiveTableDataForDisplay:pressedBtn];
                [currentTableDef showMeInDisplayReload:rtTableViewCtrler tvcCreatedWidth:currentTableDef.tvcCreatedWidth tvcCreatedHeight:currentTableDef.tvcCreatedHeight];
                break;
            default:
                break;
        }//end switch
        return;
    }//end reloadonly
    NSString *efdata;
    switch (pressedBtn.nextTableView) {
            
        case TVC1:
            [self defineTransactionsTVC1:pressedBtn];
            NSLog(@"do fake db xaction send successnotif1");
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
            break;
        case TVC2:
            [self defineTransactionsTVC2:pressedBtn];
            NSLog(@"do fake db xaction send successnotif2");
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
            return;
            break;
        case TVC3:
            //              [self defineTransactionsTVC3:pressedBtn];
            NSLog(@"do fake db xaction send successnotif3");
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
            return;
            break;
        case TVC4:
            NSLog(@"do fake db xaction send successnotif4");
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
            return;
            //              [self defineTransactionsTVC4:pressedBtn];
            break;
        case TVC5:
            break;
        case TVC10:
            NSLog(@"do fake db xaction    send successnotif5");
            
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
            //                [self defineTransactionsTVC10:pressedBtn];
            return;
            break;
        case TVCChangeZip:
            efdata=[gInputFieldsDictionary objectForKey:EFKEY_ZIPCODE];
            if (efdata) {
                if ([efdata isEqualToString:gGTPptr.globalZipCode]) {
                    pressedBtn.nextTableView=TVC2;
                    //do nothing all is good   - get rid of screen-
                    NSLog(@"            sending userControllerSuccess 1");
                    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
                    return;
                }
                else{
                    //replace zipcode , start over getting data for this zipcode
                    gGTPptr.globalZipCode=efdata;
                    pressedBtn.nextTableView = TVCInitDBs;   //new
                    NSLog(@"            sending zipstartover");
                    [[NSNotificationCenter defaultCenter] postNotificationName: ConstNEWZIPstartOver  object:pressedBtn];
                    return;
                }
                
            }
            else{
                NSLog(@"            sending userControllerSuccess 2");
                [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
                return;
            }
            
            break;
        default:
            break;
    }
    [self evaluateAction:pressedBtn];

}
-(void) userTouchInput: (NSNotification*) notification  //BUTTON/CELL PRESS
{
    
    NSLog(@"RUNTIME_ userTouchInput:notification");

    NSNumber *touchInput;
    NSString *tagString;
    if (notification){
        
 
        touchInput= [notification object];
            
     
        tagString = [touchInput stringValue];
        
        [self processInput:touchInput withTagString:tagString];
        
        
    }//end if notification
}

- (void)processUserFocusMovie:(NSNotification *)notification {
    int pass = [[[notification userInfo] valueForKey:@"index"] intValue];
    
    NSLog(@"**************RUNTIME processUserFocusMovie: %d",pass );
    
    NSNumber *touchInput;
    NSString *tagString;
    
    if (notification) {
        touchInput =[NSNumber numberWithInt:pass];
        tagString = [touchInput stringValue];
        [self processInput:touchInput withTagString:tagString];
    }
    
  }

-(void) continueXactLoop:(NSNotification *)notification
{
    ActionRequest *aQuery = [notification object];
    //aQuery holds index
    
    
    Transaction *dbTrans = nil;
    
    
    
    
    
    
    
    TransactionData* tranCodeData=[[TransactionData alloc]init];
    

         //anything to do?
        aQuery.arrayIndex++;
        if (aQuery.arrayIndex >= [movieNameArray count]) {
            //done, return done no transaction to do
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstDoneLoopingXactionResponseProcessed  object:aQuery];
            
            return;
        }
        
        
        
        dbTrans = [[Transaction alloc]initWithQTitle:@"OMBD Query" andQDescr:@"Movie Informatiion" andNumber:0];
        dbTrans.URL=@"http://97.77.211.34/~Dwain/omdbTest";
        aQuery.errorDisplayText=@"Movie Information -continueXactLoop";
        [activeTableDataPtr.tableVariablesArray removeAllObjects];
        tranCodeData.queryKey= @"MovieName";
        NSString *qField=[movieNameArray objectAtIndex:aQuery.arrayIndex];
        tranCodeData.userDefinedData=qField;
        aQuery.aiKeyForResultDict=qField;
        
        [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    TransactionData* tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey= @"MovieYear";
    NSString *someMoveYear=nil;
    if (qField) {
        someMoveYear=[movieYearDictionary objectForKey:qField];
        if (![someMoveYear isEqualToString:kNoMovieYear] ) {
            tranCodeData1.userDefinedData=someMoveYear;
            [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];    //this is an optional parameter, only pass it if it exists.
        }
    }

    
    
    
    
    
    
        [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
        NSLog(@"Runtime continue LOOPING movieName %@",qField);
        
        [dbTrans loopingTransactionViewActive:self.rtTableViewCtrler.view actReq:aQuery usingDataArray:activeTableDataPtr.tableVariablesArray];
        
        
        
        
        
        return;

    
    
    
    
 }
-(void) doneLoopingXactionResponseProcessed:(NSNotification *)notification
{
    ActionRequest *aQuery = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:aQuery];
    //NOT USED ANYMORE
    
    return;
    
    
    
    
    
    
       
}
-(void)processDataBaseResponse:(NSNotification *)notification
{
    
    ActionRequest *aQuery = [notification object];
    NSLog(@"RRRRRRRRR Process db ResponseString = %@",aQuery);
   // NSMutableDictionary *bigTrailerDict;
    TableDef *thisTDataPtr1 ;
    switch (queryMode) {
        case kHOSTERROR:
            NSLog(@"host error reported");
            autoCounter=0;
            aQuery.buttonName=@"SHOW ERROR";
            aQuery.nextTableView=TVCERROR;
            thisTDataPtr1 = [gGTPptr makeTVC:aQuery]; // If TVC definition comes from DB Sever, use it.
            if (thisTDataPtr1)
                [self displayATVC:thisTDataPtr1 pressedBtn:aQuery];
            
            return;

            break;
        case kAUTOMATIC:
        //OK got some data... what to do with it?   <change this>
            
            //if ([autoInUsePtr.buttonTitle isEqualToString:@"MyraTest"]) {
            //    [self newpostFetchallMovieInfoForZipCodeRequest:aQuery extractNames:movieNameArray];
               
            //    NSLog(@"done myraTest");
                
           // }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:@"MovieInfo"]) {
                
                NSLog(@"done auto got allmovies list");
                [self postFetchallMovieInfoForZipCodeRequest:aQuery extractNames:movieNameArray];
            }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:@"CollectFREEmovieInformation"]) {
                
                NSLog(@"done auto collectFreeMovieInformation list");//looping query/process thing
                
            }
            if ([autoInUsePtr.buttonTitle isEqualToString:@"GetImages"]){
                //do nothing
                [self postProcessODBCqueryImages:aQuery];
                NSLog(@"done auto download img");
            }

            if ([autoInUsePtr.buttonTitle isEqualToString:@"TVC1"]) {
                
                
                [self postTVC1:aQuery];
                
            }


            if ([autoInUsePtr.buttonTitle isEqualToString:@"TVC2"]) {
                //do nothing
                NSLog(@"done auto tvc2");
            }
            
            if ([autoInUsePtr.buttonTitle isEqualToString:QueryMovieYouTubeTrailers]){
                if (!gGTPptr.inAVPlayerVC){
                    [movieTrailers removeAllObjects];
                    [movieTrailers addObjectsFromArray:aQuery.retRecordsAsDPtrs];
   //                 bigTrailerDict = [aQuery.retRecordsAsDPtrs objectAtIndex:0];
   //                 [movieTrailers addObject:bigTrailerDict];
  //                  [activeTableDataPtr.autoXACTarray removeAllObjects];
 //                   return;
                }else{
                    [self postProcessMovieTrailers:aQuery];
                NSLog(@"");
                }
            }
                

            
            
        //increment
        autoCounter++;
        if (autoCounter >= [activeTableDataPtr.autoXACTarray count]) {
        
            
            
            autoCounter=0;
            queryMode=kUSERBUTTON;
            //fall through
        }
        else{
            autoInUsePtr=[activeTableDataPtr.autoXACTarray objectAtIndex:autoCounter];
            aQuery.buttonName=autoInUsePtr.buttonTitle;
            [self evaluateAction:aQuery];
            return;
        }
        break;
        
        default: //case kUSERBUTTON
        //no idea  GO BACK TO OLD PROCESSING>>>>how to get new screen up?
        break;
    }
    

    
    
    
    
    
    
    
    if (initializingLocDB){
        [self initLocationsDB:aQuery];
        return;
    }
    if (initializingInvDB){
        [self initInventoryDB:aQuery];
        return;
    }
    
    if (fetchingMovieInfo){
        [allMovieInfoOMDB setObject:[aQuery.retRecordsAsDPtrs objectAtIndex:0] forKey:[movieNameArray objectAtIndex:initDBRecordKeyIndex-1]];
        [self fetchallMovieInfoOMDB:aQuery];
        //        initDBRecordKeyIndex++;
        return;
    }
    // [self pretendDBReturnData:queryAction];
    if (!aQuery) {
        aQuery=[[ActionRequest alloc]init];
        aQuery.nextTableView=TVC1;
    }
    loggedIn = YES;

    
    [self setupTVCdata:aQuery];                        // This will go away as DB transactions are done.
    TableDef *thisTDataPtr = [gGTPptr makeTVC:aQuery]; // If TVC definition comes from DB Sever, use it.
    if (thisTDataPtr)
        [self displayATVC:thisTDataPtr pressedBtn:aQuery];
}



- (void) chgVCbadUser:(NSNotification *) notification
{
    //THIS IS WRONG
    
    ActionRequest *queryAction = [notification object];
    //   self.executionState = queryAction.nextTableView;
    //   self.executionState = TVC0;
    queryAction.nextTableView=TVCERROR;
    loggedIn = NO;
    queryMode=kHOSTERROR;
    [self processDataBaseResponse:notification];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark PRE-XACTION
/////////////////////////////////////////
-(void) xactMovieTrailers:(ActionRequest *)aReq //not LOOPING
{
    Transaction *dbTrans = nil;
    if (!gGTPptr.inAVPlayerVC){
        [self defineMovieTrailerQuery:aReq];
        return;
        
    }
    
    
    
    
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MovieTrailers";
    
    if (!self.allProductInventory_HDI) { // if (!allProductInventory){
    
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstDoneLoopingXactionResponseProcessed  object:aReq];
    }
//    NSMArray *oldIdsArray=[self extractIDs:allProductInventory];
    NSMutableArray *idsArray=[NSMutableArray arrayWithArray:[allProductInventory_HDI allKeys]];//[self extractIDs:allProductInventoryHDI]; //allProductInventory
    
    
    
    
    
    //what movie trailers do I need?
  //  NSMutableArray *idsIHaveArray;
    if (allMovieTrailersHDI) {
        
        idsArray=[self purgeAndAssignTrailerList:idsArray];
        
        if ([idsArray count]<1) {
            if (allMovieTrailersHDIdictWTD) {   //a change was made, so store it
                [[DiskStore sharedDiskStore]archiveAStoreDictionary:allMovieTrailersHDI withName:DISK_TRAILERSTORE];
                
                allMovieTrailersHDIdictWTD=false;
            }

            return;
        }
    }
    
    
    
    
    
    
 
    
    TransactionData* tranCodeData1;
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"TMSapi" andQDescr:@"Get All Video Assets and trailers for a movie" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/tmsapiTest";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= TranCodeKey;
    tranCodeData.userDefinedData= TranCodeTrailerForMovie;
   // tranCodeData.userDefinedData=@"pretendGetAssets";
    aReq.errorDisplayText=@"Get All Video Assets and Trailers for a movie";
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    
    //NOT LOOPING ANYMORE
    aReq.arrayIndex=0;   //index into query string array we are using, ie. movieNameArray
    //aReq.loopDictPtr=[[NSMutableDictionary alloc]init];
    if (!allMovieTrailersTMS) {
        allMovieTrailersTMS=[[NSMutableDictionary alloc]init];
    }

    
    
    aReq.loopDictPtr=allMovieTrailersTMS;   //where results go
 //   NSString *qfield=[idsArray objectAtIndex:0];
    NSString *qfield=   [self implodeArrayOfStrings:idsArray];
    aReq.aiKeyForResultDict=qfield;
    
    aReq.efLoopArrPtr= idsArray;
    
    
    tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey= @"rootId";
    
    tranCodeData1.userDefinedData=qfield; //doesn't matter cause only one key,value pair in here
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    
    
    //here's the deal - storingKey has to be real name, but names can't search with 3d in them.
    //so loopArrData is correctedNameArray (no 3d in name).... storingKeyArray is movieNameArray (real complete name)
    //   [dbTrans loopingTransactionOnView:self.rtTableViewCtrler.view actionReq:aReq usingSendDataArray:activeTableDataPtr.tableVariablesArray  loopingKey:@"MovieName" loopArrData:correctedNameArray retDictWithLoopArrrDataKey:allMovieInfoOMDB storingKeyArray:movieNameArray];
    
//    [dbTrans loopingTransactionViewActive:self.rtTableViewCtrler.view actReq:aReq usingDataArray:activeTableDataPtr.tableVariablesArray];
    
    
    
    

}

-(void) xactCollectFREEmovieInformation:(ActionRequest *)aReq   //new....   DOES THE XACTION    //LOOPING
{
    //LOOPING XACTION  use ODBC (free) to get all movie information based on movies in array movieNameArray, looping return populates allMovieInfoOMDB dictionary.   DO DISPLAYS FROM HERE
    Transaction *dbTrans = nil;
    
    
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MovieInfo";
    
    if ([movieNameArray count] < 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName: ConstDoneLoopingXactionResponseProcessed  object:aReq];
    }
    
    //NSMutableArray *correctedNameArray=[self correctMovieNames:movieNameArray];
    
    
    
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"OMBD Query" andQDescr:@"Movie Informatiion" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/omdbTest";
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= @"MovieName";
    aReq.errorDisplayText=@"movieInformation - xactCollect";
    
    //THIS IS LOOPING XACTION.. LOOP THROUGH MOVIE NAME ARRAY. POPULATE allMovieInfoOMDB
    aReq.arrayIndex=0;   //index into query string array we are using, ie. movieNameArray
    //aReq.loopDictPtr=[[NSMutableDictionary alloc]init];
    aReq.loopDictPtr=allMovieInfoOMDB;   //where results go
    NSString *qfield=[movieNameArray objectAtIndex:0];
    aReq.aiKeyForResultDict=qfield;

    
    
    
    tranCodeData.userDefinedData=qfield; //doesn't matter cause only one key,value pair in here
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    TransactionData* tranCodeData1=[[TransactionData alloc]init];
     tranCodeData1.queryKey= @"MovieYear";
    NSString *someMoveYear=nil;
    if (qfield) {
        someMoveYear=[movieYearDictionary objectForKey:qfield];
        if (![someMoveYear isEqualToString:kNoMovieYear] ) {
            tranCodeData1.userDefinedData=someMoveYear;
            [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];    //this is an optional parameter, only pass it if it exists.
        }
    }
    
    
    //here's the deal - storingKey has to be real name, but names can't search with 3d in them.
    //so loopArrData is correctedNameArray (no 3d in name).... storingKeyArray is movieNameArray (real complete name)
 //   [dbTrans loopingTransactionOnView:self.rtTableViewCtrler.view actionReq:aReq usingSendDataArray:activeTableDataPtr.tableVariablesArray  loopingKey:@"MovieName" loopArrData:correctedNameArray retDictWithLoopArrrDataKey:allMovieInfoOMDB storingKeyArray:movieNameArray];
    NSLog(@"getting free movie data for %ld movies",[activeTableDataPtr.tableVariablesArray count]);
    [dbTrans loopingTransactionViewActive:self.rtTableViewCtrler.view actReq:aReq usingDataArray:activeTableDataPtr.tableVariablesArray];
    
    
 

}
-(void) xactMyraTest:(ActionRequest *)aReq
{
    
    NSLog(@"do fake db xaction");
    aReq.nextTableView=TVC0;
    aReq.transactionKey=nil;
        //
    
    return;
    
    //TESTING PHP
  /*  Transaction *dbTrans = nil;
    
    
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MyraTest";
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"Test" andQDescr:@"Myra Testing" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/myraTesting";
    
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= TranCodeKey;
    tranCodeData.userDefinedData= TranCodeMoviesForZip;
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    
    tranCodeData=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData.queryKey=ZipCodeKey;//NEW
    tranCodeData.userDefinedData= @"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];//NEW
    
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    */
     Transaction *dbTrans = nil;
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MovieInfo";
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"Test" andQDescr:@"Myra Testing - Movie Informatiion for Zip" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/myraTesting";
    aReq.errorDisplayText=@"m testing movie info for zip";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= TranCodeKey;
    tranCodeData.userDefinedData= TranCodeMoviesForZip;
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    
    tranCodeData=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData.queryKey=ZipCodeKey;//NEW
    tranCodeData.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];//NEW
    sleep(1);
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];

    
    
}
-(void) xactFetchallMovieInfoForZipCodeRequest:(ActionRequest *)aReq   //new....   DOES THE XACTION
{   //MOVIES PLAYING IN ZIPCODE>>>>POPULATES MOVIENAMES
    Transaction *dbTrans = nil;
    
    
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MovieInfo";
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"TMSapi" andQDescr:@"Movie Informatiion for Zip" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/tmsapiTest";
    aReq.errorDisplayText=@"movie info for zip xactFetchAll";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= TranCodeKey;
    tranCodeData.userDefinedData= TranCodeMoviesForZip;
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    
    tranCodeData=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData.queryKey=ZipCodeKey;//NEW
    if ([gGTPptr.globalZipCode length] < 5) {
        NSLog(@"EEEEEEEEEEEEE-----Fixing stored zipcode Error was %@ now is 75248",gGTPptr.globalZipCode );
        gGTPptr.globalZipCode=@"75248";
    }
    tranCodeData.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];//NEW
    sleep(1);
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    
    
    
}
-(UIImage *) goGetImageAtPath:(NSString *)mPath withName:(NSString *)mName
{
    UIImage *itImage;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defMovie" ofType:@"png"];
    UIImage * defImage = [UIImage imageWithContentsOfFile:filePath];
     NSURL* pathAurl = [NSURL URLWithString:mPath];
    
    if (pathAurl) {
        NSLog(@" Qfetch %@ at \n %@",mName,mPath);
        itImage=[self downloadSyncImageWithURL:[NSURL URLWithString:mPath] forKey:mName];
        if(!itImage){
            NSLog(@"****downloadSyncImageWithURL failed path:%@ name:%@",mPath,mName);
            itImage=defImage;
            
        }
        
        
    }
    else{
        return defImage;
    }
    NSLog(@"****downloadSyncImageWithURL size:%@", NSStringFromCGSize(itImage.size));
    return itImage;
}

-(void) xactGetImages:(ActionRequest *)aReq   //new....   DOES THE XACTION for uiimage
{
    NSString *mName;
    NSString *mPath;
    BOOL downloadDone=false;
    int downloadKeyCtr=0;
    NSMutableDictionary *thisDictPtr;
    if ([movieNamesForImageDownloads count]) {   //was movieNameArray
        downloadKeyCtr=0;
        movieImageDictionaryWTD=TRUE;  //there are images to download
    }
    else {
        downloadDone=TRUE;
        //no movie images to download....they were in our archive
        movieImageDictionaryWTD=FALSE;
    }
    
    
    UIImage *itImage;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defMovie" ofType:@"png"];
    UIImage * defImage = [UIImage imageWithContentsOfFile:filePath];
    
    
    
    
    //preProcess list to download.  We have dictionary from disk if we've run before.  Some movies have to be deleted, some have to be added.
    //after downloading, entire dictionary should be store to disk again.   thus, making next load during same week FASTER.
    
    
    while (!downloadDone) {
        mName=[movieNamesForImageDownloads objectAtIndex:downloadKeyCtr];   //was movieNameArray
        thisDictPtr=[allMovieInfoOMDB objectForKey:mName];
        mPath=[thisDictPtr objectForKey:@"Poster"];
        
        
        NSURL* pathAurl = [NSURL URLWithString:mPath];
        
        
        
        if (pathAurl) {
            NSLog(@" Qfetch %@ at \n %@",mName,mPath);
            itImage=[self downloadSyncImageWithURL:[NSURL URLWithString:mPath] forKey:mName];
            if(!itImage){
                itImage=defImage;
                [movieImageDictionaryPath setObject:@"dummy" forKey:mName];
            }
            else{
                [movieImageDictionaryPath setObject:pathAurl forKey:mName];
            }
                
            [movieImageDictionary setObject:itImage forKey:mName];
            NSLog(@"Image Download Succeeded");
        }
        else{
            [movieImageDictionary setObject:defImage forKey:mName];
            [movieImageDictionaryPath setObject:@"dummy" forKey:mName];
            NSLog(@"NOfetch1 %@ at \n %@",mName,mPath);
        }
        downloadKeyCtr++;
        if (downloadKeyCtr >= [movieNamesForImageDownloads count]) {   //was movieNameArray
            downloadDone=TRUE;
        }
    }//end while

    
    [self purgeAndSaveMovieImageDiskDictionary];
    
    
    NSLog(@"do fake db xaction");
    aReq.transactionKey=@"NONE";    //[[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:aReq];
    
    
}

-(void) buildxactDoTVC2:(ActionRequest *)pressedBtn   //new....
{
    
    NSLog(@"do fake db xaction");
    pressedBtn.transactionKey=@"NONE";    //[[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:aReq];
    return;
    
    
    
    
    
    
    
    
    
    
    
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    Transaction *dbTrans;
    
    pressedBtn.transactionKey =  TranCodeAllInv;
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeQueryLocation;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey=QueryLocationName;
    pressedBtn.errorDisplayText=@"Inventory List doTVC2";
    tranCodeData1=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData1.queryKey=ZipCodeKey;//NEW
    tranCodeData1.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];//NEW
    
    //              aLocation =   [allLocationsHDI objectForKey:pressedBtn.dataRecordKey];
    //              tranCodeData1.userDefinedData= aLocation.locationName;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    
}
-(void)buildxactDoTVC1:(ActionRequest *)pressedBtn   //new....
{//LOCATIONS USING ZIPCODE
    TransactionData *tranCodeData, *tranCodeData1;
    
    Transaction *dbTrans;
    // [self buildLocationsDictionary:10];
    
    
    
    pressedBtn.transactionKey =  TranCodeAllLocs;
    pressedBtn.buttonName = @"Theater List";
    //      if ([pressedBtn.transactionKey isEqualToString:TranCodeAllLocs]){
    dbTrans = [[Transaction alloc]initWithQTitle:@"Locations" andQDescr:@"LocationsList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/tmsapiTest";
    
    //           dbTrans.URL=@"http://localhost/~DanHammond/locations";
    //           dbTrans.URL=@"http://localhost/~myra/locations";
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    
    pressedBtn.errorDisplayText=@"locations list tvc1";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    //OLD   tranCodeData.userDefinedData= TranCodeAllLocs;
    tranCodeData.userDefinedData= TranCodeLocForZip;//NEW
    
    
    
    
    
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    tranCodeData1=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData1.queryKey=ZipCodeKey;//NEW
    tranCodeData1.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];//NEW
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllLocs];// startUpTVCKey];
    
    
    
    
    
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark DICTIONARY-ARCHIVEME
/////////////////////////////////////////
-(NSMutableArray*) purgeAndAssignTrailerList:(NSMutableArray *)arrIneed
{
    NSMutableArray *arrTrailersToGet=[[NSMutableArray alloc]init];
   // NSMutableArray *keysToRemove=[[NSMutableArray alloc]init];
    NSMutableArray *allKeysDictDeletes=[NSMutableArray arrayWithArray:[allMovieTrailersHDI allKeys]];
    //arrIneed has a list of all movieIDs.  Some of these are in the trailerDictionary already.  Some maybe are not
    //return array of what I really need and flag if the dictionary has to be written because purge has happened
    
    NSString *key;
    for (int i=0; i< [arrIneed count]; i++) {
        key=[arrIneed objectAtIndex:i];
        if ([allMovieTrailersHDI objectForKey:key]) {
            [allKeysDictDeletes removeObject:key];
        }
        else{
            [arrTrailersToGet addObject:key];
        }
    }
    
    
    
    //purge dictionary we have
      for(id key in allKeysDictDeletes) {
          [allMovieTrailersHDI removeObjectForKey:key];
          allMovieTrailersHDIdictWTD=TRUE;
    }
    
    //JUST TEST  [allMovieTrailersHDI removeObjectForKey:@"12329215"];   //finding dory
    //JUST TEST  [arrTrailersToGet addObject:@"12329215"];
    //JUST TEST  allMovieTrailersHDIdictWTD=TRUE;
    
    return arrTrailersToGet;
    
    
  
    
    
    
}
-(void)purgeAndSaveMovieImageDiskDictionary
{
    //this is called after image downloads have happened for all movieNames we didn't have in the dictionary.
    
    //purge extra movie images - old images
    
    
    //TEST  B E L O W     add some dummy data to remove
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buffy100x100" ofType:@"png"];
    //  UIImage * defImage = [UIImage imageWithContentsOfFile:filePath];
    //  [movieImageDictionary setObject:defImage forKey:@"defMovie"];
    //  [movieImageDictionary setObject:defImage forKey:@"defMovie2"];
    
    
    NSMutableArray *keysToRemove=[[NSMutableArray alloc]init];
    
    for(id key in movieImageDictionary) {
        
        if (![movieNameArray containsObject:key]) {
            [keysToRemove addObject: key];
            movieImageDictionaryWTD=TRUE;//we removed something, so save to disk
        }
        
    }
    for(id key in keysToRemove) {
        [movieImageDictionary removeObjectForKey:key];
    }
    
    
    
    
    if (!movieImageDictionaryWTD) {
        return;
    }
    //archive all out stuff to disk, so we have it
    [[DiskStore sharedDiskStore]archiveAStoreDictionary:self.movieImageDictionary withName:DISK_IMAGESTORE];
   
    movieImageDictionaryWTD=FALSE;
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark POST-XACTION
/////////////////////////////////////////
-(void) postProcessODBCqueryImages:(ActionRequest *)aReq
{
    //move ODBC data from separate dictionary into main dictionary
   //DORY  NSMutableDictionary *dptr=[allProductInventory objectForKey:[tmsRootIDHelperDict objectForKey:@"12329215"]];
    UIImage *productImage ;
    NSMutableDictionary *tmsDptr;
    NSString *myName;
   // NSString *rootID;
    NSMutableDictionary *pidPtr;
    
    NSString *keyName;
    NSMutableDictionary *allPPtr;   //allProduct
    NSMutableDictionary *allIPtr;  //allInventory
    NSMutableDictionary *allI2Ptr;  //allInventory
    
   // NSMutableDictionary *dummypid=[[NSMutableDictionary alloc]init];
    
    for(id keyNumber in allProductDefinitions_HDI) {
        allPPtr=[allProductDefinitions_HDI objectForKey:keyNumber];
        keyName=[allPPtr objectForKey:kMovieTitle];
        pidPtr = [allMovieInfoOMDB objectForKey:keyName];   //key is the name of the movie
        myName=keyName;//[pidPtr objectForKey:@"Title"];
        //allIPtr=[allProductInventoryHDI objectForKey:keyNumber];
        allI2Ptr=[allProductInventory_HDI objectForKey:keyNumber];
       // tmsDptr=[allProductInventoryHDI objectForKey:myName];
        
      //  rootID=[tmsDptr objectForKey:kProductIDKey];//debug purposes
        productImage = [movieImageDictionary objectForKey:myName];
        
        if(!pidPtr){
            //weird problem where ODBC database hanging on responses....
            pidPtr=[[NSMutableDictionary alloc]init];
            [pidPtr setObject:myName forKey:@"Title"];
            [pidPtr setObject:@"THIS IS DUMMY DATA - HOST ERROR" forKey:@"Plot"];
            NSLog(@"DUMMY pidPtr for %@",myName);
        }
       // if (allIPtr) {   this is an array?
       //         [allIPtr setObject:pidPtr forKey:kProductDescriptionKey];
       //         [allIPtr setObject:productImage forKey:kProductImageKey];
       //
       // }
        
        if (allPPtr) {
            [allPPtr setObject:pidPtr forKey:kProductDescriptionKey];
            if (productImage) {
                [allPPtr setObject:productImage forKey:kProductImageKey];
            }
            
        }

      
        
        
    }
    
    // NSMutableDictionary *dptr=[allProductInventory objectForKey:[tmsRootIDHelperDict objectForKey:@"12329215"]];
    NSLog(@"");

    
}
-(void)postProcessMovieTrailers:(ActionRequest *)aReq
{
    
   // NSMutableDictionary *newDict=[[NSMutableDictionary alloc]init];
    allMovieTrailersTMS=[[NSMutableDictionary alloc]init];
    
 
    
    
    /*
    NSMutableDictionary *dictPtr=[[aReq.retRecordsAsDPtrs objectAtIndex:0] valueForKey:@"response"];;
    if (!dictPtr) {
        return;
    }
     */
    NSMutableArray *arrPtr;//=[dictPtr valueForKey:@"trailers"];
    
    
    
    arrPtr=[[aReq.retRecordsAsDPtrs objectAtIndex:0] valueForKeyPath:@"response.trailers"];
    if (!arrPtr) {
        return;
    }
    NSString *rootstr;
    NSNumber *num;
   // long int rootLint;
    int rootint;
    
    NSString *myName;
    NSString *myrootKey;
    NSString *myTrailerValue;
    NSMutableArray *myTrailerArray;
    
    NSMutableArray *tmsTrailerArray;
    NSString *tmsKeyConcat;
    NSMutableDictionary *tmsDptr;
    
    NSNumber *thisBitrateID;
    NSNumber *lBitrateID=[NSNumber numberWithInt:457] ;   //this is movie format I'm storing
    NSString *thisClipIDstr;
    
    NSNumber *jpgBitrateID=[NSNumber numberWithInt:270];//267] ; //this is trailer image format im storing.  this is biggest, I bet smallest is good enough?
    
    NSMutableDictionary *hdiClipDict;
    NSMutableDictionary *hdiTrailerDictionary;
    NSString *thisBitRateIDstr;
    
    
    UIImage *trailerImage;
    for (NSMutableDictionary *dobj in arrPtr)
    {
        num=[dobj valueForKeyPath:@"RootId"];
        rootint=[num intValue];
        rootstr=[num stringValue];
        
        

        
        myrootKey=rootstr;
        myTrailerValue=[dobj valueForKeyPath:@"Url"];
        myTrailerArray=[allMovieTrailersTMS valueForKeyPath:myrootKey];
        hdiTrailerDictionary=[allMovieTrailersHDI valueForKey:myrootKey];
        
        
        
        /*get name from somewhere else*/
        myName= nil; // NOTE THIS IS BROKEN [tmsRootIDHelperDict valueForKeyPath:myrootKey]; //key title = val rootID  AND  key rootID = val title
        tmsKeyConcat=[NSString stringWithFormat:@"%@.%@", myName, kProductVideoArray];
        tmsDptr=[allProductInventory_HDI objectForKey:myName]; //was allProductInventory
        tmsTrailerArray=[allProductInventory_HDI valueForKeyPath:tmsKeyConcat ]; //was allProductInventory
        
        
        thisBitrateID=[dobj valueForKey:@"BitrateId"];   //allMovieTrailerTMS  stores trailer strings for bitrateid 457 ONLY  457= widescreen mp4
        thisBitRateIDstr=[thisBitrateID stringValue];
        
        thisClipIDstr=[dobj valueForKey:@"EClipId"];
        
        
        
        if (!myTrailerArray) {
            myTrailerArray=[[NSMutableArray alloc]init];
            [allMovieTrailersTMS setObject:myTrailerArray forKey:myrootKey];
        }
        if ([thisBitrateID isEqualToNumber:lBitrateID]) {
            [myTrailerArray addObject:myTrailerValue];
        }
        
        //========below new
        //allMovieTrailersHDI=(key rootId) Dictionary   = (key clipID) Array of dobj
        if (!hdiTrailerDictionary) {
            hdiTrailerDictionary=[[NSMutableDictionary alloc]init];
            [allMovieTrailersHDI setObject:hdiTrailerDictionary forKey:myrootKey];
            allMovieTrailersHDIdictWTD=TRUE;
        }
        
        hdiClipDict=[hdiTrailerDictionary valueForKey:thisClipIDstr];
        if (!hdiClipDict) {
            hdiClipDict=[[NSMutableDictionary alloc]init];
            [hdiTrailerDictionary setObject:hdiClipDict forKey:thisClipIDstr];
        }
 

        if ([thisBitrateID isEqualToNumber:lBitrateID]) {   //addonly widescreen mp4 format link
            [hdiClipDict setObject:myTrailerValue forKey:kVideoPath];
        }
        if ([thisBitrateID isEqualToNumber:jpgBitrateID]) { //addonly 1 jpg format 250x200  (I know this is big)
            [hdiClipDict setObject:myTrailerValue forKey:kVideoImagePath];
            trailerImage=[self goGetImageAtPath:myTrailerValue withName:thisClipIDstr];
            [hdiClipDict setObject:trailerImage forKey:kVideoImage];
        }
        
        //========above new
        
  
        
        
        
        if (!tmsTrailerArray) {
            tmsTrailerArray=[[NSMutableArray alloc]init];
            [tmsDptr setObject:tmsTrailerArray forKey:kProductVideoArray];
        }
        if ([thisBitrateID isEqualToNumber:lBitrateID]){   //tms dictionary's product video array   stores trailer strings for bitrateid 457 ONLY
            [tmsTrailerArray addObject: myTrailerValue];
        }
        
        
        
        
        
        if ([rootstr isEqualToString:@"12329215"]) { //finding Dory
            NSLog(@"");
        }
        
        NSLog(@"");
    }
  /*  for(id key in aReq.retRecordsAsDPtrs) {
        id value = [aReq.retRecordsAsDPtrs objectForKey:key];
        id next=[value objectForKey:@"response"];
        [newDict setObject:next forKey:key];
        NSLog(@"");
        
    }*/
    
   //check this out
  //  NSMutableDictionary *someDictionary=[allMovieTrailersHDI objectForKey:@"12329215"];   //finding dory
  //  myTrailerArray=[allMovieTrailersTMS objectForKey:@"12329215"];
    
    
    
    
    if (allMovieTrailersHDIdictWTD) {   //a change was made, so store it
        [[DiskStore sharedDiskStore]archiveAStoreDictionary:allMovieTrailersHDI withName:DISK_TRAILERSTORE];
       
        allMovieTrailersHDIdictWTD=false;
    }

    
    
    NSLog(@"");
}

-(void) postFetchallMovieInfoForZipCodeRequest:(ActionRequest *)aReq extractNames:(NSMutableArray *)namePtr
{
       //POPULATE A LIST OF MOVIES FROM THIS....NEEDED MOVIE NAMES SO IMAGES CAN BE RETRIEVED FROM ODBC
    aReq.transactionKey=nil;//otherwise this repeats
   
    

    
    [namePtr removeAllObjects];
    
    
    
    //TMS has duplicate entries, so merge is a preProcess done through Decrypt class
    [Decrypt performALLPreProcess:aReq];
 
    
    
    //when here, dups gone, data merged (thanks decrypt process)
    
    movieNameArray=[[NSMutableArray alloc]init];
    movieYearDictionary=[[NSMutableDictionary alloc]init];

    NSString *thisID;
    NSString *thisKey;
    NSString *tmsId;
    NSMutableArray *shows;
    
    NSString * reqUniqueKey;
    NSString * movieTitle;
    NSString * movieID;
    NSString * movieReleased;
    NSString * movieYear;
    NSString * movieRated;
    NSString * movieRuntime;
    NSString * movieGenre;
    NSString * movieDirector;
    NSString * movieWriter;
    NSString * movieActors;
    NSString * moviePlot;
    NSString * movieShortPlot;
    NSString *movieShowTimes;
    NSString *movieAdvisories;
    
    
    //USED FOR INVENTORY
    NSString *showDateAndTime;
    NSString *showPurchaseLink;
    NSString *showTheaterID;
    NSString *showTheaterName;
    NSString *showBarg;
    NSString *showQual;
    
    
    
  /*   Decrypt dict for TMS
    Actors = topCast;
    Advisories = advisories;
    Director = directors;
    Genre = genres;
    "HDI_OPT Process" =     (
                             "HDI_PROCESS MERGE"
                             );
    "HDI_PROCESS MERGE" =     {
        "MERGE Fields" =         (
                                  showtimes
                                  );
        "MERGE Key" = rootId;
    };
    "HDI_REQ FName" = "getMoviesPlayingForZipCode.tmsapiTest.php";
    "HDI_REQ Revision" = "0.1";
    "HDI_REQ UniqueKey" = rootId;
    Image = "preferredImage.uri";
    MovieID = tmsId;
    Plot = longDescription;
    Rated = "ratings.code";
    Released = releaseDate;
    Runtime = runTime;
    ShowTimes = showtimes;
    Title = title;
    Writer = writer;
*/
    NSMutableDictionary *tmpNewHDIdict;
    NSMutableDictionary *tmpNewShowDict;
    NSMutableArray *tmpNewShowArray;
    NSNumber *tmpNumber;
    
    for (NSMutableDictionary *obj in aReq.retRecordsAsDPtrs) {
        
        
        thisID=[Decrypt valForHDIKey:kDECRYPT_REQ_UNIQUEKEY inDict:obj decryptDict:aReq.decryptDict];//[obj objectForKey:@"rootId"];
        if (!thisID) {
            //do nothing, no key to file it in
        }
        else
        {
            tmsId=[Decrypt valForHDIKey:kMovieID inDict:obj decryptDict:aReq.decryptDict];//[obj objectForKey:@"tmsId"];
            shows=[Decrypt arrFromDecryptDictForKey:kMovieShowTimes inDict:obj decryptDict:aReq.decryptDict];//[obj objectForKey:@"showtimes"];
            thisKey=[Decrypt valForHDIKey:kMovieTitle inDict:obj decryptDict:aReq.decryptDict];//[obj objectForKey:@"title"];
            
            
            
            
            //these are events not movies    Should be done in decrypt
               NSMutableArray *anArray;
            
                
                
                [movieNameArray addObject:thisKey];
               // [allProductDefinitionsHDI setObject:obj forKey:thisID];   //don't I need decrypt to read this dict? obj is TMS keys!
               // [allProductInventoryHDI setObject:shows forKey:thisID];   //don't I need decrypt to read this dict? obj is TMS keys!
                
                
                //******decrypt and flatten for storing in dictionary with HDI keys in allProductDefinitions_HDI
                reqUniqueKey=[Decrypt valForHDIKey:kDECRYPT_REQ_UNIQUEKEY inDict:obj decryptDict:aReq.decryptDict];
                movieTitle=[Decrypt valForHDIKey:kMovieTitle inDict:obj decryptDict:aReq.decryptDict];
                movieID=[Decrypt valForHDIKey:kMovieID inDict:obj decryptDict:aReq.decryptDict];
                movieReleased=[Decrypt valForHDIKey:kMovieReleased inDict:obj decryptDict:aReq.decryptDict];
            
            
                tmpNumber=[Decrypt numForHDIKey:kMovieYear inDict:obj decryptDict:aReq.decryptDict];
            movieYear=[tmpNumber stringValue];
            if (!movieYear) {
                movieYear=kNoMovieYear;//have to have a dummy placeholder here
            }
            [movieYearDictionary setObject:movieYear forKey:movieTitle];
            
            
                movieRated=[Decrypt valForHDIKey:kMovieRated inDict:obj decryptDict:aReq.decryptDict];
                //anArray=[Decrypt arrFromDecryptDictForKey:kMovieRated inDict:obj decryptDict:aReq.decryptDict];
                //if ([anArray count]) {
               //     movieRated = [anArray componentsJoinedByString:@", "];
               // }

                
                
                movieRuntime=[Decrypt valForHDIKey:kMovieRuntime inDict:obj decryptDict:aReq.decryptDict];
                
                movieGenre=[Decrypt valForHDIKey:kMovieGenre inDict:obj decryptDict:aReq.decryptDict];
                //anArray=[Decrypt arrFromDecryptDictForKey:kMovieGenre inDict:obj decryptDict:aReq.decryptDict];
                //if ([anArray count]) {
                //    movieGenre = [anArray componentsJoinedByString:@", "];
                //}
                
            
                movieDirector=[Decrypt valForHDIKey:kMovieDirector inDict:obj decryptDict:aReq.decryptDict];
                //anArray=[Decrypt arrFromDecryptDictForKey:kMovieDirector inDict:obj decryptDict:aReq.decryptDict];
               // if ([anArray count]) {
               //     movieDirector = [anArray componentsJoinedByString:@", "];
               // }

                
                movieWriter=[Decrypt valForHDIKey:kMovieWriter inDict:obj decryptDict:aReq.decryptDict];
                movieActors=[Decrypt valForHDIKey:kMovieActors inDict:obj decryptDict:aReq.decryptDict];
               // anArray=[Decrypt arrFromDecryptDictForKey:kMovieActors inDict:obj decryptDict:aReq.decryptDict];
               // if ([anArray count]) {
               //     movieActors = [anArray componentsJoinedByString:@", "];
               // }

                movieShortPlot=[Decrypt valForHDIKey:kMovieShortDescr inDict:obj decryptDict:aReq.decryptDict];
                moviePlot=[Decrypt valForHDIKey:kMoviePlot inDict:obj decryptDict:aReq.decryptDict];
                movieShowTimes=[Decrypt valForHDIKey:kMovieShowTimes inDict:obj decryptDict:aReq.decryptDict];
                movieAdvisories=[Decrypt valForHDIKey:kMovieAdvisories inDict:obj decryptDict:aReq.decryptDict];
               // anArray=[Decrypt arrFromDecryptDictForKey:kMovieAdvisories inDict:obj decryptDict:aReq.decryptDict];
               // if ([anArray count]) {
               //     movieAdvisories = [anArray componentsJoinedByString:@", "];
               // }

                NSLog(@"");
                
                
                tmpNewHDIdict=[[NSMutableDictionary alloc]init];    //Create new dict using HDI keys; this supports HDI screens
                if (movieTitle) {   [tmpNewHDIdict setObject:movieTitle forKey:kMovieTitle];   }
                if (movieID){  [tmpNewHDIdict setObject:movieID    forKey:kMovieID  ];}
                if (movieReleased){ [tmpNewHDIdict setObject:movieReleased   forKey:kMovieReleased  ];}
                if (movieYear){ [tmpNewHDIdict setObject:movieYear   forKey:kMovieYear  ];}
                if (movieRated){ [tmpNewHDIdict setObject:movieRated forKey:kMovieRated  ];}
                if (movieRuntime){ [tmpNewHDIdict setObject:movieRuntime    forKey: kMovieRuntime ];}
                if (movieGenre){ [tmpNewHDIdict setObject:movieGenre forKey: kMovieGenre ];}
                if (movieDirector){ [tmpNewHDIdict setObject:movieDirector   forKey: kMovieDirector ];}
                if (movieWriter){ [tmpNewHDIdict setObject:movieWriter     forKey:  kMovieWriter ];}
                if (movieActors){ [tmpNewHDIdict setObject:movieActors     forKey: kMovieActors  ];}
                if (moviePlot){ [tmpNewHDIdict setObject:moviePlot  forKey: kMoviePlot ];}
                if (movieShortPlot){ [tmpNewHDIdict setObject:moviePlot  forKey: kMovieShortDescr ];}
                if (movieAdvisories){ [tmpNewHDIdict setObject:movieAdvisories forKey: kMovieAdvisories ];}
                [tmpNewHDIdict setObject:reqUniqueKey forKey:kMovieUniqueKey];
                [allProductDefinitions_HDI setObject:tmpNewHDIdict forKey:reqUniqueKey];
                
                
                
                
                
                //******decrypt and flatten for storing in dictionary with HDI keys in allProductInventory_HDI
                tmpNewShowArray=[[NSMutableArray alloc]init];    //Create new dict using HDI keys; this supports HDI screens
                
                /* movieShowTimes	__NSArrayM *	@"334 objects"	0x00007fb35c84b070
                 [0]	__NSDictionaryM *	4 key/value pairs	0x00007fb35c84b670
                 [0]	(null)	@"barg" : @"0"
                 [1]	(null)	@"dateTime" : @"2016-08-05T12:45"
                 [2]	(null)	@"ticketURI" : @"http://www.fandango.com/tms.asp?t=AABED&m=160662&d=2016-08-05"
                 [3]	(null)	@"theatre" : 2 key/value pairs
                 key	NSTaggedPointerString *	@"theatre"	0xa657274616568747
                 value	__NSDictionaryM *	2 key/value pairs	0x00007fb35c84b5b0
                 [0]	(null)	@"id" : @"6409"
                 [1]	(null)	@"name" : @"Studio Movie Grill Plano"
                 */
                /*
                 #define kMovieTicketBuyPath @"TicketBuyPath"
                 #define kMovieShowDateTime @"ShowDateTime"
                 #define kMovieAdvisories @"Advisories"
                 #define kMovieTheaterName @"TheaterName"
                 #define kMovieTheaterID @"TheaterID"
                 #define kShowBarg @"ShowBarg"
                 #define kShowQuals @"ShowQuals"
                 movieShowTimes is an array of dictionaries..... have to turn into an array of dictionaries using our format
                 */
                
                for (NSMutableDictionary *showobj in shows){
                    tmpNewShowDict=[[NSMutableDictionary alloc]init];
                    
                    showDateAndTime=[showobj objectForKey:@"dateTime"];
                    showPurchaseLink=[showobj objectForKey:@"ticketURI"];
                    NSMutableDictionary *someD=[showobj objectForKey:@"theatre"];
                    
                    showTheaterID=[someD objectForKey:@"id"];//[showobj objectForKey:@"theatre.id"];
                    showTheaterName=[someD objectForKey:@"name"];//[showobj objectForKey:@"theater.theater.name"];
                    showBarg=[showobj objectForKey:@"barg"];
                    showQual=[showobj objectForKey:@"quals"];
                    if (showDateAndTime){ [tmpNewShowDict setObject:showDateAndTime forKey:kMovieShowDateTime];}
                    if (showPurchaseLink){ [tmpNewShowDict setObject:showPurchaseLink forKey:kMovieTicketBuyPath];}
                    if (showTheaterID){
                        [tmpNewShowDict setObject:showTheaterID forKey:kMovieTheaterID];
                    }
                    if (showTheaterName){
                        [tmpNewShowDict setObject:showTheaterName forKey: kMovieTheaterName];
                    }
                    if (showBarg) {
                        [tmpNewShowDict setObject:showBarg forKey:kShowBarg];
                    }
                    if (showQual) {
                        [tmpNewShowDict setObject: showQual forKey:kShowQuals];
                    }
                    [tmpNewShowArray addObject: tmpNewShowDict];   //build array of shows using our key/value stuff
                    
                }
                
                [allProductInventory_HDI setObject:tmpNewShowArray forKey:reqUniqueKey];
                
                NSLog(@"");
 

        }
    }//end FOR

    
    
    NSLog(@"");
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self buildMovieDownloadImageArrayNames];

    
    
}




-(void)buildMovieDownloadImageArrayNames
{
    //So movieNameArray has names of ALL movies we need images for.
    //our DISK storeage might already have the pictures.  So we have to determine what to download (minimize time)
    
    if (movieNamesForImageDownloads) {
        [movieNamesForImageDownloads removeAllObjects];
    }
    if (![movieImageDictionary count]) {
        movieNamesForImageDownloads= [movieNameArray mutableCopy];
        return;
    }
    
    if(![movieNameArray count]){
        return;
    }
        
    //ok process list
    NSLog(@"");
    NSString *thisMName;
    
    
    for (id obj in movieNameArray) {   //array of strings
        thisMName=obj;
        
        if (![movieImageDictionary objectForKey:thisMName]) {
            [movieNamesForImageDownloads addObject:thisMName];
        }
        
        
    }
    
    
}




-(NSMutableDictionary*) postTVC1:(ActionRequest*)aQueryResults
{//from transaction
    
    //QUESTION - does the absence of a key in the dictionary return nil?
 /*   NSMutableDictionary *decoderDptr =[[NSMutableDictionary alloc]init];
    [decoderDptr setObject:@"0.1" forKey:kDECRYPT_Note_REVKEY];
    [decoderDptr setObject:@"name" forKey:kLocationNameKey];
    [decoderDptr setObject:@"location.address.street" forKey:kLocationAddressKey];
    [decoderDptr setObject:@"location.address.city" forKey:kLocationCityKey];
    [decoderDptr setObject:@"location.address.state" forKey:kLocationStateKey];
    [decoderDptr setObject:@"location.address.postalCode" forKey:kLocationZipKey];
    [decoderDptr setObject:@"" forKey:kLocationDate];   //can't be nil
    [decoderDptr setObject:@"theatreId" forKey:kLocationIDKey];
    [decoderDptr setObject:@"country" forKey:kLocationCountry];
    
    NSString *missingKey = [decoderDptr valueForKey:@"MISSINGKEY"];   //this has the value of nil
   */
    
    
    if (!allLocationsHDI){
        allLocationsHDI = [[NSMutableDictionary alloc] init];
    }
    else{
        [allLocationsHDI removeAllObjects];
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"MM/dd"];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
    NSString *todayDateString = [dateFormatter stringFromDate:today];
    NSMutableDictionary *aLocDict;
    int i=0;
    
    
    
    for (NSMutableDictionary *aRecord in aQueryResults.retRecordsAsDPtrs)
    {
        i ++;
        aLocDict = [[NSMutableDictionary alloc] init];
        NSString *locationDate = todayDateString;
        //NSString *locationName = [aRecord objectForKey:@"name"];
        
         NSString *locationName=[Decrypt valForHDIKey:kLocationNameKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
        
        //NSString *locationID=[aRecord objectForKey:@"theatreId"];
        NSString *locationID=[Decrypt valForHDIKey:kLocationIDKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
        //defaults
        //NSString *locationStreetAddress = [NSString stringWithFormat:@"Theater Address %i",i];
        NSString *locationStreetAddress = [Decrypt valForHDIKey:kLocationAddressKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
       // NSString *locationCity = [NSString stringWithFormat:@"Theater City %i",i];
         NSString *locationCity = [Decrypt valForHDIKey:kLocationCityKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
       // NSString *locationState = [NSString stringWithFormat:@"Theater State %i",i];
        NSString *locationState = [Decrypt valForHDIKey:kLocationStateKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
       // NSString *locationZip = [NSString stringWithFormat:@"Theater Zip %i",i];
        NSString *locationZip = [Decrypt valForHDIKey:kLocationZipKey inDict:aRecord decryptDict:aQueryResults.decryptDict];
        NSString *locationCountry = [NSString stringWithFormat:@"USA"];
        
        //HOW TO HANDLE VALUES WE HAVE TO STUFF - add this to decrypt logic like when nil return this....
      //  NSString *locationCountry =  [Decrypt valForHDIKey:kLocationCountry inDict:aRecord decryptDict:aQueryResults.decryptDict];
        
        // containerAddrDict=[aRecord objectForKey:@"location"];
       // locationStreetAddress=[aRecord valueForKeyPath:@"location.address.street"];
       // locationCity=[aRecord valueForKeyPath:@"location.address.city"];
       // locationState = [aRecord valueForKeyPath:@"location.address.state"];
       // locationZip = [aRecord valueForKeyPath:@"location.address.postalCode"];
       // locationCountry = [aRecord valueForKeyPath:@"location.address.country"];
        
        
        
        [aLocDict setObject:locationName forKey:kLocationNameKey];
        [aLocDict setObject:locationStreetAddress forKey:kLocationAddressKey];
        [aLocDict setObject:locationCity forKey:kLocationCityKey];
        [aLocDict setObject:locationState forKey:kLocationStateKey];
        [aLocDict setObject:locationZip forKey:kLocationZipKey];
        [aLocDict setObject:locationDate forKey:kLocationDate];
        [aLocDict setObject:locationID forKey:kLocationIDKey];
        [aLocDict setObject:locationCountry forKey:kLocationCountry];
        
        
        //[allLocationsHDI setObject:aLocDict forKey:[aLocDict objectForKey:kLocationNameKey]];
         [allLocationsHDI setObject:aLocDict forKey:locationName];
        
        
    }
    
    NSLog(@"there are %d dictionaries (total locations)",i);
    NSLog(@"");
    
    
    
    
    return allLocationsHDI;
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark STARTUP METHODS-MAY CHANGE WITH DB PROCESSING TEMPLATES
/////////////////////////////////////////

-(void)initLocationsDB:(ActionRequest *)initReq //withDictionary:(NSMutableDictionary *)testDictionary andRecordKeys:(NSArray *)recordKeys
{

    Transaction *dbTransaction = nil;
    NSString * dictionaryKey= @"InitDB";
 //   LocationRecord *aLocation;
    NSMutableDictionary *aLocDict;

    if (!initializingLocDB){
       [self buildLocationsDictionary:10];
       
        initDBRecordKeyIndex = 0;//  Delete All Locations Records
        dbTransaction = [[Transaction alloc]initWithQTitle:@"InitDB" andQDescr:@"Stuff DB with Data" andNumber:0];
        dbTransaction.URL=@"http://97.77.211.34/~Dwain/locations";
 //       dbTransaction.URL=@"http://localhost/~DanHammond/locations";
//        dbTransaction.URL=@"http://localhost/~myra/locations";
        initializingLocDB = YES;
        initReq.errorDisplayText=@"initDB";
        [activeTableDataPtr.dbAllTabTransDict setObject:dbTransaction forKey:dictionaryKey];
        
//        [activeTableDataPtr.tableVariablesArray removeAllObjects];
        TransactionData *tranCodeData=[[TransactionData alloc]init];
        tranCodeData.queryKey=TranCodeKey;
        tranCodeData.userDefinedData= TranCodeDeleteAll;
        [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
        initReq.arrayIndex=0;
        initReq.loopDictPtr=nil;
        [dbTransaction beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:initReq usingDataArray:activeTableDataPtr.tableVariablesArray];
//       [self initDBTransaction:initReq];
        return;
    }
    NSArray* allLocationKeys = [[allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];
    if (initDBRecordKeyIndex >=allLocationKeys.count){
            initializingLocDB = NO;
        
            if (gGTPptr.debugFlag) {
                return; //no automated button pushing needed for movieInfo
            }
        
        //THIS IS WHEN IT IS DONE....NEEDS BETTER WAY OF HANDLEING THIS
            initReq.buttonName=@"MovieInfo";
            [self evaluateAction:initReq];
            return;
    }
    
     dbTransaction = [[Transaction alloc]initWithQTitle:@"InitLocationsDB" andQDescr:@"Stuff DB with Data" andNumber:0];
    //            dbTrans.URL=@"http://97.77.211.34/~Dwain/TABLEproto/indexTEST";
     dbTransaction.URL=@"http://97.77.211.34/~Dwain/locations";
    initReq.errorDisplayText=@"initDB";
//    dbTransaction.URL=@"http://localhost/~myra/locations";
//    dbTransaction.URL=@"http://localhost/~DanHammond/locations";
   
//    [activeTableDataPtr.dbAllTabTransDict removeAllObjects];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTransaction forKey:dictionaryKey];// startUpTVCKey]
    
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    
    TransactionData *tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeAddRecord;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
   
/*
   
    NSString *aLocationKey = [allLocationKeys objectAtIndex:initDBRecordKeyIndex];

    aLocation = [allLocationsHDI objectForKey:aLocationKey];
    
    TransactionData *dataField0=[[TransactionData alloc]init];
    dataField0.queryKey=@"LocationName";
    dataField0.userDefinedData = [al] aLocation.locationName;
    [activeTableDataPtr.tableVariablesArray addObject:dataField0];
    
    TransactionData *dataField1=[[TransactionData alloc]init];
    dataField1.queryKey=@"LocationStreetAddress";
    dataField1.userDefinedData=aLocation.locationStreetAddress;
    [activeTableDataPtr.tableVariablesArray addObject: dataField1];
    
    TransactionData *dataField2=[[TransactionData alloc]init];
    dataField2.queryKey=@"LocationCity";
    dataField2.userDefinedData=aLocation.locationCity;
    [activeTableDataPtr.tableVariablesArray addObject: dataField2];
    
    TransactionData *dataField3=[[TransactionData alloc]init];
    dataField3.queryKey=@"LocationState";
    dataField3.userDefinedData=aLocation.locationState;
    [activeTableDataPtr.tableVariablesArray addObject: dataField3];
    
    
    TransactionData *dataField4=[[TransactionData alloc]init];
    dataField4.queryKey=@"LocationZip";
    dataField4.userDefinedData=aLocation.locationZip;
    [activeTableDataPtr.tableVariablesArray addObject: dataField4];
    
    TransactionData *dataField5=[[TransactionData alloc]init];
    dataField5.queryKey=@"LocationDate";
    dataField5.userDefinedData=aLocation.locationDate;
    [activeTableDataPtr.tableVariablesArray addObject: dataField5];
 
    TransactionData *dataField6=[[TransactionData alloc]init];
    dataField6.queryKey=@"LocationProduct";
    dataField6.userDefinedData=@"Delete This Field";
    [activeTableDataPtr.tableVariablesArray addObject: dataField6];
*/
    NSString *aLocationKey = [allLocationKeys objectAtIndex:initDBRecordKeyIndex];
    aLocDict = [allLocationsHDI objectForKey:aLocationKey];
    
    TransactionData *dataField0=[[TransactionData alloc]init];
    dataField0.queryKey=@"LocationName";
    dataField0.userDefinedData = [aLocDict objectForKey:kLocationNameKey];
    [activeTableDataPtr.tableVariablesArray addObject:dataField0];
    
    TransactionData *dataField1=[[TransactionData alloc]init];
    dataField1.queryKey=@"LocationStreetAddress";
    dataField1.userDefinedData=[aLocDict objectForKey:kLocationAddressKey];// aLocation.locationStreetAddress;
    [activeTableDataPtr.tableVariablesArray addObject: dataField1];
    
    TransactionData *dataField2=[[TransactionData alloc]init];
    dataField2.queryKey=@"LocationCity";
    dataField2.userDefinedData=[aLocDict objectForKey:kLocationCityKey];//aLocation.locationCity;
    [activeTableDataPtr.tableVariablesArray addObject: dataField2];
    
    TransactionData *dataField3=[[TransactionData alloc]init];
    dataField3.queryKey=@"LocationState";
    dataField3.userDefinedData=[aLocDict objectForKey:kLocationStateKey];// aLocation.locationState;
    [activeTableDataPtr.tableVariablesArray addObject: dataField3];
    
    
    TransactionData *dataField4=[[TransactionData alloc]init];
    dataField4.queryKey=@"LocationZip";
    dataField4.userDefinedData= [aLocDict objectForKey:kLocationZipKey];//aLocation.locationZip;
    [activeTableDataPtr.tableVariablesArray addObject: dataField4];
    
    TransactionData *dataField5=[[TransactionData alloc]init];
    dataField5.queryKey=@"LocationDate";
    dataField5.userDefinedData=[aLocDict objectForKey:kLocationDate];// aLocation.locationDate;
    [activeTableDataPtr.tableVariablesArray addObject: dataField5];
    
    TransactionData *dataField6=[[TransactionData alloc]init];
    dataField6.queryKey=@"LocationProduct";
    dataField6.userDefinedData=@"Delete This Field";
    [activeTableDataPtr.tableVariablesArray addObject: dataField6];
    initReq.arrayIndex=0;
   initReq.loopDictPtr=nil;
    
    [dbTransaction beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:initReq usingDataArray:activeTableDataPtr.tableVariablesArray];
    initDBRecordKeyIndex++;
 
    }

-(void)initInventoryDB:(ActionRequest *)initReq 
{
    Transaction *dbTransaction = nil;
    NSString * dictionaryKey= @"InitDB";
//    LocationRecord *aLocation;
//    ProductRecord *aProduct;
 //   NSMutableArray *testProductArray;
    
    if (!initializingInvDB){
        allLocationsHDI = [self buildLocationsDictionary:10];
        testProductArray = [self buildProductArray:movieNameArray];
       
        initDBRecordKeyIndex = 0;//  Delete All Locations Records
        dbTransaction = [[Transaction alloc]initWithQTitle:@"InitInventoryDB" andQDescr:@"Stuff DB with Data" andNumber:0];
        dbTransaction.URL=@"http://97.77.211.34/~Dwain/inventory";
        initReq.errorDisplayText=@"initInventoryDB";
 //       dbTransaction.URL=@"http://localhost/~DanHammond/inventory";
        //        dbTransaction.URL=@"http://localhost/~myra/locations";
        initializingInvDB = YES;
        
        [activeTableDataPtr.dbAllTabTransDict setObject:dbTransaction forKey:dictionaryKey];
        
        //        [activeTableDataPtr.tableVariablesArray removeAllObjects];
        TransactionData *tranCodeData=[[TransactionData alloc]init];
        tranCodeData.queryKey=TranCodeKey;
        tranCodeData.userDefinedData= TranCodeDeleteAll;
        [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
        initReq.arrayIndex=0;
        initReq.loopDictPtr=nil;
        [dbTransaction beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:initReq usingDataArray:activeTableDataPtr.tableVariablesArray];
 //       [self initDBTransaction:initReq];
        return;
    }
    
    if (initDBRecordKeyIndex >=testProductArray.count){
        initializingInvDB = NO;
        return;
    }
    
    dbTransaction = [[Transaction alloc]initWithQTitle:@"InitDB" andQDescr:@"Stuff DB with Data" andNumber:0];
    //            dbTrans.URL=@"http://97.77.211.34/~Dwain/TABLEproto/indexTEST";
    //    NSURL *url =  @"http://localhost/~DanHammond/initdb";
    dbTransaction.URL=@"http://97.77.211.34/~Dwain/inventory";
    initReq.errorDisplayText=@"initInventoryDB2";
    //    dbTransaction.URL=@"http://localhost/~myra/locations";
 //       dbTransaction.URL=@"http://localhost/~DanHammond/inventory";
 
    //    [activeTableDataPtr.dbAllTabTransDict removeAllObjects];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTransaction forKey:dictionaryKey];// startUpTVCKey]
    
    [activeTableDataPtr.tableVariablesArray removeAllObjects];
    
    TransactionData *tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeAddRecord;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    
    
 //   NSString *aProductKey = [testProductKeys objectAtIndex:initDBRecordKeyIndex];
 //   aProduct = [testProductDictionary objectForKey:aProductKey];
    NSMutableDictionary *aProductDict = [testProductArray objectAtIndex:initDBRecordKeyIndex];
    TransactionData *dataField0=[[TransactionData alloc]init];
    dataField0.queryKey= kProductNameKey;// @"ProductName";
    dataField0.userDefinedData = [aProductDict objectForKey:kProductNameKey];// aProduct.productName;
    [activeTableDataPtr.tableVariablesArray addObject:dataField0];
    
    TransactionData *dataField1=[[TransactionData alloc]init];
    dataField1.queryKey=kProductIDKey;// @"ProductID";
    dataField1.userDefinedData= [NSString stringWithFormat:@"%li",(long)initDBRecordKeyIndex];
    [activeTableDataPtr.tableVariablesArray addObject: dataField1];
    
    TransactionData *dataField2=[[TransactionData alloc]init];
    dataField2.queryKey=kLocationNameKey;// @"LocationName";
    dataField2.userDefinedData=[aProductDict objectForKey:kLocationNameKey];//  aProduct.locationName;
    [activeTableDataPtr.tableVariablesArray addObject: dataField2];
    
    TransactionData *dataField3=[[TransactionData alloc]init];
    dataField3.queryKey=kLocationZipKey;// @"LocationZip";
    dataField3.userDefinedData=[aProductDict objectForKey:kLocationZipKey];// aProduct.locationZip;
    [activeTableDataPtr.tableVariablesArray addObject: dataField3];
    
    
    TransactionData *dataField4=[[TransactionData alloc]init];
    dataField4.queryKey=kLocationDate;// @"LocationDate";
    dataField4.userDefinedData=[aProductDict objectForKey:kLocationDate];// aProduct.locationDate;// aProduct.implodedDates;
    [activeTableDataPtr.tableVariablesArray addObject: dataField4];
/*
    TransactionData *dataField5=[[TransactionData alloc]init];
    dataField5.queryKey=nil;// kProductImplodedTimesKey;// @"ProductTimes";
    dataField5.userDefinedData= [aProductDict objectForKey:kProductImplodedTimesKey];// aProduct.implodedTimes;// aProduct.implodedDates;
    [activeTableDataPtr.tableVariablesArray addObject: dataField5];
    initReq.arrayIndex=0;
    initReq.loopDictPtr=nil;
    [dbTransaction beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:initReq usingDataArray:activeTableDataPtr.tableVariablesArray];
    initDBRecordKeyIndex++;
 */
}
-(void) xactFetchallMovieInfoOMDBRequest:(ActionRequest *)aReq   //new....   DOES THE XACTION
{
    Transaction *dbTrans = nil;
    
    
    
    
    
    
    aReq.transactionKey =  TranCodeAllInv;
    aReq.buttonName=@"MovieInfo";
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"OMBD Query" andQDescr:@"Movie Informatiion" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/omdbTest";
    aReq.errorDisplayText=@"movie information xactfetchallmovieinfo...";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= @"MovieName";
    tranCodeData.userDefinedData= [movieNameArray objectAtIndex:0]; //doesn't matter cause only one key,value pair in here
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    [dbTrans loopingTransactionOnView:self.rtTableViewCtrler.view actionReq:aReq usingSendDataArray:activeTableDataPtr.tableVariablesArray  loopingKey:@"MovieName" loopArrData:movieNameArray retDictWithLoopArrrDataKey:allMovieInfoOMDB storingKeyArray:movieNameArray];
    
    
  
}


-(void)fetchallMovieInfoOMDB:(ActionRequest *)aQuery   //called when debug flag is set?
{
    NSLog(@"\n\r fetchallMovieInfoOMDB \n\r");
    Transaction *dbTrans = nil;
    if(!fetchingMovieInfo){
        fetchingMovieInfo = YES;
        initDBRecordKeyIndex = 0;
        [allMovieInfoOMDB removeAllObjects];
        
    }
    
    
    if (initDBRecordKeyIndex >= movieNameArray.count){
        fetchingMovieInfo = NO;
        
        //myra add call to cache all poster images for allMoviesArray keys to allMovieInfoOMDB Dictioary
        
        //Eventually move this to imageCacheManager class
        
        NSString *mName;
        NSString *mPath;
        BOOL downloadDone=false;
        int downloadKeyCtr=0;
        NSMutableDictionary *thisDictPtr;
        if ([movieNameArray count]) {
            downloadKeyCtr=0;
        }
        else {
            downloadDone=TRUE;
        }
        
        
        UIImage *itImage;
        while (!downloadDone) {
            mName=[movieNameArray objectAtIndex:downloadKeyCtr];
            thisDictPtr=[allMovieInfoOMDB objectForKey:mName];
            mPath=[thisDictPtr objectForKey:@"Poster"];
            if (mPath) {
                NSLog(@" Qfetch %@ at \n %@",mName,mPath);
                itImage=[self downloadSyncImageWithURL:[NSURL URLWithString:mPath] forKey:mName];
                
                [movieImageDictionary setObject:itImage forKey:mName];
                NSLog(@"Image Download Succeeded");
            }
            else{
                NSLog(@"NOfetch2 %@ at \n %@",mName,mPath);
            }
            downloadKeyCtr++;
            if (downloadKeyCtr >= [movieNameArray count]) {
                downloadDone=TRUE;
            }
        }//end while
        
        
        if (gGTPptr.debugFlag) {
            return; // no button automation array execution
        }
        //NOW NEED TO SWITCH TO BUTTON MODE, THIS WAS ALL OF AUTOMATIC STUFF?
        self.queryMode=kUSERBUTTON;
        aQuery.nextTableView=TVC2;
        aQuery.buttonName=nil;
        [self defineTransactionsTVC2:aQuery];
        [self evaluateAction:aQuery];
        return; //AM I DONE HERE????
    }
    
    
    aQuery.transactionKey =  TranCodeAllInv;
    TransactionData* tranCodeData;
    dbTrans = [[Transaction alloc]initWithQTitle:@"OMBD Query" andQDescr:@"Movie Informatiion" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/omdbTest";
    aQuery.errorDisplayText=@"movie information fetchAllMovieInfo";
    //dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey= @"MovieName";
    tranCodeData.userDefinedData= [movieNameArray objectAtIndex:initDBRecordKeyIndex];
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    aQuery.arrayIndex=0;
    aQuery.loopDictPtr=nil;
    [dbTrans beginTransactionViewActive:self.rtTableViewCtrler.view carryAlongDummyData:aQuery usingDataArray:activeTableDataPtr.tableVariablesArray];
    initDBRecordKeyIndex++;
}
-(void) fakeButtonPressTV2
{
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    Transaction *dbTrans;
    ActionRequest *pressedBtn = nil;
    
    pressedBtn.transactionKey =  TranCodeAllInv;
    
    pressedBtn.transactionKey =  TranCodeAllInv;
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    pressedBtn.errorDisplayText=@"fake button press tv2";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeQueryLocation;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey=QueryLocationName;
    
  //  tranCodeData1.userDefinedData = [pressedBtn.dataBaseDict objectForKey:@"LocationName"];
  
    NSMutableDictionary *aProductDict = pressedBtn.productDict;// [self.gGTPptr fetchProductDict:pressedBtn];
    tranCodeData1.userDefinedData = [aProductDict objectForKey:kLocationNameKey];

//    tranCodeData1.userDefinedData = [pressedBtn.aProductDict objectForKey:kLocationNameKey];
    tranCodeData1.userDefinedData = @"Theater Name 000";
    
    //              aLocation =   [allLocationsHDI objectForKey:pressedBtn.dataRecordKey];
    //              tranCodeData1.userDefinedData= aLocation.locationName;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
}

- (void)downloadImageWithURL:(NSURL *)url  forKey:(NSString*)thisKey completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
    NSLog(@"downloadImageWithURL started");
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                                   NSLog(@"completion block Success");
                               } else{
                                   completionBlock(NO,nil);
                                   NSLog(@"completion block Error");
                               }
                           }];
}

- (UIImage*)downloadSyncImageWithURL:(NSURL *)url  forKey:(NSString*)thisKey
{
    
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    UIImage *image=nil;
    NSLog(@"Firing synchronous url connection...");
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if ([data length] > 0 &&         error == nil){
        NSLog(@"%lu bytes of data was returned.",[data length]);
              image = [[UIImage alloc] initWithData:data];
    }
    
    return image;
    
    
    

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark DISPLAY HELPER Methods
/////////////////////////////////////////
-(void)prepareTheActiveTableDataForDisplay:(ActionRequest *)pressedBtn
{
    if (pressedBtn){
    
        
    }
    //make sure cells alloc/initialized properly.... has to be done first time through? maybe can be done when data populated
    // this is mainly for uitablecell allocation
    if (activeTableDataPtr.cellDispPrepared) {
        return;
    }
    
    //this should change - it does globals now
    //getting ready for first table display by loading data
    
    
    //UITableViewCell *cell ;
    CustomTVCell *cell;
    
    CellContentDef *ccontentDefPtr;
    SectionDef *sectionPtr;
    
    
    
  //////  tableSections=self..tableSections;   //muteable array
    
    
    
    for (int i=0; i< [activeTableDataPtr.tableSections count]; i++) {
        sectionPtr=[activeTableDataPtr.tableSections objectAtIndex:i];
        
        for (int c=0;c< [sectionPtr.sCellsContentDefArr count]; c++) {
            ccontentDefPtr=[sectionPtr.sCellsContentDefArr objectAtIndex:c];
            // cPtr=[[UITableViewCell alloc] init];
            // cPtr=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idme"];
            //  cPtr=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idme"];
            // cPtr=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            
            //NOT  ccontentDefPtr.ccTableViewCellPtr=nil;  //cPtr;   initialize when asked and dequeue returns nil
            
            
            // cell=[[UITableViewCell alloc] init];
           //works ish  cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellme"];
           // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellme"];
           // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cellme"];
            
            // cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellme"];
             cell=[[CustomTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellme"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            ccontentDefPtr.ccTableViewCellPtr=cell;   //don't initialize cell text here
            
        }
        
    }
    activeTableDataPtr.cellDispPrepared=TRUE;   //only do this once for this table
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Data Base TRANSACTIONS Methods
/////////////////////////////////////////

-(void)defineMovieTrailerQuery:(ActionRequest*)pressedBtn
{
    //    TransactionData *tranCodeData;
    Transaction *dbTrans;
    
    pressedBtn.transactionKey = QueryMovieYouTubeTrailers;// @"MovieTrailerQuery";
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Movie Trailer Query" andQDescr:@"Trailer List" andNumber:0];
    pressedBtn.errorDisplayText=@"Movie Trailer Query";
    // dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
 //   dbTrans.URL = @"http://trailersapi.com/trailers.json?movie=Finding%20Dory&limit=5&width=320";
//     dbTrans.URL = @"http://trailersapi.com/trailers.json?movie=The%20Dark%20Knight%20Rises&limit=5&width=320";
  //  dbTrans.URL = @"http://data.tmsapi.com/v1.1/screenplayTrailers?rootids=8919177&trailersonly=1&player_url=0&api_key=jeght694vej75fr6xm4eqp7y";
        dbTrans.URL = @"http://trailersapi.com/trailers.json?movie=The%20Dark%20Knight%20Rises&limit=5&width=320";
    if (self.gGTPptr.inAVPlayerVC){
                        // Finding Dory
        dbTrans.URL =@"http://data.tmsapi.com/v1.1/screenplayTrailers?rootids=12329215&bitrateids=457&trailersonly=1&player_url=0&api_key=jeght694vej75fr6xm4eqp7y";
        }
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:pressedBtn.transactionKey];
}


-(void) defineTransactionsTVC1:(ActionRequest *)pressedBtn
{
    TransactionData *tranCodeData;
    
    Transaction *dbTrans;
    
    pressedBtn.transactionKey =  TranCodeAllLocs;
    pressedBtn.buttonName = @"Theater List";
    //      if ([pressedBtn.transactionKey isEqualToString:TranCodeAllLocs]){
    dbTrans = [[Transaction alloc]initWithQTitle:@"Locations" andQDescr:@"LocationsList" andNumber:0];
    //OLD dbTrans.URL=@"http://97.77.211.34/~Dwain/locations";
    dbTrans.URL=@"http://97.77.211.34/~Dwain/tmsapiTest";
    //           dbTrans.URL=@"http://localhost/~DanHammond/locations";
    //           dbTrans.URL=@"http://localhost/~myra/locations";
    pressedBtn.errorDisplayText=@"Locations List TVC1";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
 //OLD   tranCodeData.userDefinedData= TranCodeAllLocs;
    tranCodeData.userDefinedData= TranCodeLocForZip;//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];

    tranCodeData=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData.queryKey=ZipCodeKey;//NEW
    tranCodeData.userDefinedData=gGTPptr.globalZipCode;// @"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];//NEW

    
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllLocs];// startUpTVCKey];
    

}
-(void) defineTransactionsTVC2:(ActionRequest *)pressedBtn
{
 //   NSLog(@"do fake db xaction");
//    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
//    return;

    
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    Transaction *dbTrans;
 
    pressedBtn.transactionKey =  TranCodeAllInv;
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    pressedBtn.errorDisplayText=@"Inventory List TVC2";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    //OLD   tranCodeData.userDefinedData= TranCodeAllLocs;
    tranCodeData.userDefinedData= TranCodeAllInv;//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    tranCodeData1=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData1.queryKey=ZipCodeKey;//NEW
    tranCodeData1.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];//NEW
    

    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    
    
    
}
-(void) defineTransactionsTVC3:(ActionRequest *)pressedBtn
{
//    NSLog(@"do fake db xaction");
//    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:pressedBtn];
//    return;
    
    
    
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    Transaction *dbTrans;
 
    pressedBtn.transactionKey =  TranCodeAllInv;
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    NSLog(@"!!!!!!!! URL specifics set to localhost as: /~myra");
    pressedBtn.errorDisplayText=@"Inventory list TVC3";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    //OLD   tranCodeData.userDefinedData= TranCodeAllLocs;
    tranCodeData.userDefinedData= TranCodeAllInv;//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    
    tranCodeData1=[[TransactionData alloc]init];    //NEW for passing ZIP
    tranCodeData1.queryKey=ZipCodeKey;//NEW
    tranCodeData1.userDefinedData= gGTPptr.globalZipCode;//@"75248";//NEW
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];//NEW
    

    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
}

-(void) defineTransactionsTVC4:(ActionRequest *)pressedBtn
{
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    TransactionData *tranCodeData2;
    Transaction *dbTrans;
   // NSMutableDictionary *aLocDict;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
    NSString *todayDateString = [dateFormatter stringFromDate:today];

    //               if (testProductDictionary){
    pressedBtn.transactionKey =  TranCodeAllInv;
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
    pressedBtn.errorDisplayText=@"Inventory List TVC4";
    tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeQueryLocation;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey= QueryLocationName;
//    aLocDict = [self.gGTPptr fetchLocationDict:pressedBtn];
    tranCodeData1.userDefinedData = [pressedBtn.locDict objectForKey:kLocationIDKey] ;// [aLocDict objectForKey:kLocationIDKey];// @"theatreId"];// @"LocationName"];
//    tranCodeData1.userDefinedData = [aLocDict objectForKey:@"LocationName"];
//    tranCodeData1.userDefinedData = [aLocDict objectForKey:@"name"];
                                     
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];
    
    tranCodeData2 = [[TransactionData alloc] init];
    
    tranCodeData2.queryKey = kLocationDate;
    
    if (pressedBtn.buttonArrayPtr.count){
        todayDateString = pressedBtn.buttonName;
    }
    
    tranCodeData2.userDefinedData = todayDateString;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData2];
    
    
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];
    

}
-(void) defineTransactionsTVC10:(ActionRequest *)pressedBtn
{
    TransactionData *tranCodeData;
    TransactionData *tranCodeData1;
    TransactionData *tranCodeData2;
    Transaction *dbTrans;
   // NSMutableDictionary *aProductDict;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
    NSString *todayDateString = [dateFormatter stringFromDate:today];

    pressedBtn.transactionKey =  TranCodeAllInv;
    
    dbTrans = [[Transaction alloc]initWithQTitle:@"Inventory" andQDescr:@"InventoryList" andNumber:0];
    dbTrans.URL=@"http://97.77.211.34/~Dwain/inventory";
    pressedBtn.errorDisplayText=@"inventory list tvc10";
    //        dbTrans.URL=@"http://localhost/~DanHammond/inventory";
    //           dbTrans.URL=@"http://localhost/~myra/inventory";
        tranCodeData=[[TransactionData alloc]init];
    tranCodeData.queryKey=TranCodeKey;
    tranCodeData.userDefinedData= TranCodeQueryProduct;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData];
    tranCodeData1=[[TransactionData alloc]init];
    tranCodeData1.queryKey=QueryProductName;
    //                tranCodeData1.userDefinedData=pressedBtn.aProduct.productName;  // I removed leading space in Product
//    aProductDict =  [self.gGTPptr fetchProductDict:pressedBtn];
    tranCodeData1.userDefinedData = [pressedBtn.productDict objectForKey:kProductNameKey];// [aProductDict objectForKey:@"ProductName"];  //**** tran codes still have leading space in dictionary
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData1];
    
    tranCodeData2 = [[TransactionData alloc] init];
    tranCodeData2.queryKey = kLocationDate;
    tranCodeData2.userDefinedData = todayDateString;
    [activeTableDataPtr.tableVariablesArray addObject:tranCodeData2];
    
    
    [activeTableDataPtr.dbAllTabTransDict setObject:dbTrans forKey:TranCodeAllInv];// startUpTVCKey];

}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Data Base Supporting
/////////////////////////////////////////
-(void)userLogInTransaction:(ActionRequest *)pressedBtn
{
    
    NSLog(@"userLogInTransaction   not doing anything anymore");
    return;
    /*
    CellUIView *logOnCell = (CellUIView *) pressedBtn.myParentCell;
    NSString *userID = @"User ID Not Entered";
    NSString *userPW = @"User PW Not Entered";
    CellInputField *userInputCell;
    if (logOnCell.cInputFieldsArray.count >= 2){
        userInputCell = [logOnCell.cInputFieldsArray objectAtIndex:0];
        [userInputCell textFieldDidEndEditing:nil];
        if (userInputCell.userEntered)
            userID = userInputCell.userEntered;
        userInputCell = [logOnCell.cInputFieldsArray objectAtIndex:1];
        [userInputCell textFieldDidEndEditing:nil];
        if(userInputCell.userEntered)
            userPW = userInputCell.userEntered;
    }
    NSLog(@"User ID = %@, User PW = %@",userID, userPW);
    
    //    TableDef *tableDef7 = [self makeTVC1:nil];
    //    return tableDef7;
    [pressedBtn.uiButton setTitle:@"Verifying" forState:UIControlStateNormal];
    self.dbaTrans = [[IDentifyUser alloc] init];
    [dbaTrans startValidateUserUsingView:rtTableViewCtrler.view  forUser:userID andPW:userPW withQueryData:pressedBtn];
    */
}
-(NSMutableDictionary*) buildLocationsDictionary:(int)numberOfLocations
{
    if (!allLocationsHDI){
        allLocationsHDI = [[NSMutableDictionary alloc] init];
    }
    [allLocationsHDI removeAllObjects];
  
//    LocationRecord *aLocation;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"MM/dd"];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
    NSString *todayDateString = [dateFormatter stringFromDate:today];
    NSMutableDictionary *aLocDict;
    
    for (int i = 0; i < numberOfLocations; i ++){
/*
 
        aLocation = [[LocationRecord alloc] init];
        aLocation.locationDate = todayDateString;
        aLocation.locationName = [NSString stringWithFormat:@"Theater Name %03d",i];
        aLocation.locationStreetAddress = [NSString stringWithFormat:@"Theater Address %i",i];
        aLocation.locationCity = [NSString stringWithFormat:@"Theater City %i",i];
        aLocation.locationState = [NSString stringWithFormat:@"Theater State %i",i];
        aLocation.locationZip = [NSString stringWithFormat:@"Theater Zip %i",i];
        
 */
     
         aLocDict = [[NSMutableDictionary alloc] init];
        NSString *locationDate = todayDateString;
        NSString *locationName = [NSString stringWithFormat:@"Theater Name %03d",i];
        NSString *locationStreetAddress = [NSString stringWithFormat:@"Theater Address %i",i];
        NSString *locationCity = [NSString stringWithFormat:@"Theater City %i",i];
        NSString *locationState = [NSString stringWithFormat:@"Theater State %i",i];
        NSString *locationZip = [NSString stringWithFormat:@"Theater Zip %i",i];
        
        [aLocDict setObject:locationName forKey:kLocationNameKey];
        [aLocDict setObject:locationStreetAddress forKey:kLocationAddressKey];
        [aLocDict setObject:locationCity forKey:kLocationCityKey];
        [aLocDict setObject:locationState forKey:kLocationStateKey];
        [aLocDict setObject:locationZip forKey:kLocationZipKey];
        [aLocDict setObject:locationDate forKey:kLocationDate];
        
        
        
//    [allLocationsHDI setObject:aLocation forKey:aLocation.locationName];
        [allLocationsHDI setObject:aLocDict forKey:[aLocDict objectForKey:kLocationNameKey]];
    }
    
//    allLocationKeys = [[allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return allLocationsHDI;
}
-(NSArray *)extractUnigueIDs:(NSMutableDictionary *)tmsDict
{
    //this must become generic
    
//    NSMutableArray *retArray=[[NSMutableArray alloc]init];
    NSMutableDictionary *uniqueMovieIDDict = [[NSMutableDictionary alloc] init];
    NSArray *allMovieKeys = [tmsDict allKeys];
    NSString *rootId;
    NSString *aKey;
    NSString *movieTitle;
    NSMutableDictionary *aMovieDict;
    for(aKey in allMovieKeys) {
        aMovieDict = [tmsDict objectForKey:aKey];
        rootId=[aMovieDict objectForKey:@"rootId"];
        movieTitle =[aMovieDict objectForKey:@"title"];
        if (rootId) {
            [uniqueMovieIDDict setObject:movieTitle forKey:rootId];
        }
        NSLog(@"");
    }
    NSArray *allUniqueKeys = [uniqueMovieIDDict allKeys];
    return allUniqueKeys;
    
}


-(NSMutableArray *)extractIDs:(NSMutableDictionary *)tmsDict
{
    //this must become generic
    
    NSMutableArray *retArray=[[NSMutableArray alloc]init];
    NSString *rootId;
    for(id key in tmsDict) {
        id value = [tmsDict objectForKey:key];
        rootId=[value objectForKey:@"rootId"];
        if (rootId) {
            [retArray addObject: rootId];
        }
        NSLog(@"");
    }
    
    return retArray;
    
}
-(NSMutableArray*) buildProductArray:(NSMutableArray *)movieNameList
{
    //    NSMutableDictionary *allProductRecords = [[NSMutableDictionary alloc] init];
 //   if (!testProductArray){
 //       testProductArray = [[NSMutableArray alloc] init];
 //   }
 //   [testProductArray removeAllObjects];
    testProductArray = [[NSMutableArray alloc] init];
//    ProductRecord *aProduct;
//    LocationRecord *aLocation;
    NSMutableDictionary *aLocDict;
    NSString *aLocKey;
    //   NSString *productDate;
    NSMutableArray * productDates = [self generateDateArray:5];
    NSString *aMovieName;
    NSMutableDictionary *aProdDict;
    NSMutableArray *productTimesArray = [self buildPurchaseTimesArray];
    NSArray* allLocationKeys = [[allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (aLocKey in allLocationKeys){
//        aLocation = [allLocationsHDI objectForKey:aLocKey];
        aLocDict = [allLocationsHDI objectForKey:aLocKey];
        for (int j = 0; j < kNumberOfDaysInHeader;j++){
            //           productDate = [self generateDateString:j];
            for (int i = 0; i <movieNameList.count; i ++){

                aProdDict = [[NSMutableDictionary alloc] init];
                aMovieName = [movieNameList objectAtIndex:i];
                [aProdDict setObject:aMovieName forKey:kProductNameKey];
                [aProdDict setObject:productTimesArray forKey:kProductTimesArrayKey];
                [aProdDict setObject:[aLocDict objectForKey:kLocationNameKey] forKey:kLocationNameKey];
                [aProdDict setObject:[aLocDict objectForKey:kLocationZipKey] forKey:kLocationZipKey];
                [aProdDict setObject:[productDates objectAtIndex:j] forKey:kLocationDate];
                [aProdDict setObject:[self implodeArrayOfStrings:productTimesArray] forKey:kProductImplodedTimesKey];

/*
                aProduct = [[ProductRecord alloc] init];
                aProduct.productName =[movieNameList objectAtIndex:i];// aMovieName;// [NSString stringWithFormat:@"Movie Name %03d",i+(j*100)];
 //               aProduct.productDescription = [NSString stringWithFormat:@"%@ - Movie Description",aMovieName]; // [NSString stringWithFormat:@"Movie Description %i", i+(j*100)];
 //               aProduct.productImage = [UIImage imageNamed:@"stp_card_discover.png"];
                aProduct.productTimes = [self buildPurchaseTimesArray]; //[self buildPurchaseDatesArray:j forProduct:aProduct];
                aProduct.locationName = aLocation.locationName;
                aProduct.locationZip  = aLocation.locationZip;
                aProduct.locationDate = [productDates objectAtIndex:j];
                aProduct.implodedTimes = [self implodeArrayOfStrings:aProduct.productTimes];
 */
 //               [testProductArray addObject:aProduct];
              [testProductArray addObject:aProdDict];
                
            }
        }
        //   [aLocation.locationProducts setObject:aProduct forKey:aProduct.productName];
    }
    //    testProductKeys = [[testProductDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return testProductArray ;
}
/*
-(NSMutableArray*) buildTestProductArray:(int)numberOfMoviesPerDay
{
 //    NSMutableDictionary *allProductRecords = [[NSMutableDictionary alloc] init];
    testProductArray = [[NSMutableArray alloc] init];
    ProductRecord *aProduct;
    LocationRecord *aLocation;
    NSString *aLocKey;
 //   NSString *productDate;
    NSMutableArray * productDates = [self generateDateArray:5];
    for (aLocKey in allLocationKeys){
        aLocation = [allLocationsHDI objectForKey:aLocKey];
        for (int j = 0; j < kNumberOfDaysInHeader;j++){
 //           productDate = [self generateDateString:j];
            for (int i = 0; i <numberOfMoviesPerDay; i ++){
                aProduct = [[ProductRecord alloc] init];
                aProduct.productName = [NSString stringWithFormat:@"Movie Name %03d",i+(j*100)];
//                aProduct.productDescription = [NSString stringWithFormat:@"Movie Description %i", i+(j*100)];
                aProduct.productImage = [UIImage imageNamed:@"stp_card_discover.png"];
                aProduct.productTimes = [self buildPurchaseTimesArray]; //[self buildPurchaseDatesArray:j forProduct:aProduct];
                aProduct.locationName = aLocation.locationName;
                aProduct.locationZip  = aLocation.locationZip;
                aProduct.locationDate = [productDates objectAtIndex:j];
                aProduct.implodedTimes = [self implodeArrayOfStrings:aProduct.productTimes];
                
                [testProductArray addObject:aProduct];
                
            
        }
      }
     //   [aLocation.locationProducts setObject:aProduct forKey:aProduct.productName];
}
//    testProductKeys = [[testProductDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return testProductArray ;
}
*/
-(NSMutableArray *) buildPurchaseTimesArray//:(NSInteger)daysFromToday forProduct:(ProductRecord *)aProduct
{
   NSMutableArray *productTimes = [[NSMutableArray alloc] initWithObjects:@"9:00 am", @"10:00 am",@"11:00 am",@"1:00 pm",@"3:00 pm", nil];
   
    return productTimes;
    
}

-(NSMutableArray*)generateDateArray:(int)numberOfDays{
//    -(NSMutableArray *) buildPurchaseDatesArray:(NSInteger)daysFromToday forProduct:(ProductRecord *)aProduct
    
        //    [aProduct.purchaseRecords removeAllObjects];
        NSMutableArray *productDates = [[NSMutableArray alloc] init];
        NSString *string = @"7:00";
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
         NSDateFormatter *timeOnlyFormatter = [[NSDateFormatter alloc] init];
        [timeOnlyFormatter setLocale:locale];
        [timeOnlyFormatter setDateFormat:@"h:mm"];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *today = [NSDate date];
        NSDateComponents *todayComps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:today];
        NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[timeOnlyFormatter dateFromString:string]];
    for (int i = 0; i < numberOfDays;i++){
        comps.day = todayComps.day+i;
        comps.month = todayComps.month;
        comps.year = todayComps.year;
        NSInteger hour = 9;
        NSInteger minute = 30;
        comps.hour = hour;
        comps.minute = minute;
        //    MovieShowing* aMovieShowing;
        //    PurchaseRecord *aPurchase = [[PurchaseRecord alloc] init];
//        for (int i = 0; i < 10; i++){
        today = [calendar dateFromComponents:comps];
            
//            [purchaseDates addObject:today];
            
//            hour = hour + 1;
//            comps.hour = hour;
            
//        }

        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        //    [dateFormatter setDateFormat:@"MM/dd"];
        [dateFormatter  setDateFormat:@"MMM dd"];
        
        NSString *showingDate = [dateFormatter stringFromDate:today];
        [productDates addObject:showingDate];
        
        }
        return productDates;
        
    
}
-(NSString *)implodeArrayOfStrings:(NSMutableArray *)stringArray
{
    if (!stringArray.count)
        return @"";
    NSString *implodedString = [stringArray objectAtIndex:0];
    if (stringArray.count== 1)
        return implodedString;
    NSString *arrayStr;
    //    for (arrayStr in stringArray){
    for (int i = 1; i < stringArray.count; i++){
        
        arrayStr = [stringArray objectAtIndex:i];
        implodedString = [implodedString stringByAppendingString:[NSString stringWithFormat:@",%@",arrayStr]];
    }
    return implodedString;
}

/*
-(NSMutableArray*) convertInventoryArrayToProductArray:(ActionRequest *)aQuery
{
     testProductArray = [[NSMutableArray alloc] init];
    NSMutableArray *inventoryArray = aQuery.retRecordsAsDPtrs; // = aQuery.array;
    if (!testProductArray){
        testProductArray = [[NSMutableArray alloc] init];
    }
     NSDictionary *aProductDict;
    ProductRecord *aProduct;
    for (aProductDict in inventoryArray){
        aProduct = [self buildProductFromDBDictionary:aProductDict];
        [testProductArray addObject: aProduct];
    }
    
    //    locationArray = nil;
 //   testProductKeys = [[testProductDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return testProductArray;
}
*/
/*
-(ProductRecord *)buildProductFromDBDictionary:(NSDictionary*)aProductDict
{
    ProductRecord *aProduct = [[ProductRecord alloc] init];
    
    aProduct.productName = [aProductDict objectForKey:@"ProductName"];// [NSString stringWithFormat:@"Theater Name %03d",i];
    NSString *productKey = aProduct.productName;
    
    
// Myra Dan this removes the space in the front of the product name;
    aProduct.productName = [productKey substringWithRange:NSMakeRange(1, [productKey length]-1)];
    aProduct.productID = [aProductDict objectForKey:@"ProductID"];// [NSString stringWithFormat:@"Theater Address %i",i];
    aProduct.locationName = [aProductDict objectForKey:@"LocationName"];// [NSString stringWithFormat:@"Theater City %i",i];
    aProduct.locationZip = [aProductDict objectForKey:@"LocationZip"];//[NSString stringWithFormat:@"Theater Zip %i",i];
    aProduct.implodedTimes = [aProductDict objectForKey:@"ProductTimes"];
    aProduct.locationDate = [aProductDict objectForKey:@"LocationDate"];
    NSArray* productTimesArray = [self explodeAStringToArraySubstrings:aProduct.implodedTimes];
    [aProduct.productTimes addObjectsFromArray:productTimesArray];
    aProduct.productImage = [movieImageDictionary objectForKey:aProduct.productName];  //[UIImage imageNamed:@"stp_card_discover.png"];
    return aProduct;
}
-(LocationRecord*)buildLocationFromDBDictionary:(NSDictionary*)aLocationDict;
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"MM/dd"];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
//    NSDictionary *aLocationDict;
    NSString *todayDateString = [dateFormatter stringFromDate:today];
    LocationRecord *aLocation = [[LocationRecord alloc] init];
    aLocation.locationDate = todayDateString;
    aLocation.locationName = [aLocationDict objectForKey:kLocationKey];
    aLocation.locationStreetAddress = [aLocationDict objectForKey:kLocationAddressKey];
    aLocation.locationCity = [aLocationDict objectForKey:kLocationCityKey];
    aLocation.locationState = [aLocationDict objectForKey:kLocationStateKey];
    aLocation.locationZip = [aLocationDict objectForKey:kLocationZipKey];
    return aLocation;
}
*/
// Build Location Dictionary From DB Array of Dictionaries From JSON
/*
-(NSMutableDictionary*) convertLocationArrayToDictionary:(ActionRequest *)aQuery
{
    NSMutableArray *locationArray = aQuery.retRecordsAsDPtrs; // = aQuery.array;
 //   NSMutableDictionary *allLocationRecords =[[NSMutableDictionary alloc] init];
    if (!allLocationsHDI){
        allLocationsHDI = [[NSMutableDictionary alloc] init];
    }
    [allLocationsHDI removeAllObjects];
    LocationRecord *aLocation;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"MM/dd"];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSDate *today = [NSDate date];
    NSDictionary *aLocationDict;
    NSString *todayDateString = [dateFormatter stringFromDate:today];
 //   for (int i = 0; i < locationArray.count; i ++){
    for (aLocationDict in locationArray){
        aLocation = [[LocationRecord alloc] init];
        aLocation.locationDate = todayDateString;
        aLocation.locationName = [aLocationDict objectForKey:kLocationKey];// [NSString stringWithFormat:@"Theater Name %03d",i];
        aLocation.locationStreetAddress = [aLocationDict objectForKey:kLocationAddressKey];// [NSString stringWithFormat:@"Theater Address %i",i];
        aLocation.locationCity = [aLocationDict objectForKey:kLocationCityKey];// [NSString stringWithFormat:@"Theater City %i",i];
        aLocation.locationState = [aLocationDict objectForKey:kLocationStateKey];// [NSString stringWithFormat:@"Theater State %i",i];
        aLocation.locationZip = [aLocationDict objectForKey:kLocationZipKey];//[NSString stringWithFormat:@"Theater Zip %i",i];
 //       aLocation.implodedProductNames = [aLocationDict objectForKey:kLocationProducts];
 //       aLocation.locationProducts  = [self makeProductsDictionaryFromArrayOfProductNames:aLocation.implodedProductNames];
        [allLocationsHDI setObject:aLocation forKey:aLocation.locationName];
    }
    
//    locationArray = nil;
    allLocationKeys = [[allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return allLocationsHDI;
}

-(NSString *)implodeArrayOfStrings:(NSMutableArray *)stringArray
{
     NSString *implodedString = @"";
     NSString *arrayStr;
    for (arrayStr in stringArray){
        implodedString = [implodedString stringByAppendingString:[NSString stringWithFormat:@"%@,",arrayStr]];
    }
    return implodedString;
}

-(NSString *)implodeArrayProductNames:(NSMutableDictionary *)productDictionary
{
    NSArray *productRecordKeys = [[productDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    ProductRecord *aProduct;
    NSString *implodedString = @"";
    for (int i = 0; i < productRecordKeys.count; i++){
        aProduct = [productDictionary objectForKey:[productRecordKeys objectAtIndex:i]];
        implodedString = [implodedString stringByAppendingString:[NSString stringWithFormat:@"%@,",aProduct.productName]];
    }
    return implodedString;
}

-(NSArray *)explodeAStringToArraySubstrings:(NSString *)implodedString
{
    NSArray *stringArray = [implodedString componentsSeparatedByString: @","];
    return stringArray;
}

-(NSMutableDictionary *)makeProductsDictionaryFromArrayOfProductNames:(NSString *)implodedProductNames
{
    NSArray *productNames = [self explodeAStringToArraySubstrings:implodedProductNames];
    NSMutableDictionary *allProductRecords = [self buildProductDictionary:10];
    NSMutableDictionary *productDictionary = [[NSMutableDictionary alloc] init];
    NSString *aProductName;
    ProductRecord *aProduct;
    for (aProductName in productNames){
        if (![aProductName isEqualToString:@""]){
            aProduct = [allProductRecords objectForKey:aProductName];
            [productDictionary setObject:aProduct  forKey:aProductName];
        }
    }
    return productDictionary;
}
*/
/*
-(NSMutableArray *) buildPurchaseDatesArray:(NSInteger)daysFromToday forProduct:(ProductRecord *)aProduct
{
//    [aProduct.purchaseRecords removeAllObjects];
    NSMutableArray *purchaseDates = [[NSMutableArray alloc] init];
    NSString *string = @"7:00";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *timeOnlyFormatter = [[NSDateFormatter alloc] init];
    [timeOnlyFormatter setLocale:locale];
    [timeOnlyFormatter setDateFormat:@"h:mm"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:today];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[timeOnlyFormatter dateFromString:string]];
    comps.day = todayComps.day+daysFromToday;
    comps.month = todayComps.month;
    comps.year = todayComps.year;
    NSInteger hour = 9;
    NSInteger minute = 30;
    comps.hour = hour;
    comps.minute = minute;
    //    MovieShowing* aMovieShowing;
    //    PurchaseRecord *aPurchase = [[PurchaseRecord alloc] init];
       for (int i = 0; i < 10; i++){
        NSDate *today = [calendar dateFromComponents:comps];
        
          [purchaseDates addObject:today];
        
        hour = hour + 1;
        comps.hour = hour;
        
    }
    return purchaseDates;
    
}
*/
/*
-(NSMutableDictionary *)buildProductDictionaryForLocation:(LocationRecord *)aLocation inDatabaseDictionay:(NSMutableDictionary *)databaseDictionary
{
    //   NSMutableArray *productsAtLocation = [[NSMutableArray alloc] init];
    //    NSMutableDictionary *productRecords = [self searchForAllProducts];
    NSArray *productRecordKeys = [[databaseDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    [aLocation.locationProducts removeAllObjects];
    ProductRecord *aProduct;
    //    MovieShowing *aShowing;
//    PurchaseRecord *aPurchase;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    //    [dateFormatter setDateFormat:@"MM/dd"];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSMutableDictionary *locationProducts = [[NSMutableDictionary alloc] init];
    for (int i= 0; i < productRecordKeys.count;i++){
        aProduct = [databaseDictionary objectForKey:[productRecordKeys objectAtIndex:i]];
        aProduct.selectedLocation = aLocation;
//        aPurchase = [aProduct.purchaseRecords objectAtIndex:0];
//        aPurchase.purchaseDateAndTime = [aProduct.productTimes objectAtIndex:0];
//        purchaseDate = aPurchase.purchaseDateAndTime;
        NSString *dateName = [dateFormatter stringFromDate:[aProduct.productTimes objectAtIndex:0]];
        if ([dateName isEqualToString:aLocation.locationDate])
            // [productsAtLocation addObject:aProduct];
            [locationProducts setObject:aProduct forKey:aProduct.productName];
        
    }
    //    [moviesPlaying removeAllObjects];
    //    moviesPlaying = nil;
    NSString *implodedMovieNames = [self implodeArrayProductNames:locationProducts];
    //    NSMutableDictionary *explodedProductDictionary = [self makeProductsDictionaryFromArrayOfProductNames:implodedMovieNames];
//    aLocation.implodedProductNames = implodedMovieNames;
    return locationProducts;
}
*/

-(NSMutableArray*)buildPurchaseDictionaryArrayForAProduct:(ActionRequest *)aProductTimeBtn

{
 //   ProductRecord *aProduct =  aProductTimeBtn.aProduct;// [aProductTimeBtn.dataRecords objectForKey:aProductTimeBtn.dataRecordKey];//    [aProduct.purchaseRecords removeAllObjects];
     NSMutableDictionary *aProductDict = aProductTimeBtn.productDict; //[self.gGTPptr fetchProductDict:aProductTimeBtn];
    
    
//   aProductDict = aProductTimeBtn.aProductDict;
    
    NSMutableArray *purchaseRecords = [[NSMutableArray alloc] init];
//    NSDate *selectedDate =[aProduct.productTimes objectAtIndex:aProductTimeBtn.buttonIndex];
    NSString * aProductType;
    NSNumber *aProductPrice;
    NSNumber *aProductQuantity;
    PurchaseRecord *aPurchase;

//    for (int i = 0; i < 10; i++){
    aPurchase = [[PurchaseRecord alloc] init];
//    aPurchase.purchaseLocRec = aProduct.selectedLocation;
//    aPurchase.purchaseLocation = aProduct.locationName;


    aPurchase.aProductDict = aProductDict;
//    aPurchase.purchaseDateAndTime = selectedDate;
//    [purchaseRecords addObject:aPurchase];
    for (int j = 0; j < productTypes.count; j++){
        NSMutableDictionary *purchaseInfo = [[NSMutableDictionary alloc] init];
        aProductType = [productTypes objectAtIndex:j];
        aProductPrice =[productPrices objectAtIndex:j];
        aProductQuantity = [productQuantities objectAtIndex:j];
        [purchaseInfo setObject:aProductType forKey:kPurchaseTypeKey];
        [purchaseInfo setObject:aProductPrice forKey:kPurchasePriceKey];
        [purchaseInfo setObject:aProductQuantity forKey:kPurchaseQuantityKey];
        [aPurchase.allPurchaseTypes addObject:purchaseInfo];
    }
    [purchaseRecords addObject:aPurchase];
    return purchaseRecords;
//    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark SAVE
/////////////////////////////////////////



@end
