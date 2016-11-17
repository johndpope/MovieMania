//
//  GlobalTableProto.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "GlobalTableProto.h"
#import "Runtime.h"
#import "CellButtonsScroll.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h> 
#import "CellMovieView.h"
//#import "CellCollectionView.h"
//#import "CellButtonsContainer.h"


/*
@implementation NSString (NSString_Extended)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
@end
 */
@implementation GlobalTableProto
{
    NSArray *footerButtonNames1;
    NSArray *footerButtonNextTableViews1;
    NSArray *footerButtonNames0;
    NSArray *footerButtonNextTableviews0;
 //   NSMutableArray *headerDateButtons;
    NSInteger aUniqueNSInteger;
    NSNumber *aUniqueNSNumber;
    NSMutableArray *purchaseKeys;
    NSMutableArray *productTypes;
    NSMutableArray *productPrices;
    NSMutableArray *productQuantities;
    BOOL makeCollectionView;

//    NSMutableDictionary *allMovieInfoOMDBViews;
//    UIImageView *moviePosterView;
}

@synthesize debugFlag,globalZipCode,currentActiveTVRect;
@synthesize thisUserValid;
@synthesize runningSimulator;
@synthesize allButtonsDictionary;
@synthesize allEntryFieldsDictionary;
//@synthesize actionForReloadingView;
@synthesize inAVPlayerVC;
@synthesize viewBackColor,viewTextColor,cellBackColor,headerBackColor;
@synthesize selectedDate, selectedLocDict, selectedProdcuctDict;
@synthesize sizeGlobalButton,sizeGlobalPoster,sizeGlobalVideo,sizeGlobalTextFontBig,sizeGlobalTextFontMiddle,sizeGlobalTextFontSmall;

NSString* const ConstDoneLoopingXactionResponseProcessed = @"DoneLoopingXactionResponseProcessed";
NSString* const ConstIDentifyUserControllerSuccess = @"IDentifyUserControllerCompletedOK";
NSString* const ConstIDentifyUserControllerFailure = @"IDentifyUserControllerFailure";
NSString* const ConstTVCDisplayedNotifyRuntime = @"TVCDisplayedNotifyRuntime";

NSString* const ConstTVCDisplayVisible = @"TVCDisplayVisible";
NSString* const ConstUserTouchInput = @"UserTouchInput";
NSString* const ConstContinueLoopingTransaction=@"ContinueLoopingTransaction";


NSString* const ConstUserFocusMovie = @"UserFocusMovie";
NSString* const ConstUserSpeechUtterance = @"UserSpeechUtterance";

NSString* const ConstNEWZIPstartOver = @"NewZipStartOver";

+(GlobalTableProto *)sharedGlobalTableProto
{
    static GlobalTableProto *sharedGlobalTableProto;
    if (sharedGlobalTableProto == nil) {
        sharedGlobalTableProto = [[super allocWithZone:nil] init];
        
        
        [sharedGlobalTableProto initDefaultValues];
        
    }
    
    return sharedGlobalTableProto;
}

-(void) initDefaultValues
{
   
    aUniqueNSNumber=[NSNumber numberWithInt:1];
    aUniqueNSInteger=1;

    
    debugFlag=FALSE;// TRUE;
    
    
    thisUserValid=FALSE;
    runningSimulator=FALSE;
    purchaseKeys = [[NSMutableArray alloc] initWithObjects:kPurchaseTypeKey,kPurchasePriceKey,kPurchaseQuantityKey, nil];
    productTypes = [[NSMutableArray alloc] initWithObjects:@"Adult",@"Child",@"Matinee", nil];
    productPrices = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:12.5],[NSNumber numberWithFloat:6.50],[NSNumber numberWithFloat:8.50], nil];
    productQuantities = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0] , nil];//    self.tablesToDisplayArray=[[NSMutableArray alloc]init];
    
    allEntryFieldsDictionary=[[NSMutableDictionary alloc] init];
    
    allButtonsDictionary  = [[NSMutableDictionary alloc] init];

    footerButtonNames1 = [[NSArray alloc] initWithObjects:@"SetZip",@"TTV", @"MBV", @"MTV",@"GEN", nil];
    footerButtonNextTableViews1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:TVC0],[NSNumber numberWithInteger:TVC1],[NSNumber numberWithInteger:TVC2],[NSNumber numberWithInteger:TVC3],[NSNumber numberWithInteger:TVC21], nil];
//    headerDateButtons = [[NSMutableArray alloc] init];
    footerButtonNames0 = [[NSArray alloc] initWithObjects:@"InitLoc",@"InitInv", @"MovieInfo", BUTTONS_FILLER_NAME,@"StartApp", nil];
    footerButtonNextTableviews0= [[NSArray alloc] initWithObjects:[NSNumber numberWithInteger:TVCStartUp],[NSNumber numberWithInteger:TVCStartUp],[NSNumber numberWithInteger:TVCStartUp],[NSNumber numberWithInteger:TVCStartUp],[NSNumber numberWithInteger:TVCStartUp], nil];
 //   allMovieInfoOMDBViews = [[NSMutableDictionary alloc] init];
    
    inAVPlayerVC = YES;//NO - youtube;//YES - TMS trailer;
    
    
    //default TOOLKIT settings like when you pass nil for a helper method are defined SEE TableProtoDefines.h
    //
    viewTextColor = TK_TEXT_COLOR;//[UIColor whiteColor];
    viewBackColor = TK_VIEW_BackColor;//[UIColor colorWithRed:(32/255.0) green:(32/255.0) blue:(32/255.0) alpha:1] ;  // very dark gray
    cellBackColor = TK_CELL_BackColor;//[UIColor colorWithRed:(47/255.0) green:(47/255.0) blue:(47/255.0) alpha:1] ;  // dark gray
    headerBackColor = TK_HEADER_BackColor;//[UIColor colorWithRed:(204/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] ; // reddish
    sizeGlobalTextFontBig=TK_IOS_TextFontBig;
    sizeGlobalTextFontMiddle=TK_IOS_TextFontMiddle;
    sizeGlobalTextFontSmall=TK_IOS_TextFontSmall;
    sizeGlobalPoster=CGSizeMake(TK_IOS_PictureWidth, TK_IOS_PictureHeight);  //picture holder
    sizeGlobalButton=CGSizeMake(TK_IOS_ButtonWidth, TK_IOS_ButtonHeight);  //press button
    sizeGlobalVideo=CGSizeMake(TK_IOS_VideoWidth, TK_IOS_VideoHeight);
    
    #if TARGET_OS_TV
    sizeGlobalTextFontBig=TK_TVOS_TextFontBig;
    sizeGlobalTextFontMiddle=TK_TVOS_TextFontMiddle;
    sizeGlobalTextFontSmall=TK_TVOS_TextFontSmall;
    sizeGlobalPoster=CGSizeMake(TK_TVOS_PictureWidth, TK_TVOS_PictureHeight);  //picture holder
    sizeGlobalButton=CGSizeMake(TK_TVOS_ButtonWidth, TK_TVOS_ButtonHeight);  //press button
    sizeGlobalVideo=CGSizeMake(TK_TVOS_VideoWidth, TK_TVOS_VideoHeight);
    #endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark ASSIGN Table Defs Methods
/////////////////////////////////////////
-(TableDef *)makeTVC:(ActionRequest *)pressedBtn
{
    makeCollectionView=NO;
    NSInteger nextTVC = TVC0;
    TableDef * nextTableDef;
    
    [allEntryFieldsDictionary removeAllObjects]; //may not want to do this if data should be kept for some reason
    
//    [allButtonsDictionary removeAllObjects];
//    [allMovieShowingsDictionary removeAllObjects];
    if (pressedBtn){
        nextTVC = pressedBtn.nextTableView;
    }
        switch (nextTVC) {
            case TVCERROR:
                nextTableDef=[self makeERRORsplash:pressedBtn];
                break;
            case TVCStartUp:
                nextTableDef = [self makeTVCStartUp:nil];
                break;
            case TVC0:
                NSLog(@"call makeTVC0");
                nextTableDef = [self makeTVC0:nil];
                break;
            case TVC1:
                NSLog(@"call makeTVC1");
                nextTableDef = [self makeTVC1:pressedBtn];
        
                break;
            case TVC2:
                NSLog(@"call makeTVC2");
         //       makeCollectionView=YES;
                nextTableDef = [self makeTVC2:pressedBtn];
             
                break;
            case TVC21:
                NSLog(@"call makeTVC21");
                makeCollectionView=YES;
                nextTableDef = [self makeTVC2Genres:pressedBtn];
                break;
            
            case TVC3:
                NSLog(@"call makeTVC3");
                nextTableDef = [self makeTVC3:pressedBtn];
              
                break;
            case TVC4:
                NSLog(@"call makeTVC4");
                nextTableDef = [self makeTVC4:pressedBtn];
                break;
            case TVC5:

                nextTableDef = [self makeTVC5:pressedBtn];
                break;

            case TVC6:
                NSLog(@"call makeTVC6");
                nextTableDef = [self makeTVC6:pressedBtn];
                
                break;
/*
            case TVC7:
                NSLog(@"call makeTVC7");
                nextTableDef = [self makeTVC7:pressedBtn];
                break;
*/
            case TVC8:
                NSLog(@"call makeTVC8");
                nextTableDef = [self makeTVC8:pressedBtn];
                break;
            case TVC9:
                nextTableDef = [self makeTVC9:pressedBtn];
               break;

            case TVC10:
                nextTableDef = [self makeTVC10:pressedBtn];
                break;
 
 
 
            default:
                NSLog(@"call default to TVC2");
                nextTableDef = [self makeTVC2:nil];// [self makeTVCInitDBs:nil];
                break;
        }
    
    
    
    
    
    return nextTableDef;
}

// Start Up Table Def could be downloaded when app starts up.

-(TableDef *)makeTVCInitDBs:(ActionRequest *)pressedButton
{
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;// CGSizeMake(60, 30);
    AutomatedXACT *automateXACTptr;
    if (debugFlag) {
            myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames0 withNextTVCs:footerButtonNextTableviews0 withButtonSize:btnSize];// buttonsScroll:NO];
        
        ActionRequest *footerButton;
        CellButtonsScroll *allFooterButtonsCell;
        allFooterButtonsCell = (CellButtonsScroll *)myTable.tableFooterContentPtr.ccCellTypePtr;
        //    TransactionData *tranCodeData;
        
        for (footerButton in allFooterButtonsCell.cellsButtonsArray){
            switch (footerButton.nextTableView) {
                
                case TVC1:
                // transactionKey = @"Locations";
                footerButton.transactionKey = TranCodeAllLocs;//transactionKey;
                break;
                /*
                 
                 dbTrans = [[Transaction alloc]initWithQTitle:@"Locations" andQDescr:@"LocationsList" andNumber:0];
                 //            dbTrans.URL=@"http://97.77.211.34/~Dwain/TABLEproto/indexTEST";
                 dbTrans.URL=@"http://localhost/~DanHammond/locations";
                 //           dbTrans.URL=@"http://localhost/~myra/locations";
                 
                 tranCodeData=[[TransactionData alloc]init];
                 tranCodeData.queryKey=TranCodeKey;
                 tranCodeData.userDefinedData= TranCodeAllLocs;
                 [myTable.tableVariablesArray addObject:tranCodeData];
                 [myTable.dbAllTabTransDict setObject:dbTrans forKey:transactionKey];// startUpTVCKey];
                 break;
                 */
                default:
                break;
            }
        }

    }
    else{
        myTable=[[TableDef alloc]init];
 
       // automateXACTptr=[[AutomatedXACT alloc]init];        //
      //  automateXACTptr.buttonTitle=@"MyraTest";
      //  [myTable.autoXACTarray addObject:automateXACTptr];
        
        automateXACTptr=[[AutomatedXACT alloc]init];        //GIVES now MOVIES FOR ZIP, only populate movieNames array
        automateXACTptr.buttonTitle=@"MovieInfo";
        [myTable.autoXACTarray addObject:automateXACTptr];
        
        
        
        automateXACTptr=[[AutomatedXACT alloc]init];        //GIVES THEATERS FOR ZIP
        automateXACTptr.buttonTitle=@"TVC1";
        [myTable.autoXACTarray addObject:automateXACTptr];
        

        
        automateXACTptr=[[AutomatedXACT alloc]init];
        automateXACTptr.buttonTitle=@"CollectFREEmovieInformation";   //odbc looping
        [myTable.autoXACTarray addObject:automateXACTptr];

        
        automateXACTptr=[[AutomatedXACT alloc]init];
        automateXACTptr.buttonTitle=@"GetImages";
        [myTable.autoXACTarray addObject:automateXACTptr];
       
        automateXACTptr=[[AutomatedXACT alloc]init];
        automateXACTptr.buttonTitle=QueryMovieYouTubeTrailers;
        [myTable.autoXACTarray addObject:automateXACTptr];
        
        automateXACTptr=[[AutomatedXACT alloc]init];
        automateXACTptr.buttonTitle=@"TVC2";
        [myTable.autoXACTarray addObject:automateXACTptr];
        

 
        

    }
   [self mkTableDefSplashScreen:myTable]; //screen users will see when data initially downloads
    return myTable;
    
/////////////////////  Various SPLASH SCREEN TESTERs BELOW
   // [self mkTableDefTesterSplashScreen0:myTable]; //TESTER   FOR TEST SECTION, CELLS   as text  tvos testing - lots of cells - scrollable
   // return myTable; //tvos
    //[self mkTableDefTesterSplashScreen1:myTable]; //TESTER   FOR TEST SECTION, CELLS   as text
    //return myTable;
    
    
   // [self mkTableDefTesterSplashScreen2:myTable]; //TESTER   FOR TEST SECTION, CELLS  using image only type of cell
   // return myTable;

   
   //  [self mkTableDefTesterSplashScreen3:myTable]; //TESTER   FOR TEST SECTION, CELLS  using cellUIView type of cell (image and text)
   //  return myTable;
    
   // [self mkTableDefTesterSplashScreen4:myTable]; //TESTER   FOR TEST SECTION, CELLS  using cellUIView type of cell (image and text)
   // return myTable;
    
   
 }

-(TableDef *)makeTVCStartUp:(ActionRequest *)pressedButton
{
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);

    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
/*
    ActionRequest *footerButton;
    CellButtonsScroll *allFooterButtonsCell;
    allFooterButtonsCell = (CellButtonsScroll *)myTable.tableFooterContentPtr.ccCellTypePtr;

    for (footerButton in allFooterButtonsCell.cellsButtonsArray){
        switch (footerButton.nextTableView) {
                
            case TVC1:
                
  //              footerButton.transactionKey = TranCodeAllLocs;//transactionKey;
                break;
                           default:
                break;
        }
    }
    
*/

    
       return myTable;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TVCs using TMS DB
/////////////////////////////////////////


-(TableDef *)makeTVC0:(ActionRequest *)pressedButton
{
    NSLog(@"----makeTVC0");
    TableDef *myTable;
    SectionDef *sdPtr1;
    
    //C E L L S    F O R        S E C T I O N S
    CellContentDef *cellContentPtr;
    CellTextDef *txtTypeCellPtr;
    CellTextDef *placeholderTxt;
    
    
    CellInputField *entryFPtr;
    CellInputField *entryFPtr1;
    
    CellUIView *cuvPtr;
    
    
    
    
    //n e w   c o d e 2   - c h a n g e   z i p c o d e     no CUV, just EF
    //new code - allow users to change zip code 2
    //
    //
    myTable = [self createFixedTableHeaderUsingText:@"Movies For Zipcode" forTable:nil];
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    
    //empty cell
    CellContentDef *cellContentPtr1;
    CellTextDef *ctdPtr;
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"\n" withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:20 withTextFontName:nil];
    cellContentPtr1.ccCellTypePtr=ctdPtr;
    
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];

    
    
    
    
    //Give centered to start up if you want
    NSString *currentString=[NSString stringWithFormat:@"Current zip code: %@",globalZipCode];
    
    
    txtTypeCellPtr=[CellTextDef initCellText:currentString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    txtTypeCellPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:txtTypeCellPtr ];
    
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    //empty cell
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"\n" withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:20 withTextFontName:nil];
    cellContentPtr1.ccCellTypePtr=ctdPtr;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    //DO entryField with PlaceHolder AND Label:   U S E R    I D
    entryFPtr=[[CellInputField alloc]init];
    placeholderTxt=[CellTextDef initCellText:globalZipCode withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    placeholderTxt.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
    if (entryFPtr.placeholderTextDefPtr) {
        [entryFPtr.placeholderTextDefPtr killYourself];
    }
    entryFPtr.placeholderTextDefPtr=placeholderTxt;
    entryFPtr.leftSideDispTextPtr=[CellTextDef initCellText:@"New zip code:" withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    entryFPtr.leftSideDispTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentRight;
    
    NSString *helpT= @"Enter a zipcode " ;

    entryFPtr.helpTextPtr=[CellTextDef initCellText:helpT withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    entryFPtr.helpTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    
    TransactionData *dataFieldEF=[[TransactionData alloc]init];
    entryFPtr.transDataPtr=dataFieldEF;
    entryFPtr.keyboardType=UIKeyboardTypeNumberPad;
    //does my key exist in gInputFieldsDict?  Every cellInputField has to have corresponding entry there
    entryFPtr.gInputFieldsDictKey=EFKEY_ZIPCODE;
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:entryFPtr ];
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    
    
    //empty cell
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"\n" withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:20 withTextFontName:nil];
    cellContentPtr1.ccCellTypePtr=ctdPtr;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    //NEED ONE VERIFY BUTTON - how to do that?
    
    
    CGSize btnSize1 = sizeGlobalButton;
    NSMutableArray *buttonNames = [[NSMutableArray alloc] initWithObjects:@"Change", nil];
    NSMutableArray *logOnBtn1 = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 buttonCount:1 withButtonNames:buttonNames withButtonSize:btnSize1 buttonType:0];  //  NSMutableArray *logOnBtn1 = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 buttonsPerRow:1 withButtonSize:btnSize1];
    
    //NSMutableArray *logOnBtn = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 buttonsPerRow:1 withTotalNumberOfBtns:1 withButtonSize:btnSize];
    //   NSMutableArray *logOnBtn = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 totalButtonCount:1 startingRecordIndex:0 buttonsPerCell:1 withButtonSize:btnSize];
    ActionRequest *aBtn1 = [logOnBtn1 objectAtIndex:0];
    CellTextDef *ctdPtr1;
    aBtn1.buttonName = @"Change"   ;
    aBtn1.buttonLabel = nil;
    aBtn1.buttonImage = nil;//aMovie.movieImage;
    //   aBtn.dataBaseDict = nil;
    aBtn1.nextTableView = TVCChangeZip;//TVCStartUp;
    //    aBtn.myParentCell = cuvPtr;
    aBtn1.transactionKey = @"Authenticate";
    
    ctdPtr1=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:logOnBtn1 isCollectionView:NO];// buttonScroll:NO];
    [logOnBtn1 removeAllObjects];
    logOnBtn1 = nil;
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr1;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    
    
    
    
    
    return myTable;
    

   }
    
 -(TableDef *)makeERRORsplash:(ActionRequest *)pressedButton
{
       TableDef *myTable=    [[TableDef alloc]init];
    
    //  this tests cell UIView ability to preserving background color
    //  note  default  cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"uma300wx400h" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useWHoleSize=useImage.size;
    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaRuler" withBackColor:cellBackColor rotateWhenVisible:NO withSize:useWHoleSize];
    myTable.tableHeaderContentPtr=nil;
    myTable.tableFooterContentPtr=nil;
    
    
    
    CellUIView *cuvPtr=[[CellUIView alloc]init];
    
    
  
    
    
    
    
   
    
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    // cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;
    cuvPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
    [cuvPtr.cioPtrArr addObject:cioPtr];
    
    cellContentPtr.ccCellTypePtr=cuvPtr;
    
    cuvPtr.canMyRowHaveTVFocus=NO;
    SectionDef *sdPtr2=[SectionDef initSectionHeaderCenteredText:@"MOVIE MANIA" withTextColor:viewTextColor withBackgroundColor:headerBackColor withTextFontSize:20 withTextFontName:nil footerCenteredText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
     sdPtr2.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr2];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    
    CellTextDef *ctdPtr;
    //line 1
    ctdPtr=[CellTextDef initCellText:@"Data Error" withTextColor:[UIColor redColor] withBackgroundColor:nil withTextFontSize:(sizeGlobalTextFontBig) withTextFontName:nil];
    [cuvPtr.cTextDefsArray addObject:ctdPtr];
    ctdPtr.cellSeparatorVisible=TRUE;
    ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    
    //line2
    ctdPtr=[CellTextDef initCellText:pressedButton.errorDisplayText withTextColor:[UIColor redColor] withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
    [cuvPtr.cTextDefsArray addObject:ctdPtr];
    ctdPtr.cellSeparatorVisible=FALSE;
    
    //line3
    ctdPtr=[CellTextDef initCellText:@"Sorry.  Please re-start to try again." withTextColor:[UIColor redColor] withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:ctdPtr];
    ctdPtr.cellSeparatorVisible=FALSE;
    

    return myTable;
    
}
-(TableDef *)makeTVC1:(ActionRequest *)pressedButton
{
    TableDef *myTable;
    NSLog(@"----makeTVC1");
     myTable = [self createFixedTableHeaderUsingText:@"Theater List" forTable:nil];
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    CellButtonsScroll *footerCell = (CellButtonsScroll *) myTable.tableFooterContentPtr.ccCellTypePtr;
    [self turnOnButton:TVC1 inCellBtnArray:footerCell.cellsButtonsArray];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    
    
    //C E L L S    F O R        S E C T I O N S
    
    CellContentDef *cellContentPtr;
    NSMutableDictionary *allLocations = self.liveRuntimePtr.allLocationsHDI;
    NSArray *allLocationKeys = [[self.liveRuntimePtr.allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSString *aKey;
    
    CellUIView *cuvPtr;
    //create cells in section 0
    NSMutableDictionary *aLocDictTMS;
    for (aKey in allLocationKeys){
        aLocDictTMS = [allLocations objectForKey:aKey];
        cuvPtr = [self buildLocationCell:aLocDictTMS withAlignment:NSTextAlignmentLeft withTextColor:viewTextColor andBackGroundColor:viewBackColor];
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
        cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
        cuvPtr.canMyRowHaveTVFocus=YES; //this is special, selectable row like a button
//        [cuvPtr.dataBaseDictsPtrs setObject:aLocDictTMS forKey:kDictionaryTypeLocation];
        cuvPtr.locDict=aLocDictTMS;
        cuvPtr.nextTableView=TVC4;
        cuvPtr.cellDate = [NSDate date];
        cuvPtr.buttonType=kButtonTypeLocation;
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:cuvPtr ];
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
    }
    
    return myTable;
}
-(TableDef *)makeTVC2:(ActionRequest *)pressedButton
{
   
    //
    NSString *tableTitle = @"Movie Information";
    NSMutableDictionary *aLocDict = nil;// [self fetchLocationDict:pressedButton];
    NSLog(@"----makeTVC2    reloadOnly is %d",pressedButton.reloadOnly);
    TableDef *myTable = [self createSection0ScrollingView:pressedButton forProducts:self.liveRuntimePtr.allProductDefinitions_HDI atLocation:aLocDict forNumberOfDays:5 withTableTitle:tableTitle];
    CellButtonsScroll *footerCell = (CellButtonsScroll *) myTable.tableFooterContentPtr.ccCellTypePtr;
    [self turnOnButton:TVC2 inCellBtnArray:footerCell.cellsButtonsArray];
        // rebuild section 2 in all cases
        int section = 1;
        int row = 0;
        CellContentDef *cellContentPtr1, *cellContentPtr2;
        SectionDef *sdPtr2=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
        sdPtr2.sectionHeaderContentPtr=nil;
        sdPtr2.sectionFooterContentPtr=nil;
        [myTable.tableSections addObject:sdPtr2];
    
        NSMutableDictionary *productDict = pressedButton.productDict;//  [self fetchProductDict:pressedButton];
  //       NSString *productName = [productDict objectForKey:kProductNameKey];
        CellUIView *cuvPtr;
        NSLog(@"getting cuvPtr for %@",[pressedButton.productDict objectForKey:@"Title"]);
        NSMutableDictionary*movieInfoDict =[productDict objectForKey:kProductDescriptionKey]; //@"ProductDescription"
        if (![movieInfoDict objectForKey:@"Error"]){
            cuvPtr = [self buildMovieInfoCell:movieInfoDict];
        }else{
            cuvPtr = [self buildMovieInfoCellTMS:productDict];
        }
    cuvPtr.canMyRowHaveTVFocus=NO;//TVOS user shouldn't give focus to me
        cuvPtr.enableUserActivity = NO;
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
        cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
        cellContentPtr2=[[CellContentDef alloc] init];
        cellContentPtr2.ccCellTypePtr=cuvPtr;
  //      cuvPtr.nextTableView = TVC2;
        cellContentPtr2.ccTableViewCellPtr=nil;
       [sdPtr2.sCellsContentDefArr removeAllObjects];
       [sdPtr2.sCellsContentDefArr addObject:cellContentPtr2];
        row ++;
    
 //  add movie trailers
//test with dory.... movieRoot=@"12329215";
        NSMutableArray *trailerArray = self.liveRuntimePtr.movieTrailers;               // YouTubes from trailersapi.com
        NSMutableDictionary *trailersDict;
        if (self.inAVPlayerVC){
            NSMutableDictionary *productDict = pressedButton.productDict;
            NSString *movieRoot = [productDict objectForKey:kMovieUniqueKey];//tms kProductIDKey];
            trailersDict = [self.liveRuntimePtr.allMovieTrailersHDI objectForKey:movieRoot];
            trailerArray = [NSMutableArray arrayWithArray: [trailersDict allValues]];
        }
            
    //return myTable;   //myra fix this
    
    
    CellButtonsScroll *cbsPtr = [self buildMovieTrailerButtonsCell:pressedButton inSection:section inRow:row fromTrailerArray:trailerArray]; //forNumberOfTrailers:3];
        cellContentPtr1=[[CellContentDef alloc] init];
        cellContentPtr1.ccCellTypePtr=cbsPtr;
        cellContentPtr1.ccTableViewCellPtr=nil;
        if (cbsPtr.cellsButtonsArray.count)
            [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
        else{
            [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];   //yes this in as array of 0 elements....required for reload of row to work 
        }
    
    
    return myTable; //tvc2
}
-(TableDef *)makeTVC2Genres:(ActionRequest *)pressedButton
{
    
    

    NSString *tableTitle = @"Movie Information";
    NSMutableDictionary *aLocDict = nil;// [self fetchLocationDict:pressedButton];
    NSLog(@"----makeTVC21    reloadOnly is %d",pressedButton.reloadOnly);
    int section = 0;
    int row = 0;
//    TableDef *myTable = [self createSection0ScrollingView:pressedButton forProducts:self.liveRuntimePtr.allProductDefinitions_HDI atLocation:aLocDict forNumberOfDays:5 withTableTitle:tableTitle];
//    CellButtonsScroll *footerCell = (CellButtonsScroll *) myTable.tableFooterContentPtr.ccCellTypePtr;
 //   [self turnOnButton:TVC2 inCellBtnArray:footerCell.cellsButtonsArray];
    // rebuild section 2 in all cases
    
 /*   section++;
    NSMutableDictionary *genres = [self makeGenresDict:self.liveRuntimePtr.allProductDefinitions_HDI];
    NSArray *sortedGenres = [[genres allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSString *aGenre;
    NSMutableDictionary *allProductsOfThisGenre;
    NSMutableDictionary *aProductDict;
  */
    //for (aGenre in sortedGenres){
 //       allProductsOfThisGenre = [self allProductsOfThisGenre:aGenre inProductsDict:self.liveRuntimePtr.allProductDefinitions_HDI];
 //       for (aProductDict in allProductsOfThisGenre){
 //           NSLog(@"Genre-%@, Title-%@, All Title Genres-%@ ", aGenre, [aProductDict objectForKey:kMovieTitle], [aProductDict objectForKey:kMovieGenre] );
 //       }
//        [self createScrollingViewForGenre:pressedButton forProducts:allProductsOfThisGenre atLocation:aLocDict withTableTitle:tableTitle withGenre:aGenre inSection:section];
 //       section++;
 //           }

    TableDef *myTable = [self createScrollingViewForGenres:pressedButton forProducts:self.liveRuntimePtr.allProductDefinitions_HDI atLocation:aLocDict withTableTitle:tableTitle inSection:section];
    
    //////////////TEST HDR as CELLUIVIEW
    //TEST    CellUIView * cuvPtrHDR=  [self cuvPtrCreateTest];
    //TEST    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    //TEST    cellContentPtr.ccCellTypePtr=cuvPtrHDR;
    //TEST    myTable.tableHeaderContentPtr=cellContentPtr;
    //TEST
    
    NSMutableDictionary *productDict = pressedButton.productDict;
    CellUIView *cuvPtrHDR;
    NSLog(@"getting cuvPtr for %@",[pressedButton.productDict objectForKey:@"Title"]);
    NSMutableDictionary*movieInfoDict =[productDict objectForKey:kProductDescriptionKey]; //@"ProductDescription"
    if (![movieInfoDict objectForKey:@"Error"]){
        cuvPtrHDR = [self buildMovieInfoCell:movieInfoDict];
    }else{
        cuvPtrHDR = [self buildMovieInfoCellTMS:productDict];
    }
    cuvPtrHDR.canMyRowHaveTVFocus=NO;//TVOS user shouldn't give focus to me
    cuvPtrHDR.enableUserActivity = NO;
    cuvPtrHDR.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
    cuvPtrHDR.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
    CellContentDef *cellContentPtrHDR=[[CellContentDef alloc] init];
    cellContentPtrHDR.ccCellTypePtr=cuvPtrHDR;
    //      cuvPtr.nextTableView = TVC2;
    cellContentPtrHDR.ccTableViewCellPtr=nil;
    
    myTable.tableHeaderContentPtr=cellContentPtrHDR;
    

   
    
    
    
    return myTable;
    
    
    
    CellContentDef *cellContentPtr1, *cellContentPtr2;
    SectionDef *sdPtr2=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr2.sectionHeaderContentPtr=nil;
    sdPtr2.sectionFooterContentPtr=nil;
    [myTable.tableSections addObject:sdPtr2];
    
   // NSMutableDictionary *productDict = pressedButton.productDict;//  [self fetchProductDict:pressedButton];
    //       NSString *productName = [productDict objectForKey:kProductNameKey];
    CellUIView *cuvPtr;
    NSLog(@"getting cuvPtr for %@",[pressedButton.productDict objectForKey:@"Title"]);
    //NSMutableDictionary*movieInfoDict =[productDict objectForKey:kProductDescriptionKey]; //@"ProductDescription"
    if (![movieInfoDict objectForKey:@"Error"]){
        cuvPtr = [self buildMovieInfoCell:movieInfoDict];
    }else{
        cuvPtr = [self buildMovieInfoCellTMS:productDict];
    }
    cuvPtr.canMyRowHaveTVFocus=NO;//TVOS user shouldn't give focus to me
    cuvPtr.enableUserActivity = NO;
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
    cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
    cellContentPtr2=[[CellContentDef alloc] init];
    cellContentPtr2.ccCellTypePtr=cuvPtr;
    //      cuvPtr.nextTableView = TVC2;
    cellContentPtr2.ccTableViewCellPtr=nil;
    [sdPtr2.sCellsContentDefArr removeAllObjects];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr2];
    row ++;
    
    //  add movie trailers
    //test with dory.... movieRoot=@"12329215";
    NSMutableArray *trailerArray = self.liveRuntimePtr.movieTrailers;               // YouTubes from trailersapi.com
    NSMutableDictionary *trailersDict;
    if (self.inAVPlayerVC){
        NSMutableDictionary *productDict = pressedButton.productDict;
        NSString *movieRoot = [productDict objectForKey:kMovieUniqueKey];//tms kProductIDKey];
        trailersDict = [self.liveRuntimePtr.allMovieTrailersHDI objectForKey:movieRoot];
        trailerArray = [NSMutableArray arrayWithArray: [trailersDict allValues]];
    }
    
    //return myTable;   //myra fix this
    
    
    CellButtonsScroll *cbsPtr = [self buildMovieTrailerButtonsCell:pressedButton inSection:section inRow:row fromTrailerArray:trailerArray]; //forNumberOfTrailers:3];
    cellContentPtr1=[[CellContentDef alloc] init];
    cellContentPtr1.ccCellTypePtr=cbsPtr;
    cellContentPtr1.ccTableViewCellPtr=nil;
    if (cbsPtr.cellsButtonsArray.count)
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    else{
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];   //yes this in as array of 0 elements....required for reload of row to work
    }
    
    
    return myTable; //tvc2
}
-(NSMutableDictionary*)makeGenresDict:(NSMutableDictionary*)allProductsDict
{
    NSMutableDictionary *allMovieGenres = [[NSMutableDictionary alloc] init];
    NSArray *allProductIDs = [[allProductsDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableDictionary *aProductDict;
    NSMutableDictionary *aProductGenresDict;
    for (NSString *aProductID in allProductIDs){
        aProductDict = [allProductsDict  objectForKey:aProductID];
        aProductGenresDict= [self aProductGenres:aProductDict];
 //       NSString *productGenreStr = [aProductDict objectForKey:kMovieGenre];
//        NSArray *genreArray = [productGenreStr componentsSeparatedByString: @","];
        NSArray *genreArray = [[aProductGenresDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *genre in genreArray){
            [allMovieGenres removeObjectForKey:genre];
            [allMovieGenres setObject:genre forKey:genre];
        }
                                                       
    }
        
    
    return allMovieGenres;
}

-(NSMutableDictionary *)aProductGenres:(NSMutableDictionary *)aProductDict
{
    NSMutableDictionary *aProductGenresDict= [[NSMutableDictionary alloc] init];
    NSString *productGenreStr = [aProductDict objectForKey:kMovieGenre];
    NSArray *genreArray = [productGenreStr componentsSeparatedByString: @", "];
    for (NSString *genre in genreArray){
        [aProductGenresDict removeObjectForKey:genre];
        [aProductGenresDict setObject:genre forKey:genre];
    }
    return aProductGenresDict;
}

-(NSMutableDictionary*)allProductsOfThisGenre:(NSString *)genre inProductsDict:(NSMutableDictionary *)allProductsDict
{
    NSMutableDictionary *allProductsOfGenre = [[NSMutableDictionary alloc] init];
    NSArray *allProductIDs = [[allProductsDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableDictionary *aProductDict;
    NSMutableDictionary *aProductGenresDict;
    NSString *testForGenre;
    for (NSString *aProductID in allProductIDs){
        aProductDict = [allProductsDict objectForKey:aProductID];
        aProductGenresDict = [self aProductGenres:aProductDict];
        testForGenre = [aProductGenresDict objectForKey:genre];
        if (testForGenre){
            [allProductsOfGenre setObject:aProductDict forKey:aProductID];
        }
    }
    return allProductsOfGenre;
}

-(TableDef *)makeTVC3:(ActionRequest *)pressedButton
{
    TableDef *myTable;
    NSLog(@"----makeTVC3");
    myTable = [self createFixedTableHeaderUsingText:@"Locate Where Showing" forTable:nil];
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    CellButtonsScroll *footerCell = (CellButtonsScroll *) myTable.tableFooterContentPtr.ccCellTypePtr;
    [self turnOnButton:TVC3 inCellBtnArray:footerCell.cellsButtonsArray];
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    NSMutableDictionary *aProductDict;
//    NSString *productName;
    NSMutableDictionary *productDictionaryWithNameAsKey = [self buildProductsDictionaryWithNameKey:self.liveRuntimePtr.allProductDefinitions_HDI] ;
    NSArray *allProductNames = [[productDictionaryWithNameAsKey allKeys] sortedArrayUsingSelector:@selector(compare:)];
    CellContentDef *cellContentPtr;
    CellUIView *ctdPtr;
  //button cells section 1      B U T T O N S
    NSMutableArray *hdiButtons;
    int section = 0;
    int row = 0;
    int numberOfButtonsPerCell = 2;
    ActionRequest *aBtn;
    CGSize btn2Size = CGSizeMake(sizeGlobalButton.width*2, sizeGlobalButton.height*6);//CGSizeMake(120, 180);
    
    
    for (NSInteger keyIndex = 0; keyIndex < allProductNames.count; ){
//        hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfButtonsPerCell withTotalNumberOfBtns:allProductNames.count withButtonSize:btn2Size];
        hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfButtonsPerCell withTotalNumberOfBtns:allProductNames.count withStartingIndex:row*numberOfButtonsPerCell withButtonSize:btn2Size];
        for (aBtn in hdiButtons){
            aProductDict = [productDictionaryWithNameAsKey objectForKey:[allProductNames objectAtIndex:keyIndex]];
            aBtn.buttonName = [aProductDict objectForKey:kMovieTitle];
            aBtn.buttonLabel =  nil;
            aBtn.buttonImage = [aProductDict objectForKey:kProductImageKey];
            aBtn.nextTableView = TVC6;// TVC10;
            aBtn.buttonIsOn=YES;
//            [self putProductDictInParent:aBtn productDict:aProductDict];
            aBtn.productDict=aProductDict;
            aBtn.buttonType=kButtonTypeProduct;
            keyIndex++;
            if (keyIndex >= allProductNames.count)
                break;
                        
        }
        
        ctdPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdiButtons isCollectionView:NO];// buttonScroll:YES];
        [hdiButtons removeAllObjects];
        hdiButtons = nil;
        //       ctdPtr.dataRecords = pressedButton.dataRecords;
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        row = row + 1;
    }
    
     return myTable;
    
 }

-(TableDef *)makeTVC4:(ActionRequest *)pressedButton
{
    NSLog(@"----makeTVC4   reloadOnly is %d",pressedButton.reloadOnly);

    
               //C E L L S    F O R        S E C T I O N S
    
        NSMutableDictionary *aLocDict =  pressedButton.locDict;  // [self fetchLocationDict:pressedButton];
        NSString *locationName = [aLocDict objectForKey:kLocationNameKey];
        NSString *tableTitle = [NSString stringWithFormat:@"Playing at - %@",locationName];
   
    
        TableDef *myTable = [self createSection0ScrollingView:pressedButton forProducts:self.liveRuntimePtr.allProductDefinitions_HDI atLocation:aLocDict forNumberOfDays:5 withTableTitle:tableTitle];
    
    
        // Section 2 Starts Here , First The Movie Title and Short Description
        CellContentDef *cellContentPtr1;//, *cellContentPtr2;
        SectionDef *sdPtr2=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
        sdPtr2.sectionHeaderContentPtr=nil;
        sdPtr2.sectionFooterContentPtr=nil;
        [myTable.tableSections addObject:sdPtr2];
        int section = 1;
        int row = 0;

        NSMutableDictionary* aProductDict = pressedButton.productDict;  //[self fetchProductDict:pressedButton];
        CellUIView *cuvPtr =[[CellUIView alloc]init];
        CellTextDef  * txtTypePtr=[CellTextDef initCellText:[aProductDict objectForKey:kMovieTitle] withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];   //was font size 16
        txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
        [cuvPtr.cTextDefsArray addObject:txtTypePtr];
        CellTextDef  * txtTypePtr1=[CellTextDef initCellText:[aProductDict objectForKey:kMoviePlot]  withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil];   //was font size 12
        txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
        [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
    
        cuvPtr.displayTemplate= kDISP_TEMPLATE_LABELS_ONLY;//kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT;//kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP;  //template layout for container
        cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:cuvPtr];
    cuvPtr.canMyRowHaveTVFocus=NO;
        cuvPtr.nextTableView = TVC4;
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    // Now add the Movie Show Time Cells
        row++;
        NSMutableDictionary *inventoryDict = self.liveRuntimePtr.allProductInventory_HDI;
    
    
        NSString *productID = [aProductDict objectForKey:kMovieUniqueKey];
    
        NSMutableArray *showingsArray = [inventoryDict objectForKey:productID];
    

        NSMutableArray *todaysShowings = [self showingsForNSDate:pressedButton.buttonDate inShowings:showingsArray atLocation:aLocDict];
    
    
  //      NSMutableDictionary*showTimesDict = [self buildShowtimesButtonsDict:todaysShowings];
        NSMutableDictionary *showTimesDictOfArrays = [self buildShowtimesButtonsDictOfArrays:todaysShowings]; //
        NSArray *showingsGroupKeys = [showTimesDictOfArrays allKeys];
        NSString *aGroupKey;
        NSMutableArray *aShowingsGroup;

    
        NSMutableDictionary *aShowing;
        CellTextDef *txtTypePtr2;
      //  CellButtonsScroll *cButPtr;
 //       NSString *groupQuals;
    
    
    
    
        for (aGroupKey in showingsGroupKeys){
            aShowingsGroup = [showTimesDictOfArrays objectForKey:aGroupKey];
            
            aShowing = [aShowingsGroup objectAtIndex:0];
            CellUIView *cuvPtr =[[CellUIView alloc]init];
            // [aShowing objectForKey:kProductQualsKey];
            txtTypePtr2=[CellTextDef initCellText:aGroupKey withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil]; //was font size 10
            txtTypePtr2.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
            [cuvPtr.cTextDefsArray addObject:txtTypePtr2];
            row++;
            cellContentPtr1=[[CellContentDef alloc] init];
            cellContentPtr1.ccCellTypePtr=cuvPtr;
            cuvPtr.canMyRowHaveTVFocus=NO;
            cellContentPtr1.ccTableViewCellPtr=nil;
            [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
            
            row = [self buildShowTimesBtnsCells:aShowingsGroup inSection:section inRow:row forProduct:aProductDict inLocation:aLocDict buttonsPerRow:5 sectionDef:sdPtr2];
  

            NSLog(@"");
 /*
            cButPtr = [self buildShowTimesBtnsArray:aShowingsGroup inSection:section inRow:row forProduct:aProductDict inLocation:aLocDict];
            cellContentPtr1=[[CellContentDef alloc] init];
            cellContentPtr1.ccCellTypePtr=cButPtr;
            cellContentPtr1.ccTableViewCellPtr=nil;
            [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
            row++;
*/
        
        }
    //THIS IS RELOAD-ABLE.  THAT means we cannot change the size of the tableview cells once they are build initially. (trap occurs)
    //
    
    [self forceSectionReloadABLEwithMaxCells:10 sectionDef:sdPtr2 ];
    
 /*
        NSMutableArray *allDigitalShowTimes = [[NSMutableArray alloc] init];
        NSMutableArray *all3DshowTimes = [[NSMutableArray alloc] init];

        NSMutableDictionary *aShowing;
        NSString *testFor3D;
        NSMutableDictionary *qualsDict;
        NSString *tmsQuals;
        for (aShowing in todaysShowings){
            tmsQuals = [aShowing objectForKey:kProductQualsKey];
            qualsDict = [self parseQualsAndMakeDict:tmsQuals];
            testFor3D = [qualsDict objectForKey:kProduct3DKey];
            if (testFor3D){
                [all3DshowTimes addObject:aShowing];
            }else{
                [allDigitalShowTimes addObject:aShowing];
            }
        }
    if (all3DshowTimes.count){
       CellButtonsScroll *cButPtr1 = [self buildShowTimesBtnsArray:all3DshowTimes inSection:section inRow:row  forProduct:aProductDictTMS inLocation:aLocDict];// is3D:YES];// allShowingCount:todaysShowings.count];
        cellContentPtr1=[[CellContentDef alloc] init];
        cellContentPtr1.ccCellTypePtr=cButPtr1;
        cellContentPtr1.ccTableViewCellPtr=nil;
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
         row++;
    }
   
    if (allDigitalShowTimes.count){
        CellButtonsScroll *cButPtr2 = [self buildShowTimesBtnsArray:allDigitalShowTimes inSection:section inRow:row forProduct:aProductDictTMS inLocation:aLocDict];// is3D:NO];// allShowingCount:todaysShowings.count];
        cellContentPtr2=[[CellContentDef alloc] init];
        cellContentPtr2.ccCellTypePtr=cButPtr2;
        cellContentPtr2.ccTableViewCellPtr=nil;
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr2];
    }
   */
//    }
    //   }
    
    return myTable;
}
-(TableDef*) makeTVC5:(ActionRequest*)pressedBtn
{
 //   NSLog(@"trailerPath = %@",pressedBtn.trailerPath);
    TableDef *myTable = nil;
    pressedBtn.nextTableView = TVC2;
    pressedBtn.reloadOnly = NO;
 //   return [self makeTVC2:pressedBtn];
    NSLog(@"trailerPath = %@",pressedBtn.trailerPath);
    NSURL *trailerURL = [NSURL URLWithString:pressedBtn.trailerPath];
    NSLog(@"trailerURL = %@",trailerURL);
    
    NSLog(@"----makeTVC5");
 //   NSString *trailerName = [pressedBtn.trailerPath lastPathComponent];
//    myTable = [self createFixedTableHeaderUsingText:trailerName forTable:nil];
//    CGSize btnSize = CGSizeMake(60, 30);
    
//    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
 //    myTable = [self createFixedTableHeaderUsingText:@"Trailer View" forTable:nil];
    myTable = [self createEmptyTableDef:myTable];
    SectionDef *sdPtr1;
   // CellContentDef *cellContentPtr1;

    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;

    [myTable.tableSections addObject:sdPtr1];
//    CellButtonsScroll *cButPtr2 = [self buildShowTimesBtnsArray:allDigitalShowTimes inSection:section inRow:row forProduct:aProductDictTMS inLocation:aLocDict];// is3D:NO];// allShowingCount:todaysShowings.count];
    if (inAVPlayerVC){
        
        NSURL *videoURL = [NSURL URLWithString:pressedBtn.trailerPath];
        AVPlayer *player = [AVPlayer playerWithURL:videoURL];
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        playerViewController.player = player;
        NSLog(@"globaltableproto Pre-presentvideocontroller  makeTVC5:");
        
        //has to be rootviewcontroller
        [self.liveRuntimePtr.holdVCtrler presentViewController:playerViewController animated:YES completion:nil];
        
        
        //3 gives warining  "Presenting view controllers on detached view controllers is discouraged"
        //3dispatch_async(dispatch_get_main_queue(), ^{
        //3    [self.liveRuntimePtr.rtTableViewCtrler presentViewController:playerViewController animated:YES completion:nil];
        //3});
   
          //2 tried - constraint warning, adds it but at top left corner, not own view
        //2[self.liveRuntimePtr.rtTableViewCtrler addChildViewController:playerViewController];
        //2[self.liveRuntimePtr.rtTableViewCtrler.view addSubview:playerViewController.view];
        //2[playerViewController didMoveToParentViewController:self.liveRuntimePtr.rtTableViewCtrler];
        
        //1 tried - constraint warning, adds it but at top left corner, not own view
        //1[self.liveRuntimePtr.rtTableViewCtrler addChildViewController:playerViewController];
        //1[self.liveRuntimePtr.rtTableViewCtrler.view addSubview:playerViewController.view];
        //1 traps [self.liveRuntimePtr.rtTableViewCtrler presentViewController:playerViewController animated:YES completion:nil];
        
        //0gives warining  "Presenting view controllers on detached view controllers is discouraged"
        //0 [self.liveRuntimePtr.rtTableViewCtrler presentViewController:playerViewController animated:YES completion:nil];
        
        //not working [self.liveRuntimePtr.rtTableViewCtrler.parentViewController presentViewController:playerViewController animated:YES completion:nil];
        [player play];   //this one
        return nil;
    }else{
       // NSDictionary *playerVars = @{
       //                              @"playsinline" : @1,
       //                              };
        
 /*
        CGSize fullScreenSize = [UIScreen mainScreen].bounds.size;
        YTPlayerView  *ytPlayerView = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, fullScreenSize.width, fullScreenSize.height)];
        //[self.ytPlayerView loadWithVideoId:@"9l3DDSXkEQ0" playerVars:playerVars];
//        [ytPlayerView loadWithVideoId:@"M7lc1UVf-VE"];
//        [ytPlayerView loadWithVideoId:pressedBtn.trailerPath];  //@"9l3DDSXkEQ0"];
        ytPlayerView.backgroundColor = self.viewBackColor;// [UIColor greenColor];
        //        [self.ytPlayerView playVideo];
//        ytPlayerView.delegate = self;
*/
        YTViewController  *ytVC = [[YTViewController alloc] init];
        ytVC.ytVidioID = pressedBtn.trailerPath;
//        [ytVC.view addSubview:ytPlayerView];
        [self.liveRuntimePtr.rtTableViewCtrler presentViewController:ytVC animated:YES completion:nil];
//        [ytPlayerView playVideo];
        return nil;
//        [tvcellPtr addSubview:self.ytPlayerView];
//        ytPlayerView.center = tvcontrollerPtr.view.center;
    
   /*
    CGSize movieViewSize =  [UIScreen mainScreen].bounds.size;//CGSizeMake(320,240);
    CellMovieView *cmvPtr = [CellMovieView initCellDefaultsWithBackColor:viewBackColor withCellSize:movieViewSize forActionRequest:pressedBtn inAVPlayerVC:self.inAVPlayerVC];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    cellContentPtr1.ccCellTypePtr=cmvPtr;
    cellContentPtr1.ccTableViewCellPtr=nil;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
//    actionForReloadingView=pressedBtn;

*/
    }
       return myTable;
    
}
-(TableDef *) makeTVC6:(ActionRequest *)pressedButton
{
    NSLog(@"----makeTVC6");
    TableDef *myTable;
    NSMutableDictionary *aProductDict = pressedButton.productDict; //[self fetchProductDict:pressedButton];
    NSString *movieName = [aProductDict objectForKey:kMovieTitle];
    self.liveRuntimePtr.rtTableViewCtrler.view.backgroundColor=viewBackColor;
    
    SectionDef *sdPtr;
    CellContentDef *cellContentPtr;//,*cellContentPtr1;
 //   NSString *tableTitle = [NSString stringWithFormat:@"Theaters Showing - %@",[aProductDict objectForKey:kProductNameKey]];
    NSString *tableTitle = @"Movie Details";
    CGSize sechdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    CGSize ftrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    int section = 0;
    myTable = [self createFixedTableHeaderUsingText:tableTitle forTable:nil];
    sdPtr = nil;
    sdPtr = [self createDateButtonsAsSectionHeader:sdPtr sectionNumber:0 inTable:myTable actionReq:pressedButton withButtonSize:sechdrBtnSize];// nextTVC:TVC2];
    
    CellButtonsScroll* hdrCell = (CellButtonsScroll *)sdPtr.sectionHeaderContentPtr.ccCellTypePtr;
    myTable =[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:ftrBtnSize];// buttonsScroll:NO];
    [self turnOnSelectedDateBtn:selectedDate inCellBtnArray:hdrCell.cellsButtonsArray];
    
    //    sdPtr.sectionHeaderContentPtr=nil;
    //    sdPtr.sectionFooterContentPtr=nil;
    [myTable.tableSections addObject:sdPtr];
    
    CellContentDef *floatSecPtr;
#if TARGET_OS_TV
    floatSecPtr=sdPtr.sectionHeaderContentPtr;
    sdPtr.sectionHeaderContentPtr=nil;
    [sdPtr.sCellsContentDefArr addObject:floatSecPtr];
    floatSecPtr.ccCellTypePtr.usedByHeaderOrFooter=NO;

#endif

    
    
    
    
    CGSize picSize = sizeGlobalPoster;//CGSizeMake(80,120);
    NSString *productName = [aProductDict objectForKey:kMovieTitle];
    NSString *shortDesc = [aProductDict objectForKey:kMovieShortDescr];
    if (!shortDesc) {
        shortDesc=[aProductDict objectForKey:kMoviePlot];
    }
  //  NSString *longDesc  = [aProductDict objectForKey:kProductDescriptionLongKey];
  //  NSString *displayStr = [NSString stringWithFormat:@"%@n%@",productName,shortDesc];
    NSString *runTime = [aProductDict valueForKeyPath:kMovieRuntime];
    NSString *releaseDate = [aProductDict valueForKeyPath:kMovieReleased];
    NSString *rated = [aProductDict valueForKeyPath:kMovieRated];
    NSString *genre = [aProductDict valueForKeyPath:kMovieGenre];
    
    
    //CellImageLTextR *citPtr = [CellImageLTextR initCellWithImageAndText:displayStr withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:16 withTextFontName:nil withImage:[aProductDict objectForKey:kProductImageKey] withImageName:movieName withImageBackColor:viewBackColor withSize:picSize];
    //citPtr.nextTableView=TVC6;
    
    
    
    
    NSMutableArray *arrayOfStrings=[[NSMutableArray alloc]init];
    [arrayOfStrings addObject: [NSString stringWithFormat:@"%@",productName]];
    [arrayOfStrings addObject: [NSString stringWithFormat:@"%@",shortDesc]];
    
    if (rated || runTime) {
        [arrayOfStrings addObject: [NSString stringWithFormat:@"%@ | %@",rated,runTime]];
    }
    
    [arrayOfStrings addObject: [NSString stringWithFormat:@"%@",genre]];
    [arrayOfStrings addObject: [NSString stringWithFormat:@"%@",releaseDate]];
    CellUIView *ctdPtr=[CellUIView mkcuvImageLeft:[aProductDict objectForKey:kProductImageKey] withImageName:movieName andImageSize:picSize andTextsArrayRight:arrayOfStrings useTextSizeTopCell:sizeGlobalTextFontBig useTextSizeAdditionalCells:sizeGlobalTextFontSmall withBackGroundColor:viewBackColor withTextColor:viewTextColor];   //was text size 16
    ctdPtr.canMyRowHaveTVFocus=NO;
    ctdPtr.enableUserActivity=NO;  //tvos should not give focus to me
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;   //not citPtr
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    
    /*
     CellTextDef  * txtTypePtr=[CellTextDef initCellText:[aProductDict objectForKey:kProductDescriptionShortKey]  withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:12 withTextFontName:nil];
     txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
     //    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
     //    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
     
     //    cuvPtr.displayTemplate= kDISP_TEMPLATE_LABELS_ONLY;//kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT;//kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP;  //template layout for container
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:txtTypePtr andTableViewCellPtr:nil];
     txtTypePtr.nextTableView = TVC6;
     [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
     */
    
    
    
    //   CellUIView *cuvPtr;
    
    
    //C E L L S    F O R        S E C T I O N S
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    //    [dateFormatter setDateFormat:@"MMM dd"];
    
    
    //    NSString *aShowingDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *aLocDict;
    NSMutableDictionary *allLocations = self.liveRuntimePtr.allLocationsHDI;
    NSArray *allLocationKeys = [[self.liveRuntimePtr.allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];;
    NSString *aKey;
    section = 1;
    NSMutableDictionary *inventoryDict = self.liveRuntimePtr.allProductInventory_HDI;
    NSString *productID = [aProductDict objectForKey:kMovieUniqueKey];
    NSMutableArray *showingsArray = [inventoryDict objectForKey:productID];
    //   NSMutableArray *showingsArray = [aProductDict objectForKey:kProductInventoryKey];
    for (aKey in allLocationKeys){
        int row = 0;
        aLocDict = [allLocations objectForKey:aKey];
        
        //        NSMutableArray *todaysShowings = [self showingsForNSDate:pressedButton.buttonDate inShowings:showingsArray atLocation:aLocDict];
        NSMutableArray *todaysShowings = [self showingsForNSDate:selectedDate inShowings:showingsArray atLocation:aLocDict];
        //     if (![self addInfoToProductDictTMSonNSDate:aProductDictTMS forLocation:aLocDictTMS onDate:[NSDate date]])
        //        if ([self isProductAvailableAtLocationOnDate:aProductDict forLocation:aLocDict onDate:[NSDate date]])
        if (!todaysShowings.count)
            continue;
        sdPtr=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
        sdPtr.sectionHeaderContentPtr=nil;
        sdPtr.sectionFooterContentPtr=nil;
        
        [myTable.tableSections addObject:sdPtr];//        NSArray *showTimes = [aProductDict objectForKey: @"ProductTimesArray"];
        //        NSLog(@"Showings NSDates = %@",showTimes);
        CellUIView *cuvPtr = [self buildLocationCell:aLocDict withAlignment:NSTextAlignmentLeft withTextColor:viewTextColor andBackGroundColor:viewBackColor];
        //  cuvPtr = [self buildLocationCell:aLocDict withAlignment:NSTextAlignmentLeft];
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
        cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
        cuvPtr.canMyRowHaveTVFocus=NO;
        //       cuvPtr.dataBaseDict = aLocDict;
        //        [cuvPtr.dataBaseDictsPtrs setObject:aLocDict forKey:kDictionaryTypeLocation];
        cuvPtr.locDict=aLocDict;
        //        cuvPtr.aLocDict = aLocDict;
        cuvPtr.nextTableView=TVC4;
        cuvPtr.cellDate = [NSDate date];
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:cuvPtr ];
        [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
        row++;
        // Now add the Movie Show Time Cells
        
        //       NSMutableArray *showingsArray = [aProductDict objectForKey:kProductInventoryKey];
        //        NSMutableArray *todaysShowings = [self showingsForNSDate:pressedButton.buttonDate inShowings:showingsArray atLocation:aLocDict];
        //        NSMutableArray *todaysShowings = [self showingsForNSDate:[NSDate date] inShowings:showingsArray atLocation:aLocDict];
        //      NSMutableDictionary*showTimesDict = [self buildShowtimesButtonsDict:todaysShowings];
        NSMutableDictionary *showTimesDictOfArrays = [self buildShowtimesButtonsDictOfArrays:todaysShowings]; //
        NSArray *showingsGroupKeys = [showTimesDictOfArrays allKeys];
        NSString *aGroupKey;
        NSMutableArray *aShowingsGroup;
        
        
        //        NSMutableDictionary *aShowing;
        CellTextDef *txtTypePtr2;
 //       CellButtonsScroll *cButPtr;
        //       NSString *groupQuals;
        for (aGroupKey in showingsGroupKeys){
            aShowingsGroup = [showTimesDictOfArrays objectForKey:aGroupKey];
            
            //            aShowing = [aShowingsGroup objectAtIndex:0];
            
            CellUIView *cuvPtr =[[CellUIView alloc]init];
            // [aShowing objectForKey:kProductQualsKey];
            txtTypePtr2=[CellTextDef initCellText:aGroupKey withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil];  //was text font 10
            txtTypePtr2.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
            [cuvPtr.cTextDefsArray addObject:txtTypePtr2];
            cuvPtr.canMyRowHaveTVFocus=NO;
            row++;
            
            cellContentPtr=[[CellContentDef alloc] init];
            cellContentPtr.ccCellTypePtr=cuvPtr;
            cellContentPtr.ccTableViewCellPtr=nil;
            [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
            
            
            row = [self buildShowTimesBtnsCells:aShowingsGroup inSection:section inRow:row forProduct:aProductDict inLocation:aLocDict buttonsPerRow:5 sectionDef:sdPtr];
            
            /*
             cButPtr = [self buildShowTimesBtnsArray:aShowingsGroup inSection:section inRow:row forProduct:aProductDict inLocation:aLocDict];
             cellContentPtr=[[CellContentDef alloc] init];
             cellContentPtr.ccCellTypePtr=cButPtr;
             cellContentPtr.ccTableViewCellPtr=nil;
             [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
             row++;
             */
            
        }
        
        section++;
    }
    
    
    return myTable;
}
// Build Purchase Order

-(TableDef *) makeTVC8:(ActionRequest *)pressedBtn
{
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [dayFormatter setDateFormat:@"MMM dd"];
    NSLog(@"----makeTVC8Ticket");
    NSMutableDictionary *aProductDict = selectedProdcuctDict;//pressedBtn.productDict; //[self fetchProductDict:pressedBtn];
//    aProductDict = pressedBtn.aProductDict;
    NSMutableArray *purchaseArray =  [aProductDict objectForKey:kPurchaseDictionaryArrayKey];
    PurchaseRecord *aPurchase = [purchaseArray objectAtIndex:0];
//    NSMutableDictionary *aLocDict =  [self.liveRuntimePtr.allLocationsHDI objectForKey:[aProductDict objectForKey:kLocationNameKey]];
    aPurchase.purchaseLocDict = selectedLocDict;// pressedBtn.locDict;// aLocDict;
    aPurchase.aProductDict =  aProductDict;
    aPurchase.purchaseDate = [dayFormatter stringFromDate:selectedDate]; //[aProductDict objectForKey:kLocationDate]; //aProduct.locationDate;
    aPurchase.purchaseTime = pressedBtn.aTime;
     NSString *showingDate = [NSString stringWithFormat:@"%@ %@",aPurchase.purchaseDate,aPurchase.purchaseTime];
    NSLog(@"Selected Theater = %@, Selecte Movie = %@, Showing Date = %@, Showtime = %@",[aPurchase.purchaseLocDict objectForKey:kLocationNameKey],[aPurchase.aProductDict   objectForKey:kMovieTitle], aPurchase.purchaseDate, aPurchase.purchaseTime);
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;
    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    
    
    SectionDef *sdPtr1;
    CellContentDef *cellContentPtr;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    CellUIView *cuvPtr;
//    cuvPtr = [self buildLocationCell:aPurchase.purchaseLocDict withAlignment:NSTextAlignmentCenter];
    cuvPtr = [self buildLocationCell:selectedLocDict withAlignment:NSTextAlignmentCenter withTextColor:viewTextColor andBackGroundColor:viewBackColor];
    CellTextDef  *txtTypePtr1;
    txtTypePtr1=[CellTextDef initCellText:[aPurchase.aProductDict objectForKey:kMovieTitle] withTextColor:[UIColor whiteColor] withBackgroundColor: viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    
    txtTypePtr1=[CellTextDef initCellText:showingDate withTextColor:[UIColor whiteColor] withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:cuvPtr];// andTableViewCellPtr:nil];
    
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
 //   cuvPtr = [self buildLocationCell:selectedLocDict withAlignment:NSTextAlignmentCenter withTextColor:viewTextColor andBackGroundColor:viewBackColor];
    cuvPtr=[[CellUIView alloc] init];
//    cuvPtr.backgoundColor=[UIColor orangeColor];
    NSMutableDictionary *purchaseInfo;
    TransactionData *dataField0;
    NSString *inputFieldLabel;
    for (purchaseInfo in aPurchase.allPurchaseTypes){
        CellTextDef *placeholderTxt;
        CellInputField *entryFPtr=[[CellInputField alloc]init];
        NSNumber *quantityNum = [purchaseInfo objectForKey:kPurchaseQuantityKey];
        NSString *quantityStr = [quantityNum stringValue];
        
        placeholderTxt=[CellTextDef initCellText:quantityStr withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor orangeColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
        
        placeholderTxt.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
        if (entryFPtr.placeholderTextDefPtr) {
            [entryFPtr.placeholderTextDefPtr killYourself];
        }
        inputFieldLabel = [NSString stringWithFormat:@"Number Of %@ Tickets:",[purchaseInfo objectForKey:kPurchaseTypeKey]];
        entryFPtr.placeholderTextDefPtr=placeholderTxt;
        entryFPtr.leftSideDispTextPtr=[CellTextDef initCellText:inputFieldLabel withTextColor:[UIColor whiteColor] withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
        entryFPtr.leftSideDispTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentRight;
        entryFPtr.keyboardType = UIKeyboardTypeNumberPad;
        
        
        NSString *helpT= inputFieldLabel;
        
        entryFPtr.helpTextPtr=[CellTextDef initCellText:helpT withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
        entryFPtr.helpTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
        
        
        
        dataField0=[[TransactionData alloc]init];
        dataField0.queryKey=[purchaseInfo objectForKey:kPurchaseTypeKey];//[request setPostValue:theUserID forKey:@"validUserID"];
        [myTable.tableVariablesArray addObject:dataField0];//[dbTrans.variablesArray addObject:dataField0];
        entryFPtr.transDataPtr=dataField0;
        
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=entryFPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
    }
    
    
    
    int ticketStrLength = 8;
    int priceStrLength = 6;
    int qtyStrLength = 4;
    int totalStrLenth = 6;
    NSString *ticket = [self leftJustifyString:@"Ticket" withLength:ticketStrLength] ;
    NSString *price = [self rightJustifyString:@"Price" withLength:priceStrLength];
    NSString *qty = [self rightJustifyString:@"Qty" withLength:qtyStrLength] ;
    NSString *total = [self rightJustifyString:@"Total" withLength:totalStrLenth];
    NSString *hdrStr = [NSString stringWithFormat:@"%@%@%@%@",ticket,price,qty,total];
    txtTypePtr1=[CellTextDef initCellText:hdrStr withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor orangeColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:@"Menlo-Bold"];
    txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    
    
    float totalCost = 0;
 //   NSMutableDictionary *purchaseInfo;
    NSString *purchaseType;
    NSNumber *purchasePrice;
    NSNumber *purchaseQty;
    float ticketTypeCost;
    
//    int ticketStrLength = 8;
//    int priceStrLength = 5;
//    int qtyStrLength = 3;
//    int totalStrLenth = 6;
    for (purchaseInfo in aPurchase.allPurchaseTypes){
        purchaseType = [purchaseInfo objectForKey:kPurchaseTypeKey];
        purchasePrice = [purchaseInfo objectForKey:kPurchasePriceKey];
        purchaseQty = [purchaseInfo objectForKey:kPurchaseQuantityKey];
        totalCost = totalCost + [purchasePrice floatValue] * [purchaseQty floatValue];
    
//    txtTypePtr1=[CellTextDef initCellText:[NSString stringWithFormat:@"%@ Price = %2.2f",purchaseType, [purchasePrice floatValue]]  withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ticketTypeCost = [purchasePrice floatValue] * [purchaseQty integerValue];
    NSString *leftJustifiedPurchaseType = [self leftJustifyString:purchaseType withLength:ticketStrLength];
    NSString *rightJustifiedPrice = [self rightJustifyString:[purchasePrice stringValue] withLength:priceStrLength];
    NSString *rightJustifiedQty = [self rightJustifyString:[purchaseQty stringValue] withLength:qtyStrLength];
    NSString *rightJustifiedTotal = [self rightJustifyString:[NSString stringWithFormat:@"%3.2f",ticketTypeCost] withLength:totalStrLenth];
    txtTypePtr1=[CellTextDef initCellText:[NSString stringWithFormat:@"%@%@%@%@",leftJustifiedPurchaseType, rightJustifiedPrice, rightJustifiedQty, rightJustifiedTotal]  withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor orangeColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:@"Menlo-Bold"];  // monospaced font
    
//    txtTypePtr1=[CellTextDef initCellText:[NSString stringWithFormat:@"%@      %2.2f    %li      %3.2f",purchaseType, [purchasePrice floatValue], (long)[purchaseQty integerValue], ticketTypeCost ]  withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];

    txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    
    
    }
    
 
   // float totalCost = theShowing.adultPrice*theShowing.numberOfAdults + theShowing.childPrice*theShowing.numberOfChildren + theShowing.matineePrice*theShowing.numberOfMatinees;
    txtTypePtr1=[CellTextDef initCellText:[NSString stringWithFormat:@"Total Cost = %3.2f",totalCost]  withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor orangeColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    txtTypePtr1.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    
    cuvPtr.enableUserActivity = NO;
    
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
    cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
//    cuvPtr.dataRecords=pressedBtn.dataRecords;
//    cuvPtr.dataRecordKey=pressedBtn.dataRecordKey;
    cuvPtr.nextTableView=TVC8;
    
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:cuvPtr];// andTableViewCellPtr:nil];
    
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
/*
    TransactionData *dataField0;
    NSString *inputFieldLabel;
    for (purchaseInfo in aPurchase.allPurchaseTypes){
        CellTextDef *placeholderTxt;
        CellInputField *entryFPtr=[[CellInputField alloc]init];
        NSNumber *quantityNum = [purchaseInfo objectForKey:kPurchaseQuantityKey];
        NSString *quantityStr = [quantityNum stringValue];
    
        placeholderTxt=[CellTextDef initCellText:quantityStr withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];

        placeholderTxt.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
        if (entryFPtr.placeholderTextDefPtr) {
            [entryFPtr.placeholderTextDefPtr killYourself];
        }
        inputFieldLabel = [NSString stringWithFormat:@"Number Of %@ Tickets:",[purchaseInfo objectForKey:kPurchaseTypeKey]];
        entryFPtr.placeholderTextDefPtr=placeholderTxt;
        entryFPtr.leftSideDispTextPtr=[CellTextDef initCellText:inputFieldLabel withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
        entryFPtr.leftSideDispTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentRight;
        entryFPtr.keyboardType = UIKeyboardTypeNumberPad;
        
        
        NSString *helpT= inputFieldLabel;
        
        entryFPtr.helpTextPtr=[CellTextDef initCellText:helpT withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
        entryFPtr.helpTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
        
        
        
        dataField0=[[TransactionData alloc]init];
        dataField0.queryKey=[purchaseInfo objectForKey:kPurchaseTypeKey];//[request setPostValue:theUserID forKey:@"validUserID"];
        [myTable.tableVariablesArray addObject:dataField0];//[dbTrans.variablesArray addObject:dataField0];
        entryFPtr.transDataPtr=dataField0;

        
    
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=entryFPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
    }
*/
     CellTextDef *ctdPtr;
    
    CGSize btnSize1 = sizeGlobalButton;//CGSizeMake(80, 30);
    NSMutableArray *purchaseViewButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 buttonsPerRow:2 withTotalNumberOfBtns:2 withStartingIndex:0 withButtonSize:btnSize1];
//    NSMutableArray *purchaseViewButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 buttonsPerRow:2 withTotalNumberOfBtns:2 withButtonSize:btnSize1];
//    NSMutableArray *purchaseViewButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:0 inRow:0 totalButtonCount:2 startingRecordIndex:0 buttonsPerCell:2 withButtonSize:btnSize1];
    ActionRequest *aBtn = [purchaseViewButtons objectAtIndex:0];
    aBtn.buttonName = @"Update";
    aBtn.buttonLabel = nil;
    aBtn.buttonImage = nil;
 //   aBtn.dataRecordKey = pressedBtn.dataRecordKey;
//    aBtn.dataRecords= pressedBtn.dataRecords;
    aBtn.buttonIndex = pressedBtn.buttonIndex;
    aBtn.nextTableView = TVC9;
    aBtn.showingInfoDict=pressedBtn.showingInfoDict;
//    aBtn.myParentCell = nil;
    aBtn.productDict = aProductDict;
//    [self putProductDictInParent:aBtn locDict:aProductDict];
//    aBtn.aProductDict = aProductDict;
    aBtn.aTime = aPurchase.purchaseTime;
    
    aBtn = [purchaseViewButtons objectAtIndex:1];
    aBtn.buttonName = @"Purchase";
    aBtn.buttonLabel = nil;
    aBtn.buttonImage = nil;//aMovie.movieImage;
//    aBtn.dataRecordKey = pressedBtn.dataRecordKey;
//    aBtn.dataRecords= pressedBtn.dataRecords;
    aBtn.buttonIndex = pressedBtn.buttonIndex;
    aBtn.nextTableView = TVC10;
    aBtn.showingInfoDict=pressedBtn.showingInfoDict;
//    aBtn.myParentCell = nil;
//    aBtn.aProduct = aProduct;
    aBtn.aTime = aPurchase.purchaseTime;
    aBtn.productDict=aProductDict;
    
    
    
    ctdPtr=[CellButtonsScroll initCellDefaultsWithBackColor:[UIColor blueColor] withCellButtonArray:purchaseViewButtons isCollectionView:NO];// buttonScroll:NO];
    [purchaseViewButtons removeAllObjects];
    purchaseViewButtons = nil;
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    return myTable;
}


// get ticket quantities;
-(TableDef *)  makeTVC9:(ActionRequest *)pressedBtn
{
//myra recode this
   // return nil;
    NSLog(@"----makeTVC9");
    
    
    TableDef *currentTableDef=self.liveRuntimePtr.activeTableDataPtr;
    TransactionData *dataRecPtr;
    
    //I know data in section 0
//    SectionDef *desiredSection=[self.liveRuntimePtr.activeTableDataPtr.tableSections objectAtIndex:0];

    //I know entryfield cell is in cell 1 (second sell)
   // ProductRecord *aProduct = [pressedBtn.dataRecords objectForKey:pressedBtn.dataRecordKey];
//    ProductRecord *aProduct = pressedBtn.aProduct;

    NSMutableDictionary *aProductDict = selectedProdcuctDict;// //pressedBtn.productDict;// [self fetchProductDict:pressedBtn];
//    aProductDict = pressedBtn.aProductDict;
    NSMutableArray *purchaseRecords = [aProductDict objectForKey:kPurchaseDictionaryArrayKey];
    PurchaseRecord *aPurchase = [purchaseRecords objectAtIndex:0];
//    PurchaseRecord *thisPurchase = [aProduct.purchaseRecords objectAtIndex:pressedBtn.buttonIndex];//[pressedBtn.dataRecords objectForKey:pressedBtn.dataRecordKey];
    NSMutableDictionary *productInfo;
    NSNumber *purchaseQty;
    NSString *purchaseQtyStr;
    NSString *aProductType;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    

       for (int i = 0; i < productTypes.count; i++){
           aProductType = [productTypes objectAtIndex:i];
           productInfo = [aPurchase.allPurchaseTypes objectAtIndex:i];
           BOOL found=FALSE;
           int var=0;
           while (!found){
               dataRecPtr=[currentTableDef.tableVariablesArray objectAtIndex:var];
               purchaseQtyStr=@"0";
               if ([dataRecPtr.queryKey isEqualToString:aProductType]) {
                   purchaseQtyStr=dataRecPtr.userDefinedData;
                   found=true;
               }
               purchaseQty =  [f numberFromString:purchaseQtyStr];
               var=var+1;
               if (var > [currentTableDef.tableVariablesArray count]) {
                   found=true;
               }
           }//end while
        
           if (purchaseQty){
              // purchaseQty = [NSNumber numberWithFloat:0.0] ;
               [productInfo setObject:purchaseQty forKey:kPurchaseQuantityKey];
           }
        
    }
    
       TableDef *tvc9 = [self makeTVC8:pressedBtn];
    

    return tvc9;
}

// Go to Fandango to buy tickets

-(TableDef *)  makeTVC10:(ActionRequest *)pressedBtn
{
    NSLog(@"----makeTVC8");
     NSString *ticketURI = [pressedBtn.showingInfoDict objectForKey:kMovieTicketBuyPath];// [aProductDictTMS objectForKey:kTicketURIKey];
       if (!ticketURI){
        NSLog(@"No Fandango URI");
//        TableDef *tvc2 = [self makeTVC2:nil];
//        return tvc2;
        return nil;
    }
    NSLog(@"Showing Dictionary - %@",pressedBtn.showingInfoDict);

    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:ticketURI]];
    return nil;
}

/*
-(TableDef *)makeTVC10:(ActionRequest*)pressedBtn
{

    NSLog(@"----makeTVC10");
    TableDef *myTable;
    NSMutableDictionary *aProductDict = pressedBtn.productDict;  //[self fetchProductDict:pressedBtn];
    NSString *movieName = [aProductDict objectForKey:kProductNameKey];
    myTable = [self createFixedTableHeaderUsingText:[NSString stringWithFormat:@"Theaters Showing - %@",[aProductDict objectForKey:kProductNameKey]] forTable:nil];
    CGSize btnSize = CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    SectionDef *sdPtr1;
    CellContentDef *cellContentPtr;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    CellUIView *cuvPtr;
    
    
    //C E L L S    F O R        S E C T I O N S
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
//    [dateFormatter setDateFormat:@"MMM dd"];
   
   
//NSString *aShowingDate = [dateFormatter stringFromDate:[NSDate date]];

 //   NSString *aLocationID;
    NSMutableDictionary *aLocDict;
    NSMutableDictionary *allLocations = self.liveRuntimePtr.allLocationsHDI;
    NSArray *allLocationKeys = [[self.liveRuntimePtr.allLocationsHDI allKeys] sortedArrayUsingSelector:@selector(compare:)];;
    NSString *aKey;
     for (aKey in allLocationKeys){
        aLocDict = [allLocations objectForKey:aKey];
   //     if (![self addInfoToProductDictTMSonNSDate:aProductDictTMS forLocation:aLocDictTMS onDate:[NSDate date]])
         NSString *productID = [aProductDict objectForKey:kProductIDKey];
         NSMutableArray *allInventory = [self.liveRuntimePtr.allProductInventoryHDI objectForKey:productID];
         //       BOOL isPlaying = [self addInfoToProductDictTMSonNSDate:aProductDictTMS forLocation:aLocDict onDate:pressedBtn.buttonDate];
         NSDate *aDate = [NSDate date];
         if (selectedDate)
             aDate=selectedDate;
         NSMutableArray *showTimes = [self showingsForNSDate:aDate inShowings:allInventory atLocation:aLocDict];
         if (!showTimes.count){
 //        if ([self isProductAvailableAtLocationOnDate:aProductDict forLocation:aLocDict onDate:[NSDate date]])
            continue;
         }
         
//        NSArray *showTimes = [aProductDict objectForKey: @"ProductTimesArray"];
        NSLog(@"Showings NSDates = %@",showTimes);
        cuvPtr = [self buildLocationCell:aLocDict withAlignment:NSTextAlignmentLeft withTextColor:viewTextColor andBackGroundColor:viewBackColor];
        //  cuvPtr = [self buildLocationCell:aLocDict withAlignment:NSTextAlignmentLeft];
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;   //alignment for container holding texts
        cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;  //template layout for container
        //       cuvPtr.dataBaseDict = aLocDict;
//        [cuvPtr.dataBaseDictsPtrs setObject:aLocDict forKey:kDictionaryTypeLocation];
         cuvPtr.locDict=aLocDict;
        //        cuvPtr.aLocDict = aLocDict;
        cuvPtr.nextTableView=TVC4;
        cuvPtr.cellDate = [NSDate date];
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:cuvPtr andTableViewCellPtr:nil];
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
    }
    
    
    
    return myTable;
}
 */
 
    -(NSString *)leftJustifyString:(NSString*)aString withLength:(NSUInteger)strLength
    {
        NSString *justifiedStr = [aString mutableCopy];
        NSUInteger aStrLength=[aString length];
        NSUInteger spacesToAdd = strLength-aStrLength;
        if (spacesToAdd > 0){
            for (NSUInteger i = spacesToAdd; i > 0; i --){
                justifiedStr = [justifiedStr stringByAppendingString:@" "];
            }
        }
        return justifiedStr;
        
    }
    -(NSString *)rightJustifyString:(NSString*)aString withLength:(NSUInteger)strLength
    {
        NSString *justifiedStr = @"";//[aString mutableCopy];
        NSUInteger aStrLength=[aString length];
        NSUInteger spacesToAdd = strLength-aStrLength;
        if (spacesToAdd > 0){
            for (NSUInteger i = spacesToAdd; i > 0; i --){
                justifiedStr = [justifiedStr stringByAppendingString:@" "];
            }
            justifiedStr = [justifiedStr stringByAppendingString:aString];
        }
        return justifiedStr;
    }
    
    
   -(void)forceSectionReloadABLEwithMaxCells:(int)maxTVCellsCreating sectionDef:(SectionDef *)sdPtr
{
    // maxTVCellsCreated will be created even if they are empty. if more exist than max, they will be deleted
    //reloadable means memory size cannot change during the reload (specifically - can't get bigger) without access violation (trap)
    
    
    if(maxTVCellsCreating < 2){   //failsafe?
        maxTVCellsCreating=2;
        
        
    }
    
    int builtCnt=(int)[sdPtr.sCellsContentDefArr count];
    
    if (builtCnt == maxTVCellsCreating) {
        return;   //no work to do
    }
    
    if ( builtCnt< maxTVCellsCreating) {
        
        for (int index=builtCnt; index<maxTVCellsCreating; index++) {   //create variable amount of  dummy area so don't get access violation on reload
            CellContentDef* cellContentPtr1=[[CellContentDef alloc] init];
            cellContentPtr1.ccCellTypePtr=nil;
            cellContentPtr1.ccTableViewCellPtr=nil;
            [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
        }
        return;
        
    }
    
    
    
    
    
    if ( builtCnt> maxTVCellsCreating){//row isn't just incremented by 1  in above for loop
        NSLog(@"");
        
        
        
        for (int index=builtCnt-1; index> maxTVCellsCreating-1; index--) {   //remove excess can't display;prevent reload's access violation
            [sdPtr.sCellsContentDefArr removeObjectAtIndex:index];
        }
        NSLog(@"");
    }
    
    
    
    
    
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Build Movie App Key Directories
/////////////////////////////////////////
-(CellUIView*)buildLocationCell:(NSMutableDictionary*)aLocDict withAlignment:(NSTextAlignment)alignment withTextColor:(UIColor*)textColor andBackGroundColor:(UIColor *)backColor
{
    CellUIView *cuvPtr;
    cuvPtr=[[CellUIView alloc]init];
    
    //build text cells
    CellTextDef *txtTypePtr, *txtTypePtr1, *txtTypePtr2;
    txtTypePtr=[CellTextDef initCellText:[aLocDict objectForKey:kLocationNameKey] withTextColor:textColor withBackgroundColor:backColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];  //was text size 20
    txtTypePtr.cellDispTextPtr.alignMe=alignment;// NSTextAlignmentLeft;//NSTextAlignmentCenter;
    txtTypePtr.cellSeparatorVisible=TRUE;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr];
    
    txtTypePtr1=[CellTextDef initCellText:[aLocDict objectForKey:kLocationAddressKey] withTextColor:textColor withBackgroundColor:backColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil]; //was text size 16
    txtTypePtr1.cellDispTextPtr.alignMe=alignment;// NSTextAlignmentLeft;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr1];
    
    NSString *cityStateZip=[NSString stringWithFormat:@"%@, %@ %@",[aLocDict objectForKey:kLocationCityKey], [aLocDict objectForKey:kLocationStateKey], [aLocDict objectForKey:kLocationZipKey]];
    txtTypePtr2=[CellTextDef initCellText:cityStateZip withTextColor:textColor withBackgroundColor:backColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil]; //was text size 12
    txtTypePtr2.cellDispTextPtr.alignMe=alignment;// NSTextAlignmentLeft;
    
    
//    txtTypePtr2.cellSeparatorVisible=TRUE;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr2];
    return cuvPtr;
    
}

-(CellUIView *)buildMovieInfoCell:(NSMutableDictionary*)movieInfo
{
    CellUIView * cuvPtr=[[CellUIView alloc]init];
    
    
    NSMutableArray *movieInfoKeys = [self buildMovieInfoKeys];
    CellTextDef *txtTypePtr;//, *txtTypePtr1, *txtTypePtr2, *txtTypePtr3, *txtTypePtr4, *txtTypePtr5, *txtTypePtr6, *txtTypePtr7, *txtTypePtr8;
    int keyIdx = 0;
    
    
    
    
    txtTypePtr=[CellTextDef initCellText:[movieInfo objectForKey:[movieInfoKeys objectAtIndex:keyIdx]] withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil]; //was text size 20
    txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr];
    keyIdx++;
    
    for (keyIdx = keyIdx; keyIdx < movieInfoKeys.count; keyIdx++){
        txtTypePtr=[CellTextDef initCellText:[NSString stringWithFormat:@"%@: %@",[movieInfoKeys objectAtIndex:keyIdx],[movieInfo objectForKey:[movieInfoKeys objectAtIndex:keyIdx]]] withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil]; //was text size 12
        txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
        [cuvPtr.cTextDefsArray addObject:txtTypePtr];
    }
    return cuvPtr;
}



-(NSMutableArray*)buildMovieInfoKeys
{
    
    
    
    
    
    NSMutableArray *movieInfoKeys = [[NSMutableArray alloc] init];
    NSString *movieNameKey = @"Title";
    [movieInfoKeys addObject:movieNameKey];
    NSString *releaseDateKey = @"Released";
    [movieInfoKeys addObject:releaseDateKey];
    NSString *ratedKey = @"Rated";
    [movieInfoKeys addObject:ratedKey];
    NSString *runTimeKey = @"Runtime";
    [movieInfoKeys addObject:runTimeKey];
    NSString *genreKey = @"Genre";
    [movieInfoKeys addObject:genreKey];
    NSString *directorKey = @"Director";
    [movieInfoKeys addObject:directorKey];
    NSString *writersKey =@"Writer";
    [movieInfoKeys addObject:writersKey];   
    NSString *castKey = @"Actors";
    [movieInfoKeys addObject:castKey];
    NSString *plotKey = @"Plot";
    [movieInfoKeys addObject:plotKey];
    
    return movieInfoKeys;
    
}
-(CellUIView *)buildMovieInfoCellTMS:(NSMutableDictionary*)movieInfo
{  CellUIView * cuvPtr=[[CellUIView alloc]init];
    
    
    NSMutableArray *movieInfoKeys = [self buildMovieInfoKeysTMS];
    CellTextDef *txtTypePtr;//, *txtTypePtr1, *txtTypePtr2, *txtTypePtr3, *txtTypePtr4, *txtTypePtr5, *txtTypePtr6, *txtTypePtr7, *txtTypePtr8;
    int keyIdx = 0;
    
    
    
    
    txtTypePtr=[CellTextDef initCellText:[movieInfo objectForKey:[movieInfoKeys objectAtIndex:keyIdx]] withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];  //was text size 20
    txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    [cuvPtr.cTextDefsArray addObject:txtTypePtr];
    keyIdx++;
    
    for (keyIdx = keyIdx; keyIdx < movieInfoKeys.count; keyIdx++){
        txtTypePtr=[CellTextDef initCellText:[NSString stringWithFormat:@"%@: %@",[movieInfoKeys objectAtIndex:keyIdx],[movieInfo objectForKey:[movieInfoKeys objectAtIndex:keyIdx]]] withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontSmall withTextFontName:nil]; //was text size 12
        txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
        [cuvPtr.cTextDefsArray addObject:txtTypePtr];
    }
    return cuvPtr;
}

-(NSMutableArray*)buildMovieInfoKeysTMS
{
    /*
    NSString *movieNameKey = @"Title";
    [movieInfoKeys addObject:movieNameKey];
    NSString *releaseDateKey = @"Released";
    [movieInfoKeys addObject:releaseDateKey];
    NSString *ratedKey = @"Rated";
    [movieInfoKeys addObject:ratedKey];
    NSString *runTimeKey = @"Runtime";
    [movieInfoKeys addObject:runTimeKey];
    NSString *genreKey = @"Genre";
    [movieInfoKeys addObject:genreKey];
    NSString *directorKey = @"Director";
    [movieInfoKeys addObject:directorKey];
    NSString *writersKey =@"Writer";
    [movieInfoKeys addObject:writersKey];
    NSString *castKey = @"Actors";
    [movieInfoKeys addObject:castKey];
    NSString *plotKey = @"Plot";
    [movieInfoKeys addObject:plotKey];
*/
    
    
    NSMutableArray *movieInfoKeys = [[NSMutableArray alloc] init];

    NSString *movieNameKey = @"Title";
    [movieInfoKeys addObject:movieNameKey];
    NSString *releaseDateKey = @"Released";
    [movieInfoKeys addObject:releaseDateKey];
//    NSString *ratedKey = @"Rated";
//    [movieInfoKeys addObject:ratedKey];
 //1   NSString *runTimeKey = @"runtime";  //
 //1   [movieInfoKeys addObject:runTimeKey];
    NSString *genreKey = @"Genre";
    [movieInfoKeys addObject:genreKey];
    NSString *directorKey = @"Director";
    [movieInfoKeys addObject:directorKey];
//NSString *writersKey =@"Writer";
//    [movieInfoKeys addObject:writersKey];
    NSString *castKey = @"Actors";   //
    [movieInfoKeys addObject:castKey];
    NSString *plotKey = @"Plot";
    [movieInfoKeys addObject:plotKey];
    
    return movieInfoKeys;
    
}

-(NSMutableArray *)buildLocationKeys
{
     NSMutableArray *LocationKeys = [[NSMutableArray alloc] initWithObjects:kLocationNameKey,kLocationAddressKey,kLocationCityKey,kLocationStateKey,kLocationZipKey, nil];
    
    
     return LocationKeys;
    
}
/*
-(void)addProductInfoNewToProductDict:(NSMutableDictionary *)aProductDict
{
    NSString *productName = [aProductDict valueForKeyPath:@"Title"];
    NSMutableDictionary *productInfoDictionary = [self.liveRuntimePtr.allMovieInfoOMDB objectForKey:productName];
    UIImage *productImage = [self.liveRuntimePtr.movieImageDictionary objectForKey:productName];
    //    NSArray * productTimesArray = [self explodeAStringToArraySubstrings:[aProductDict objectForKey:kProductImplodedTimesKey]];
    NSMutableArray *productTimesArray = [self addShowingTimeToProductDict:aProductDict addShowtime:@"2016-06-06T10:00"];
    if (productInfoDictionary)
        [aProductDict setObject:productInfoDictionary forKey:kProductInfoDictKey];
    if(productImage)
        [aProductDict setObject:productImage forKey:kProductImageKey];
    [aProductDict setObject:productTimesArray forKey:kProductTimesArrayKey];
}
*/
/*
-(BOOL)testForProductAvailableAtALocationTMS:(NSMutableDictionary *)aProductDictTMS forLocation:(NSMutableDictionary*)locDictTMS onDate:(NSString*)localDate
{
    BOOL productIsShowingAtTheatre = NO;
    NSString *locationID = [locDictTMS objectForKey:@"LocationID"];
    NSString *productName = [aProductDictTMS valueForKeyPath: @"title"];   //should this be Title? not sure so made method above
    NSMutableDictionary *productInfoDictionary = [self.liveRuntimePtr.allMovieInfoOMDB objectForKey:productName];
    UIImage *productImage = [self.liveRuntimePtr.movieImageDictionary objectForKey:productName];
    NSMutableArray *productTimesStings = [[NSMutableArray alloc] init];
    NSArray *productShowings = [aProductDictTMS valueForKeyPath:@"showtimes"];
//    NSArray *theatreIDs= [aProductDictTMS valueForKeyPath:@"showtimes.theatre.id"];
    NSString *aTheatreID;
    NSDictionary *aShowing;
    NSString *aShowingTimeString;
    [aProductDictTMS removeObjectForKey:kProductTimesArrayKey];
//    for (aTheatreID in theatreIDs){
    for (aShowing in productShowings){
        aTheatreID = [aShowing valueForKeyPath:@"theatre.id"];
        if ([aTheatreID isEqualToString:locationID]){
            aShowingTimeString = [aShowing objectForKey:@"dateTime"];
            [productTimesStings addObject:aShowingTimeString];
            productIsShowingAtTheatre = YES;
         }
    }
    if (productIsShowingAtTheatre){
        NSMutableArray *productTimesArray = [self convertShowTimesToNSDates:productTimesStings onDate:localDate];
        [aProductDictTMS setObject:productTimesArray forKey:kProductTimesArrayKey];
    }
    [aProductDictTMS setObject:productInfoDictionary forKey:kProductInfoDictKey];
    [aProductDictTMS setObject:productImage forKey:kProductImageKey];
    return productIsShowingAtTheatre;
}
*/
-(NSDate*)convertDateStringToNSDate:(NSString *)aShowingTimeString
{
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
       NSDate *nsDate = [dateFormatter dateFromString:aShowingTimeString];
    return nsDate;
}
-(NSMutableArray *)convertShowTimesToNSDates:(NSMutableArray*)dateTimeStrings onDate:(NSString *)localDate// MMM dd
{
 
    NSMutableArray *showTimesArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    
 //   NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [dayFormatter setDateFormat:@"MMM dd"];
  
    NSDate  *nsDateFromString;
    NSString *testDate;
    for (NSString *dateTimeStr in dateTimeStrings){
        nsDateFromString = [dateFormatter dateFromString:dateTimeStr];
        testDate = [dayFormatter stringFromDate:nsDateFromString];
        if ([localDate isEqualToString:testDate])                         // only return showings from date
           [showTimesArray addObject:nsDateFromString];
    }
    return showTimesArray;
    
}
-(NSMutableArray *)explodeAStringToArraySubstrings:(NSString *)implodedString
{
    NSArray *stringArray = [implodedString componentsSeparatedByString: @","];
    NSMutableArray *cleanArray = [NSMutableArray arrayWithArray:stringArray];
//    [cleanArray removeLastObject];
    return cleanArray;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Movie App Methods
/////////////////////////////////////////
/*
    -(TableDef *)createSection0ScrollingView:(ActionRequest *)pressedButton forProducts:(NSMutableDictionary*)allProductsDict atLocation:(NSMutableDictionary*)aLocDict forNumberOfDays:(int)numberOfDays withTableTitle:(NSString*)tableTitle
    {
        
        //  Generic Use Code Start
        
        SectionDef *sdPtr1;
        TableDef *myTable = nil; // self.liveRuntimePtr.activeTableDataPtr;
        CellContentDef *cellContentPtr1;//, *cellContentPtr2;
        CGSize hdrBtnSize = CGSizeMake(60, 30);
        CGSize movieBtnSize = CGSizeMake(100, 150);
        CellButtonsScroll *hdrCell;
        if (pressedButton.reloadOnly){
            sdPtr1 = [myTable.tableSections objectAtIndex:0];
            [myTable.tableSections removeAllObjects];
            [myTable.tableSections addObject:sdPtr1];
            cellContentPtr1 = [sdPtr1.sCellsContentDefArr objectAtIndex:0];
            cellContentPtr1.ccCellTypePtr.reloadOnly = YES;
        }
        
        if (!pressedButton.reloadOnly){
            myTable = [self createFixedTableHeaderUsingText:tableTitle forTable:nil];
            CGSize sechdrBtnSize = CGSizeMake(60, 30);
            sdPtr1 = nil;
            sdPtr1 = [self createDateButtonsAsSectionHeader:sdPtr1 sectionNumber:0 inTable:myTable actionReq:pressedButton withButtonSize:sechdrBtnSize];// nextTVC:TVC2];
            hdrCell = (CellButtonsScroll *)sdPtr1.sectionHeaderContentPtr.ccCellTypePtr;
            myTable =[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:hdrBtnSize];// buttonsScroll:NO];
            [self turnOnSelectedDateBtn:selectedDate inCellBtnArray:hdrCell.cellsButtonsArray];
            
            [myTable.tableSections addObject:sdPtr1];
            int section = 0;
            int row = 0;
            //C E L L S    F O R        S E C T I O N S
            
            //button cells section 1      B U T T O N S
            CellButtonsScroll *cbsPtr = [self buildAllProductsScrollView:pressedButton forProducts:allProductsDict atLoc:aLocDict forSection:section andRow:row withBtnSize:movieBtnSize];
            if (cbsPtr.cellsButtonsArray.count){
                cellContentPtr1=[[CellContentDef alloc] init];
                cellContentPtr1.ccCellTypePtr=cbsPtr;
                cellContentPtr1.ccTableViewCellPtr=nil;
                
                [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
                
            }
        }
        // Generic Code End
        return myTable;
    }
*/
-(TableDef *)createSection0ScrollingView:(ActionRequest *)pressedButton forProducts:(NSMutableDictionary*)allProductsDict atLocation:(NSMutableDictionary*)aLocDict forNumberOfDays:(int)numberOfDays withTableTitle:(NSString*)tableTitle
{
    
    //  Generic Use Code Start
    
    SectionDef *sdPtr1;
    TableDef *myTable = self.liveRuntimePtr.activeTableDataPtr;
    CellContentDef *cellContentPtr1;//, *cellContentPtr2;
    CGSize hdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    CGSize movieBtnSize = sizeGlobalPoster;//CGSizeMake(100, 150);
    CellButtonsScroll *hdrCell;
    if (pressedButton.reloadOnly){
        NSLog(@"reloadonly - notcreate table");
                sdPtr1 = [myTable.tableSections objectAtIndex:0];
        [myTable.tableSections removeAllObjects];
        [myTable.tableSections addObject:sdPtr1];
        cellContentPtr1 = [sdPtr1.sCellsContentDefArr objectAtIndex:0];
        cellContentPtr1.ccCellTypePtr.reloadOnly = YES;
    }
    else{
        NSLog(@"create table");
        myTable = [self createFixedTableHeaderUsingText:tableTitle forTable:nil];
        CGSize sechdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
        sdPtr1 = nil;
        sdPtr1 = [self createDateButtonsAsSectionHeader:sdPtr1 sectionNumber:0 inTable:myTable actionReq:pressedButton withButtonSize:sechdrBtnSize];// nextTVC:TVC2];
        hdrCell = (CellButtonsScroll *)sdPtr1.sectionHeaderContentPtr.ccCellTypePtr;
        myTable =[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:hdrBtnSize];// buttonsScroll:NO];
        [self turnOnSelectedDateBtn:selectedDate inCellBtnArray:hdrCell.cellsButtonsArray];
        
        [myTable.tableSections addObject:sdPtr1];
        int section = 0;
        int row = 0;
        
//C E L L S    F O R        S E C T I O N S
//button cells section 1      B U T T O N S
        
 //       CellButtonsContainer *cbsPtr;
 //       if (makeCollectionView){
            CellButtonsScroll * cbsPtr1 = [self buildAllProductsScrollView:pressedButton forProducts:allProductsDict atLoc:aLocDict forSection:section andRow:row withBtnSize:movieBtnSize isCollectionView:makeCollectionView];
        
            cbsPtr1.indicateSelItem=YES;
            if (cbsPtr1.cellsButtonsArray.count){
                cellContentPtr1=[[CellContentDef alloc] init];
                cellContentPtr1.ccCellTypePtr=cbsPtr1;
                cellContentPtr1.ccTableViewCellPtr=nil;
            
                [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
            }
/*
        }else{
        
            CellButtonsScroll * cbsPtr2 = [self buildAllProductsScrollView:pressedButton forProducts:allProductsDict atLoc:aLocDict forSection:section andRow:row withBtnSize:movieBtnSize isCollectionView:makeCollectionView];
        
            cbsPtr2.indicateSelItem=YES;
            if (cbsPtr2.cellsButtonsArray.count){
                cellContentPtr1=[[CellContentDef alloc] init];
                cellContentPtr1.ccCellTypePtr=cbsPtr2;
                cellContentPtr1.ccTableViewCellPtr=nil;
            
                [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
            }
        }
 */
    }

    // Generic Code End
    return myTable;
}
-(TableDef*)createScrollingViewForGenres:(ActionRequest *)pressedButton forProducts:(NSMutableDictionary*)allProductsDict atLocation:(NSMutableDictionary*)aLocDict withTableTitle:(NSString*)tableTitle inSection:(int)section // inMyTable:(TableDef*)aTable
{
    
    //  Generic Use Code Start
        SectionDef *sdPtr1;
    TableDef *myTable = self.liveRuntimePtr.activeTableDataPtr;
    CellContentDef *cellContentPtr1;//, *cellContentPtr2;
    CGSize hdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    CGSize movieBtnSize = sizeGlobalPoster;//CGSizeMake(100, 150);
    CellButtonsScroll *hdrCell;
    if (pressedButton.reloadOnly){
        NSLog(@"reloadonly - notcreate table");
        for (sdPtr1 in myTable.tableSections){
 //       sdPtr1 = [myTable.tableSections objectAtIndex:section];// 0];
//        [myTable.tableSections removeAllObjects];
//        [myTable.tableSections addObject:sdPtr1];
//        for (cellContentPtr1 in sdPtr1.sCellsContentDefArr){
        cellContentPtr1 = [sdPtr1.sCellsContentDefArr objectAtIndex:0];
        cellContentPtr1.ccCellTypePtr.reloadOnly = YES;
        }
    }
    else{
        NSLog(@"create table");
        myTable = [self createFixedTableHeaderUsingText:tableTitle forTable:nil];
 //       CGSize sechdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
 //       myTable=aTable;
        sdPtr1 = nil;
        
 //       sdPtr1 = [self createDateButtonsAsSectionHeader:sdPtr1 sectionNumber:0 inTable:myTable actionReq:pressedButton withButtonSize:sechdrBtnSize];// nextTVC:TVC2];
//        hdrCell = (CellButtonsScroll *)sdPtr1.sectionHeaderContentPtr.ccCellTypePtr;
        myTable =[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:hdrBtnSize];// buttonsScroll:NO];
        [self turnOnSelectedDateBtn:selectedDate inCellBtnArray:hdrCell.cellsButtonsArray];
        
//
//        [myTable.tableSections addObject:sdPtr1];
//        int section = 0;
        int row = 0;
        
        //C E L L S    F O R        S E C T I O N S  Genre Button Sections/Cells
        //button cells section 1      B U T T O N S
        
        
        
        NSMutableDictionary *genres = [self makeGenresDict:self.liveRuntimePtr.allProductDefinitions_HDI];
        NSArray *sortedGenres = [[genres allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSString *aGenre;
        NSMutableDictionary *allProductsOfThisGenre;
        NSMutableDictionary *aProductDict;
        for (aGenre in sortedGenres){
            sdPtr1=[SectionDef initSectionHeaderText:aGenre withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
//        sdPtr1.sectionHeaderContentPtr=nil;
            sdPtr1.sectionFooterContentPtr=nil;
            [myTable.tableSections addObject:sdPtr1];
            allProductsOfThisGenre = [self allProductsOfThisGenre:aGenre inProductsDict:self.liveRuntimePtr.allProductDefinitions_HDI];
            CellButtonsScroll * cbsPtr1 = [self buildAllProductsScrollView:pressedButton forProducts:allProductsOfThisGenre atLoc:aLocDict forSection:section andRow:row withBtnSize:movieBtnSize isCollectionView:makeCollectionView];
            cbsPtr1.indicateSelItem=YES;
            if (cbsPtr1.cellsButtonsArray.count){
                cellContentPtr1=[[CellContentDef alloc] init];
                cellContentPtr1.ccCellTypePtr=cbsPtr1;
                cellContentPtr1.ccTableViewCellPtr=nil;
                [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
            }
            section++;
        }
    }
    
    // Generic Code End
    return myTable;
}
-(NSMutableArray *)showingsForNSDate:(NSDate *)aDate inShowings:(NSMutableArray*)showings atLocation:(NSMutableDictionary*)aLocationDict
{
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [dayFormatter setDateFormat:@"MMM dd"];
    NSMutableArray *showingsForDate = [[NSMutableArray alloc] init];
    NSMutableDictionary *aShowing;
    NSString *testDate;
    NSString *locationID = [aLocationDict objectForKey:kLocationIDKey];
    NSString *localDate = [dayFormatter stringFromDate:aDate];
    for (aShowing in showings){
        NSString* aTheatreID = [aShowing valueForKeyPath:kMovieTheaterID ];//TMS kProductShowingTheatreIDKey];//@"theatre.id"];
        if ([aTheatreID isEqualToString:locationID]){
            NSString* aShowingTimeString = [aShowing objectForKey:kMovieShowDateTime];//tms kProductShowingDateTimeKey];//@"dateTime"];
            NSDate* nsDateFromString = [self convertDateStringToNSDate:aShowingTimeString];// [dateFormatter dateFromString:aShowingTimeString];
            testDate = [dayFormatter stringFromDate:nsDateFromString];
            if ([localDate isEqualToString:testDate]){
                [showingsForDate addObject:aShowing];
                
            }
        }
    }
    return showingsForDate;
}

-(int)buildShowTimesBtnsCells:(NSMutableArray*)productShowingsArray inSection:(int)section inRow:(int)row forProduct:(NSMutableDictionary*)aProductDictHDI inLocation:(NSMutableDictionary*)aLocDict buttonsPerRow:(int)buttonsPerRow  sectionDef:(SectionDef *)sdPtr// is3D:(BOOL)is3D// allShowingCount:(NSInteger)allShowingsCount
    {
        ActionRequest *aShowTimeButton;
        CGSize btnSize2 = sizeGlobalButton;// CGSizeMake(60,30);
        NSDate *aShowTime;
        NSString *tmsShowtimeStr;
        NSMutableDictionary *aShowing;
        NSDateFormatter* localTimeZone = [[NSDateFormatter alloc] init];
        [localTimeZone setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
        [localTimeZone setDateFormat:@"hh:mm a"];
        
        //    NSMutableArray *showTimesBtns = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:buttonsPerRow withButtonSize:btnSize2];
        
        //    int arrayIndex = 0;
        //    int rowDelta = 0;
        
        for (int arrayIndex = 0; arrayIndex < productShowingsArray.count;){
            //       NSMutableArray *showTimesBtns = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row+rowDelta buttonsPerRow:buttonsPerRow withTotalNumberOfBtns:productShowingsArray.count withButtonSize:btnSize2];
            NSMutableArray *showTimesBtns = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:buttonsPerRow withTotalNumberOfBtns:productShowingsArray.count withStartingIndex:arrayIndex withButtonSize:btnSize2];
            
            //       CellButtonsScroll * cButPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:showTimesBtns];
            
            NSString *ticketURL;
            for (int i = 0; i <showTimesBtns.count; i++){
                aShowTimeButton = [showTimesBtns objectAtIndex:i]; //      [cButPtr.cellsButtonsArray  objectAtIndex:i];
                aShowing = [productShowingsArray objectAtIndex:arrayIndex+i];
                tmsShowtimeStr = [aShowing objectForKey:kMovieShowDateTime];
                aShowTime = [self convertDateStringToNSDate:tmsShowtimeStr];
                aShowTimeButton.buttonDate=aShowTime;
                aShowTimeButton.buttonName = [localTimeZone stringFromDate:aShowTime];
                aShowTimeButton.showingInfoDict = aShowing;
                aShowTimeButton.nextTableView = TVC8;
                aShowTimeButton.buttonArrayPtr= showTimesBtns;// cButPtr.cellsButtonsArray;
                aShowTimeButton.buttonIndex= i;
                aShowTimeButton.buttonIsOn = YES;
                if ([self hasThisTimePassed:aShowTime])
                    aShowTimeButton.buttonIsOn=NO;
                aShowTimeButton.reloadOnly = NO;
                aShowTimeButton.buttonType = kButtonTypeShowTime;
                aShowTimeButton.productDict = aProductDictHDI;
                aShowTimeButton.aTime = aShowTimeButton.buttonName;
                ticketURL = [aShowing objectForKey:kMovieTicketBuyPath];
                if (!ticketURL){
                    aShowTimeButton.buttonIsOn=NO;
                    aShowTimeButton.uiButton.userInteractionEnabled=NO;
                }
                aShowTimeButton.locDict = aLocDict;
 //               [HDButtonView makeUIButton:aShowTimeButton inButtonSequence:showTimesBtns];
                
                
            }
            CellButtonsScroll * cButPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:showTimesBtns isCollectionView:NO];
            CellContentDef* cellContentPtr=[[CellContentDef alloc] init];
            cellContentPtr.ccCellTypePtr=cButPtr;
            cellContentPtr.ccTableViewCellPtr=nil;
            [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
            row++;
            arrayIndex = arrayIndex+buttonsPerRow;
            if (showTimesBtns.count<buttonsPerRow)
                break;
        }
        
        return row; //cButPtr;
    }
    
    
-(BOOL)hasThisTimePassed:(NSDate*)dateTwo
{
        BOOL   timeHasPassed = NO;
        NSDate *dateOne = [NSDate date];
        switch ([dateOne compare:dateTwo]) {
            case NSOrderedAscending:
                // dateOne is earlier in time than dateTwo
                
                break;
            case NSOrderedSame:
                // The dates are the same
                break;
            case NSOrderedDescending:
                // dateOne is later in time than dateTwo
                timeHasPassed = YES;
                break;
        }
        return timeHasPassed;
    }

//-(CellButtonsScroll*)buildAllProductsScrollView:(ActionRequest*)pressedBtn forProducts:(NSMutableDictionary*)allProductsDict atLoc:(NSMutableDictionary*)aLocDict forSection:(int)section andRow:(int)row withBtnSize:(CGSize)btnSize // forLocation:(NSMutableDictionary*)aLocDicTMS
-(CellButtonsScroll*)buildAllProductsScrollView:(ActionRequest*)pressedBtn forProducts:(NSMutableDictionary*)allProductsDict atLoc:(NSMutableDictionary*)aLocDict forSection:(int)section andRow:(int)row withBtnSize:(CGSize)btnSize isCollectionView:(BOOL)isCollectionView// forLocation:(NSMutableDictionary*)aLocDicTMS
    {
        
        //values in allProductsDict are using TMS keys.  This isn't going to work for generic product.
        CellButtonsScroll* ctdPtr;
//        id ctdPtr = nil;
//       CellButtonsContainer *ctdPtr;
//    NSMutableDictionary *aLocDict = [self fetchLocationDict:pressedBtn];
        NSInteger numberOfProductsAtLocation = 0;
        NSMutableArray *productDictNamesAtLoc = [[NSMutableArray alloc] init];
        NSMutableDictionary *aProductDict;//TMS;
        //   NSString *productName;
        NSMutableDictionary *productDictionaryWithNameAsKey = [self buildProductsDictionaryWithNameKey:allProductsDict];
        NSArray *allProductNames = [[productDictionaryWithNameAsKey allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (int j = 0; j < allProductNames.count; j++){   //allProductNames is in alphabetical order
            
            aProductDict = [productDictionaryWithNameAsKey objectForKey:[allProductNames objectAtIndex:j]];
            NSString *productID = [aProductDict objectForKey:kMovieUniqueKey]; //kProductIDKey]; was a tms key
            NSMutableArray *allInventory = [self.liveRuntimePtr.allProductInventory_HDI objectForKey:productID];
            
            
            //       BOOL isPlaying = [self addInfoToProductDictTMSonNSDate:aProductDictTMS forLocation:aLocDict onDate:pressedBtn.buttonDate];
            NSDate *aDate = [NSDate date];
            if (selectedDate)
                aDate=selectedDate;
            NSMutableArray *inventoryAtLoc = [self showingsForNSDate:aDate inShowings:allInventory atLocation:aLocDict];
            //        BOOL isPlaying =  [self isProductAvailableAtLocationOnDate:aProductDict forLocation:aLocDict onDate:aDate];
            //        if (!aLocDict || isPlaying){
            if (!aLocDict || inventoryAtLoc.count){
                numberOfProductsAtLocation ++;
                [productDictNamesAtLoc addObject:[aProductDict objectForKey:kMovieTitle]];
            }
            
        }
        //  NSMutableArray* hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfProductsAtLocation withTotalNumberOfBtns:numberOfProductsAtLocation withButtonSize:btnSize];
        
        
        
        NSMutableArray *hdiButtons = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonCount:numberOfProductsAtLocation withButtonNames:productDictNamesAtLoc withButtonSize:btnSize buttonType:0];
        //    NSMutableArray* hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfProductsAtLocation withTotalNumberOfBtns:numberOfProductsAtLocation withStartingIndex:0 withButtonSize:btnSize];
        
        ActionRequest *aBtn;
        for(int col = 0; col  <numberOfProductsAtLocation; col++){
            //    aProductDict = [self.liveRuntimePtr.allMovieInfoOMDB objectForKey:[allMovieInfoOMDBKeys objectAtIndex:keyIndex]];
            aProductDict = [productDictionaryWithNameAsKey  objectForKey:[productDictNamesAtLoc objectAtIndex:col]];
            //               [self addProductInfoNewToProductDict:aProductDict];
            
            aBtn = [hdiButtons objectAtIndex:col];
            aBtn.buttonName = [aProductDict objectForKey:kMovieTitle];//tms kProductNameKey];
            //                aBtn.buttonName = pressedButton.buttonName;
            aBtn.buttonLabel = nil;
            aBtn.buttonImage = [aProductDict objectForKey:kProductImageKey];
            aBtn.retRecordsAsDPtrs = nil;//? why not guaranteed   looping queries re-use
            aBtn.nextTableView = pressedBtn.nextTableView; //TVCScrollButtonPress;
            aBtn.buttonIsOn=NO;
            aBtn.buttonDate = pressedBtn.buttonDate;
            aBtn.buttonType = kButtonTypeProduct;
            aBtn.locDict = aLocDict;
            aBtn.productDict = aProductDict;
            
            // Dictionary of Dictionaries
            //        [self putLocationDictInParent:aBtn locDict:aLocDict];
            //        [self putProductDictInParent:aBtn productDict:aProductDict];
            aBtn.reloadOnly = YES;
        }
        
        if (numberOfProductsAtLocation){
            aBtn = [hdiButtons objectAtIndex:0];
            pressedBtn.productDict = aBtn.productDict;
            //      aProductDict = [self fetchProductDict:aBtn];
            //      [self putProductDictInParent:pressedBtn productDict:aProductDict];
  /*
            if (isCollectionView){
                ctdPtr=[CellCollectionView initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdiButtons];
            }else{
   */
            ctdPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdiButtons isCollectionView:isCollectionView];
        }
  //          pressedBtn.buttonName = aBtn.buttonName;
  //      }
    return ctdPtr;
}
-(NSMutableDictionary *)buildProductsDictionaryWithNameKey:(NSMutableDictionary *)allProductsDict
    {
        NSMutableDictionary *productDictionaryWithNameAsKey = [[NSMutableDictionary alloc] init];
        NSArray *allProductIDs = [allProductsDict allKeys];
        NSString *aProductID;
        NSString *productName;
        NSMutableDictionary *aProductDict;
        for (aProductID in allProductIDs){
            aProductDict = [allProductsDict objectForKey:aProductID];
            productName = [aProductDict objectForKey:kMovieTitle] ;//]kProductNameKey];   //this was a TMS key 'title'
            [productDictionaryWithNameAsKey setObject:aProductDict forKey:productName];
        }
        
        return productDictionaryWithNameAsKey;
    }
-(CellButtonsScroll*)buildMovieTrailerButtonsCell:(ActionRequest*)pressedBtn inSection:(int)section inRow:(int)row fromTrailerArray:(NSMutableArray*)trailerArray //forNumberOfTrailers:(int)numberOfTrailers
    {
        CGSize trailerBtnSize = sizeGlobalVideo;// CGSizeMake(80,60);
        NSMutableArray  *trailerNames = [[NSMutableArray alloc] init];
        for (int i = 0; i < trailerArray.count; i++){
            NSString *aTrailerName =  [NSString stringWithFormat:@"%@ %d",kTrailerBtnName, i];
            [trailerNames addObject:aTrailerName];
        }
        
        NSMutableArray *movieTrailerBtns = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonCount:trailerArray.count withButtonNames:trailerNames  withButtonSize:trailerBtnSize buttonType:kButtonTypeTrailer];
        //    NSMutableArray *movieTrailerBtns = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:trailerArray.count withButtonSize:trailerBtnSize];
        ActionRequest *aBtn;
        NSMutableDictionary *aTrailerDict;
        for (int i = 0;i<trailerArray.count;i++){
            aBtn = [movieTrailerBtns objectAtIndex:i];
            //        aBtn.buttonName = [NSString stringWithFormat:@"%@ %d",kTrailerBtnName, i];
            aBtn.nextTableView = TVC5;
            aBtn.productDict=pressedBtn.productDict;
            //        aBtn.buttonType = kButtonTypeTrailer;
            aTrailerDict = [trailerArray objectAtIndex:i];
            if(self.inAVPlayerVC){
                
                NSString *trailerPath = [aTrailerDict objectForKey:kVideoPath];
                UIImage *trailerImage = [aTrailerDict objectForKey:kVideoImage];
                aBtn.trailerPath = trailerPath;
                aBtn.buttonImage = trailerImage;
            }else{
                aBtn.trailerPath = [self parseYouTubeStringForID:aTrailerDict];
            }
            
            
        }
        //      NSString  *aUrlStr = @"<http://www.totaleclips.com/Bounce/b?eclipid=e127195\u0026bitrateid=457\u0026vendorid=2223\u0026type=.mp4>";
        
        
        
        CellButtonsScroll *cbsPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:movieTrailerBtns isCollectionView:NO];
        
        return cbsPtr;
    }
    
    
-(NSMutableDictionary*)buildShowtimesButtonsDictOfArrays:(NSMutableArray*)productShowings
    {
        NSMutableDictionary *showTimesDictOfDicts = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *showTimesDictOfArrays = [[NSMutableDictionary alloc] init];
        NSDictionary *aShowing;
        //    NSMutableArray *aShowingGroup;
        NSMutableDictionary *aShowingGroupDict;
        NSString *groupKey;
        //    NSString *qualsStr;
        for (aShowing in productShowings){
            //        qualsStr = [aShowing objectForKey:kProductQualsKey];
            //       groupKey = [self parseQualse:qualsStr];
            groupKey = [self parseQualseAndReturnGroupKey:aShowing];
            //       if (!groupKey)
            //           groupKey=@"General Admission";
            aShowingGroupDict = [showTimesDictOfDicts objectForKey:groupKey];
            if (!aShowingGroupDict)
                aShowingGroupDict = [[NSMutableDictionary alloc] init];
            [aShowingGroupDict setObject:aShowing  forKey:[aShowing objectForKey:kMovieShowDateTime]];//@"dateTime"]];
            [showTimesDictOfDicts removeObjectForKey:groupKey];
            [showTimesDictOfDicts setObject:aShowingGroupDict forKey:groupKey];
            
        }
        NSArray *showingGroupKeys = [showTimesDictOfDicts allKeys];
        NSString *showTimeKey;
        for (groupKey in showingGroupKeys){
            aShowingGroupDict = [showTimesDictOfDicts objectForKey:groupKey];
            NSArray *showTimes = [[aShowingGroupDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
            
            NSMutableArray *sortedGroupShowings = [[NSMutableArray alloc] init];
            for (showTimeKey in showTimes){
                aShowing = [aShowingGroupDict objectForKey:showTimeKey];
                [sortedGroupShowings addObject:aShowing];
                
            }
            [showTimesDictOfArrays setObject:sortedGroupShowings forKey:groupKey];
        }
        
        return showTimesDictOfArrays;
    }
    -(NSString*)parseQualseAndReturnGroupKey:(NSDictionary*)aShowing
    {
        NSString *qualsStr = [aShowing objectForKey:kShowQuals];//kProductQualsKey];
        NSArray* qualsArray = [qualsStr componentsSeparatedByString: @"|"];
        NSMutableArray*parsedQualsArray = [[NSMutableArray alloc] init];
        NSString *aQual;
        for (aQual in qualsArray){
            if(![aQual isEqualToString:@"Closed Captioned"]){
                [parsedQualsArray addObject:aQual];
            }
        }
        NSMutableDictionary *qualsDict = [[NSMutableDictionary alloc] init];
        for (aQual in parsedQualsArray){
            [qualsDict setObject:@"Qual" forKey:aQual];
        }
        NSArray *sortedQuals = [[qualsDict  allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSMutableArray *mutableSortedQuals = [NSMutableArray arrayWithArray:sortedQuals];
        NSString *parsedQuals = @"General Admission";
        if (mutableSortedQuals.count){
            parsedQuals = [self implodeArrayOfStrings:mutableSortedQuals withSeparator:@" - "];
        }
        return parsedQuals;
    }
-(NSString *)implodeArrayOfStrings:(NSMutableArray *)stringArray withSeparator:(NSString*)separatorStr
    {
        if (!stringArray.count)
            return nil;
        NSString *implodedString = [stringArray objectAtIndex:0];
        if (stringArray.count== 1)
            return implodedString;
        NSString *arrayStr;
        //    for (arrayStr in stringArray){
        for (int i = 1; i < stringArray.count; i++){
            
            arrayStr = [stringArray objectAtIndex:i];
            implodedString = [implodedString stringByAppendingString:[NSString stringWithFormat:@"%@%@",separatorStr, arrayStr]];
        }
        return implodedString;
    }
-(NSString*)parseYouTubeStringForID:(NSMutableDictionary*)trailerDict
    {
        NSString *trailerID;
        NSString *fullTrailerString = [trailerDict objectForKey:@"code"];
        NSString *stringAfterEmbed =  [self stringAfterString:@"embed/" inString:fullTrailerString];
        trailerID = [stringAfterEmbed substringToIndex:11];
        return trailerID;
    }
-(NSString*)stringAfterString:(NSString*)match inString:(NSString*)string
    {
        if ([string rangeOfString:match].location != NSNotFound)
        {
            NSScanner *scanner = [NSScanner scannerWithString:string];
            
            [scanner scanUpToString:match intoString:nil];
            
            NSString *postMatch;
            
            if(string.length == scanner.scanLocation)
            {
                postMatch = [string substringFromIndex:scanner.scanLocation];
            }
            else
            {
                postMatch = [string substringFromIndex:scanner.scanLocation + match.length];
            }
            
            return postMatch;
        }
        else
        {
            return string;
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Helper Methods
    /////////////////////////////////////////
-(NSInteger) giveMeUniqueNSIntegerForDisplayTag
    {
        //this method is missing.  rewrite it
        
        return 0;
    }
-(TableDef *) makeFixedFooterWithSectionsAndCells
    {
        TableDef *myTable;
        myTable=[TableDef initTableDefText:@"TABLE LABEL HERE" withTextColor:[UIColor purpleColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:DEF_TITLEFONTSIZE withTextFontName:nil footerText:@"This is a message with enough text to span multiple lines. This text is set at runtime and might be short or long." withFooterTextColor:[UIColor purpleColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
        
        
        myTable.tableFooterFixed=TRUE;
        
        
        SectionDef *sdPtr1;
        
        //   sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
        
        sdPtr1=[[SectionDef alloc]init];
        [myTable.tableSections addObject:sdPtr1];
        //C E L L S    F O R        S E C T I O N S
        
        
        CellContentDef *cellContentPtr;
        CellTextDef *ctdPtr;
        
        
        
        NSString *cellString;
        for (int item=0; item<50; item++) {
            cellString=[NSString stringWithFormat:@"Section 1 Cell %d", item];
            
            if (item % 2) { // odd
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil];
            }
            else{//even
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
            }
            
            
            cellContentPtr=[[CellContentDef alloc] init];
            cellContentPtr.ccCellTypePtr=ctdPtr;
            cellContentPtr.ccTableViewCellPtr=nil;
            [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        }
        
        
        
        
        
        
        
        
        
        //    [self.tablesToDisplayArray addObject:myTable];
        return myTable;
        
    }
    
-(TableDef *) makeFixedHeaderWithSectionsAndCells
    {
        TableDef *myTable;
        myTable=[self createTextHeaderinTable:nil withText:@"TABLE HEADER"];
        
        
        myTable.tableHeaderFixed=TRUE;
        
        
        SectionDef *sdPtr1;
        
        //   sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
        
        sdPtr1=[[SectionDef alloc]init];
        [myTable.tableSections addObject:sdPtr1];
        //C E L L S    F O R        S E C T I O N S
        
        
        CellContentDef *cellContentPtr;
        CellTextDef *ctdPtr;
        
        
        //create uiview cell in section 1
        
        //debug this--- has a problem with scrollingback up... uiview doesnt use passing colors,etc....
        // ctdPtr=[CellTextDef initCellText:@"Sec1 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
        // ctdPtr=[CellUIView initCellInUIViewWithCellText:@"Sec1 Cell0 0 but this is to span more than 1 row will it actually do that? nobody knows.  It is actually to span more than 3 lines but now a lot more than two is being managed" withTextColor:nil withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil andViewBackColor:[UIColor blueColor]];
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
        
        
        ctdPtr=[CellTextDef initCellText:@"Section1 Cell 0 blah blah blah blah blah blah blah.  More more more more more more.  The end" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        
        
        NSString *cellString;
        for (int item=1; item<50; item++) {
            cellString=[NSString stringWithFormat:@"Section 1 Cell %d", item];
            
            if (item % 2) { // odd
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil];
            }
            else{//even
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
            }
            
            
            cellContentPtr=[[CellContentDef alloc] init];
            cellContentPtr.ccCellTypePtr=ctdPtr;
            cellContentPtr.ccTableViewCellPtr=nil;
            [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
        }
        
        
        
        
        
        
        
        
        
        //    [self.tablesToDisplayArray addObject:myTable];
        return myTable;
        
    }
    
-(TableDef *) makeTableHeaderSectionsRowsNoButtons
{
    
    
    
    TableDef *myTable;
    //H E A D E R     &     F O O T E R
    myTable=[TableDef initTableDefText:@"TABLE LABEL HERE" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:DEF_TITLEFONTSIZE withTextFontName:nil footerText:@"This is a message with enough text to span multiple lines. This text is set at runtime and might be short or long." withFooterTextColor:[UIColor whiteColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
    
    //S E C T I O N S:    H E A D E R     &     F O O T E R
    
    SectionDef *sdPtr1;
    SectionDef *sdPtr2;
    SectionDef *sdPtr3;
    
    sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section 1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];
    sdPtr2=[SectionDef initSectionHeaderText:@"mySection2 header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section2 footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr2];
    sdPtr3=[SectionDef initSectionHeaderText:@" Section3 - Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:18 withTextFontName:nil footerText:@" SECTION 3 - Footer" footerTextColor:[UIColor orangeColor] footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject: sdPtr3];
    
    
    
    //C E L L S    F O R        S E C T I O N S
    
    CellContentDef *cellContentPtr;
    CellTextDef *ctdPtr;
    
    //no cells section 1
    
    //create text cells in section 2
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell1" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
    
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell2 this is a very long long long cell.  SO how many lines can this cell span?  Any information would be interesting for us to see" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell3 this too is  a very long long long long long cell. As a matter of fact it should take up multiple lines, but I'm not sure my logic will caclulate the maximum height of this cell by determining how many words it contains.  WIll it work or will it fail?  Nobody knows until it decides to display itself.  Can this go on forever" withTextColor:[UIColor orangeColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:0 withTextFontName:nil];
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    //create cells in section 3
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec3 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
    
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
    
    ctdPtr=[CellTextDef initCellText:@"Sec3 Cell2" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
    
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
    
    ctdPtr=[CellTextDef initCellText:@"Sec3 Cell3" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
    
    cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    
    
    
    //    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}
/*

    -(TableDef *) makeTableHeaderSectionsRowsNoButtons
    {
        
        
        
        TableDef *myTable;
        //H E A D E R     &     F O O T E R
        myTable=[TableDef initTableDefText:@"TABLE LABEL HERE" withTextColor:[UIColor purpleColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:DEF_TITLEFONTSIZE withTextFontName:nil footerText:@"This is a message with enough text to span multiple lines. This text is set at runtime and might be short or long." withFooterTextColor:[UIColor purpleColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
        
        //S E C T I O N S:    H E A D E R     &     F O O T E R
        
        SectionDef *sdPtr1;
        SectionDef *sdPtr2;
        SectionDef *sdPtr3;
        
        sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section 1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
        [myTable.tableSections addObject:sdPtr1];
        sdPtr2=[SectionDef initSectionHeaderText:@"mySection2 header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section2 footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
        [myTable.tableSections addObject:sdPtr2];
        sdPtr3=[SectionDef initSectionHeaderText:@" Section3 - Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:18 withTextFontName:nil footerText:@" SECTION 3 - Footer" footerTextColor:[UIColor orangeColor] footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
        [myTable.tableSections addObject: sdPtr3];
        
        
        
        //C E L L S    F O R        S E C T I O N S
        
        CellContentDef *cellContentPtr;
        CellTextDef *ctdPtr;
        
        //no cells section 1
        
        //create text cells in section 2
        
        
        ctdPtr=[CellTextDef initCellText:@"Sec2 Cell1" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
        
        
        ctdPtr=[CellTextDef initCellText:@"Sec2 Cell2 this is a very long long long cell.  SO how many lines can this cell span?  Any information would be interesting for us to see" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr andTableViewCellPtr:nil];
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
        
        
        ctdPtr=[CellTextDef initCellText:@"Sec2 Cell3 this too is  a very long long long long long cell. As a matter of fact it should take up multiple lines, but I'm not sure my logic will caclulate the maximum height of this cell by determining how many words it contains.  WIll it work or will it fail?  Nobody knows until it decides to display itself.  Can this go on forever" withTextColor:[UIColor orangeColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:0 withTextFontName:nil];
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr andTableViewCellPtr:nil];
        
        [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
        
        //create cells in section 3
        
        
        ctdPtr=[CellTextDef initCellText:@"Sec3 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
        
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr andTableViewCellPtr:nil];
        [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
        
        ctdPtr=[CellTextDef initCellText:@"Sec3 Cell2" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
        
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr andTableViewCellPtr:nil];
        [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
        
        ctdPtr=[CellTextDef initCellText:@"Sec3 Cell3" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
        
        cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr andTableViewCellPtr:nil];
        [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
        
        
        
        
        
        
        //    [self.tablesToDisplayArray addObject:myTable];
        return myTable;
    }
    
*/
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark CREATE Methods
    /////////////////////////////////////////
    
    
    
    
    
    
    -(void) createTextCellsForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
    {
        //C E L L S    F O R        S E C T I O N
        
        
        CellContentDef *cellContentPtr;
        CellTextDef *ctdPtr;
        NSString *cellString;
        
        
        //create uiview cell in section 0
        for (int item=0; item<totalCells; item++) {
            cellString=[NSString stringWithFormat:@"Section %@ Cell %d", secIdentifier, item];
            
            if (item % 2) { // odd
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
            }
            else{//even
                ctdPtr=[CellTextDef initCellText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
            }
            
            
            cellContentPtr=[[CellContentDef alloc] init];
            cellContentPtr.ccCellTypePtr=ctdPtr;
            cellContentPtr.ccTableViewCellPtr=nil;
            [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
        }//end for
    }
    -(TableDef *) createTextHeaderinTable:(TableDef*)myTable withText:(NSString*)text
    {
        //IF table nil, makeone
        
        if (!myTable) {
            //makeone
            myTable=[[TableDef alloc]init];
        }
        else{
            if (myTable.tableHeaderContentPtr) {
                [myTable.tableHeaderContentPtr killYourself];
            }
        }
        myTable.tableHeaderContentPtr.ccCellTypePtr=[CellTextDef initCellText:text withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
        myTable.tableHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
        myTable.tableHeaderFixed=FALSE;
        
        return myTable;
    }
    -(TableDef *) createEmptyTableDef:(TableDef *)myTable
    {
        if (!myTable) {
            //makeone
            myTable=[[TableDef alloc]init];
        }
        return myTable;
        
    }
    -(TableDef *) createFixedTableHeaderUsingText:(NSString *)thisText forTable:(TableDef *)myTable
    {
        //IF table nil, makeone
        
        if (!myTable) {
            //makeone
            myTable=[[TableDef alloc]init];
        }
        else{
            if (myTable.tableHeaderContentPtr) {
                [myTable.tableHeaderContentPtr killYourself];
            }
        }
        
        CellTextDef *ctdPtr=[CellTextDef initCellText:thisText withTextColor:self.viewTextColor withBackgroundColor:self.headerBackColor withTextFontSize:20 withTextFontName:nil];
        
        myTable.tableHeaderContentPtr.ccCellTypePtr=ctdPtr;
        ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
        
        
        
        myTable.tableHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
        myTable.tableHeaderFixed=TRUE;
        
        return myTable;
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark BUTTON SUPPORT Methods
    /////////////////////////////////////////

-(NSMutableArray *)buildBasicButtonArray:(int)location inSection:(int)section inRow:(int)row buttonCount:(NSInteger)numberOfBtns withButtonNames:(NSMutableArray*)buttonNames withButtonSize:(CGSize)btnSize buttonType:(int)buttonType
{
        
        ActionRequest *hdiBtn;
        int sectionMod = kCellSectionModulus;
        int rowMod = kCellRowModulus;
        int locMod = kLocationModulus;
        NSMutableArray  *hdiButtonArray = [[NSMutableArray alloc] init];
        for (int btnIndex = 0; btnIndex < numberOfBtns; btnIndex ++){
            hdiBtn = [[ActionRequest alloc] init];
            hdiBtn.buttonTag = locMod*location + sectionMod*section + rowMod*row + btnIndex;
            //        hdiBtn.uiButton.tag= hdiBtn.buttonTag;
            hdiBtn.buttonName = [buttonNames objectAtIndex:btnIndex];
            hdiBtn.buttonSize = btnSize;
            hdiBtn.tableRow= row;
            hdiBtn.tableSection= section;
            hdiBtn.location= location;
            hdiBtn.buttonIndex = btnIndex;
            hdiBtn.reloadOnly = NO;
            hdiBtn.buttonType = buttonType;
            [hdiButtonArray addObject:hdiBtn];
        }
    return hdiButtonArray;
}
-(NSMutableArray *)buildButtonsArray:(int)location inSection:(int)section inRow:(int)row buttonsPerRow:(NSInteger)buttonsPerRow withTotalNumberOfBtns:(NSInteger)totalNumberOfButtons withStartingIndex:(int)startingIndex withButtonSize:(CGSize)btnSize// withButtonNames:(NSArray*)buttonNames;
{
        NSMutableArray  *hdiButtonArray = [[NSMutableArray alloc] init];
        ActionRequest *hdiBtn;
        int sectionMod = kCellSectionModulus;
        int rowMod = kCellRowModulus;
        int locMod = kLocationModulus;
        NSInteger buttonsToMake = buttonsPerRow;
        //   NSInteger startingIndex = row*buttonsPerRow;
        NSInteger endingIndex = startingIndex + buttonsPerRow;
        if (endingIndex >= totalNumberOfButtons)
            buttonsToMake =  totalNumberOfButtons-startingIndex;
        for (int i = 0; i < buttonsToMake; i ++){
            
            hdiBtn = [[ActionRequest alloc] init];
            //        hdiBtn.buttonName = [buttonNames objectAtIndex:row*buttonsPerRow+i];
            hdiBtn.buttonTag = locMod*location + sectionMod*section + rowMod*row + i;
            hdiBtn.buttonSize = btnSize;
            hdiBtn.tableRow= row;
            hdiBtn.tableSection= section;
            hdiBtn.buttonIndex = i;
            hdiBtn.reloadOnly = NO;
            [hdiButtonArray addObject:hdiBtn];
    }
    return hdiButtonArray;
}
    
    -(void)turnOnButton:(NSInteger)btnNumber inCellBtnArray:(NSMutableArray *)footerButtons
    {
        ActionRequest *aFtrBtn;
        for (aFtrBtn in footerButtons){
            aFtrBtn.buttonIsOn = NO;
            if (aFtrBtn.nextTableView == btnNumber)
                aFtrBtn.buttonIsOn = YES;
            
        }
    }
    -(void)turnOnButtonAtIndex:(NSInteger)btnIndex inCellBtnArray:(NSMutableArray *)buttonArray
    {
        ActionRequest *aBtn;
        for (int i = 0; i < buttonArray.count; i++){
            aBtn = [buttonArray objectAtIndex:i];
            aBtn.buttonIsOn = NO;
            if (btnIndex == i)
                aBtn.buttonIsOn = YES;
            
        }
    }
    -(void)turnOnSelectedDateBtn:(NSDate *)aDate inCellBtnArray:(NSMutableArray *)buttonArray
    {
        ActionRequest *aBtn;
        NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
        [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
        [dayFormatter setDateFormat:@"MMM dd"];
        NSString *aDateStr = [dayFormatter stringFromDate:aDate];
        NSString *btnDateStr;
        if (!aDate)
            aDate=[NSDate date];
        for (int i = 0; i < buttonArray.count; i++){
            aBtn = [buttonArray objectAtIndex:i];
            aBtn.buttonIsOn = NO;
            btnDateStr=[dayFormatter stringFromDate:aBtn.buttonDate];
            if ([aDateStr isEqualToString:btnDateStr])
                aBtn.buttonIsOn = YES;
            
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Fixed Header and Footer Methods
    /////////////////////////////////////////
-(void)logwhatsup
    {
        // [self.liveRuntimePtr logwhatsup];
    }
-(TableDef *) createButtonsForFixedFooterinTable:(TableDef*)myTable withFooterBtns:(NSArray *)footerNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
        //IF table nil, makeone
        //   CGSize btnSize = CGSizeMake(60, 30);
        NSMutableArray *hdrButtons = [self buildSpecialButtons:BUTTONS_TITLE_FOOTER inSection:0 withButtonNames:footerNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
        if (!myTable) {
            //makeone
            myTable=[[TableDef alloc]init];
        }
        else{
            if (myTable.tableFooterContentPtr) {
                [myTable.tableFooterContentPtr killYourself];
            }
        }
        
        myTable.tableFooterContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdrButtons isCollectionView:NO];// buttonScroll:buttonsScroll];
        myTable.tableFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
        myTable.tableFooterFixed=TRUE;
        
    return myTable;
}
-(SectionDef*) createDateButtonsAsSectionHeader:(SectionDef*)mySection sectionNumber:(int)secNum  inTable:(TableDef *)myTable actionReq:(ActionRequest*)actionReq withButtonSize:(CGSize)btnSize// nextTVC:(NSInteger)nextTVC// withBtnNames:(NSArray *)butNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
    //    CGSize btnSize = CGSizeMake(60, 30);
    
    //    NSMutableArray *secButtons = [self buildSpecialButtons:BUTTONS_SEC_HEADER inSection:secNum withButtonNames:butNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
    NSMutableArray *secButtons = [self buildDatesButtons:actionReq forNumberOfDays:5 inSection:secNum withButtonSize:btnSize nextTVC:actionReq.nextTableView inLocation:BUTTONS_SEC_HEADER];
    //    NSMutableArray *secButtons = [self buildDatesButtons:actionReq forNumberOfDays:5 inSection:secNum withButtonSize:btnSize nextTVC:actionReq.nextTableView];
    if (mySection.sectionHeaderContentPtr) {
        [mySection.sectionHeaderContentPtr killYourself];
    }
    
    
    else{
        mySection=[[SectionDef alloc]init];
        [mySection.sectionFooterContentPtr killYourself];//no footers used here
        mySection.sectionFooterContentPtr=nil;
    }
    mySection.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    mySection.sectionHeaderContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:secButtons isCollectionView:NO];// buttonScroll:buttonsScroll];
    mySection.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    mySection.sectionHeaderContentPtr.ccCellTypePtr.cellMaxHeight=btnSize.height+2;
    return mySection;
    
    
    
}


-(NSMutableArray*)buildSpecialButtons:(int)location inSection:(int)section withButtonNames:(NSArray *)buttonNamesPtr withNextTVCs:(NSArray *)nextTVCptr withButtonSize:(CGSize)btnSize
{
        
        //    CGSize btnSize = CGSizeMake(60, 30);
        NSMutableArray *viewButtons = [self buildBasicButtonArray:location inSection:section inRow:0 buttonCount:buttonNamesPtr.count withButtonNames:buttonNamesPtr withButtonSize:btnSize buttonType:0];
        ActionRequest *fBtn;
        for (int i=0; i < buttonNamesPtr.count; i++){
            fBtn = [viewButtons objectAtIndex:i];
            fBtn.buttonName= [buttonNamesPtr objectAtIndex:i];
            if (nextTVCptr)
                fBtn.nextTableView = [(NSNumber *)[nextTVCptr objectAtIndex:i] integerValue];
        }
        
        
        fBtn=[viewButtons objectAtIndex:0];
        NSLog(@"name %@",fBtn.buttonName);
        
        return viewButtons;
}
    

-(NSMutableArray*)buildDatesButtons:(ActionRequest*)pressedBtn forNumberOfDays:(int)numberOfDays inSection:(int)section withButtonSize:(CGSize)btnSize nextTVC:(NSInteger)nextTVC inLocation:(int)location
    {
        
        NSMutableArray *dateNames = [[NSMutableArray alloc] init];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];;
        [dateFormatter setDateFormat:@"MMM dd"];
        NSString *todayStr = [dateFormatter stringFromDate:[NSDate date]];
        //    ActionRequest *aDateBtn;
        NSDate *aDate;// = [NSDate date];
        NSMutableArray *showingDates = [[NSMutableArray alloc] init];
        for (int i = 0; i < numberOfDays; i++){
            //       aDateBtn = [dateButtons objectAtIndex:i];
            aDate = [[NSDate date] dateByAddingTimeInterval:i*86400];
            [showingDates addObject:aDate];
            //        aDateBtn.buttonDate=aDate;
            NSString *aShowingDate = [dateFormatter stringFromDate:aDate];
            if ([aShowingDate isEqualToString:todayStr])
                aShowingDate = @"Today";
            
            [dateNames addObject:aShowingDate];
        }
        NSMutableArray *dateButtons = [self buildBasicButtonArray:location inSection:section inRow:0 buttonCount:numberOfDays withButtonNames:dateNames withButtonSize:btnSize buttonType:kButtonTypeDate];
        ActionRequest *aDateBtn;
        //        for (aDateBtn in dateButtons){
        for (int i = 0; i < dateButtons.count; i++){
            
            aDateBtn = [dateButtons objectAtIndex:i];
            //            [HDButtonView makeUIButton:aDateBtn inButtonSequence:dateButtons];
            aDateBtn.nextTableView=pressedBtn.nextTableView;
            aDateBtn.buttonDate=[showingDates objectAtIndex:i];
            //            aDateBtn.productDict=pressedBtn.productDict;
            //            aDateBtn.locDict=pressedBtn.locDict;
        }
        
        
        return dateButtons;
}
    

/*

-(TableDef *)createSection0ScrollingView:(ActionRequest *)pressedButton forProducts:(NSMutableDictionary*)allProductsDict atLocation:(NSMutableDictionary*)aLocDict forNumberOfDays:(int)numberOfDays withTableTitle:(NSString*)tableTitle
{
    
    //  Generic Use Code Start
    
    SectionDef *sdPtr1;
    TableDef *myTable = self.liveRuntimePtr.activeTableDataPtr;
    CellContentDef *cellContentPtr1;//, *cellContentPtr2;
    CGSize hdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    CGSize movieBtnSize = sizeGlobalPoster;//CGSizeMake(100, 150);
    CellButtonsScroll *hdrCell;
    if (pressedButton.reloadOnly){
        NSLog(@"reloadonly - notcreate table");
        sdPtr1 = [myTable.tableSections objectAtIndex:0];
        [myTable.tableSections removeAllObjects];
        [myTable.tableSections addObject:sdPtr1];
        cellContentPtr1 = [sdPtr1.sCellsContentDefArr objectAtIndex:0];
        cellContentPtr1.ccCellTypePtr.reloadOnly = YES;
    }
    else{
        NSLog(@"create table");
        myTable = [self createFixedTableHeaderUsingText:tableTitle forTable:nil];
        CGSize sechdrBtnSize = sizeGlobalButton;//CGSizeMake(60, 30);
        sdPtr1 = nil;
        sdPtr1 = [self createDateButtonsAsSectionHeader:sdPtr1 sectionNumber:0 inTable:myTable actionReq:pressedButton withButtonSize:sechdrBtnSize];// nextTVC:TVC2];
        hdrCell = (CellButtonsScroll *)sdPtr1.sectionHeaderContentPtr.ccCellTypePtr;
        myTable =[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:hdrBtnSize];// buttonsScroll:NO];
        [self turnOnSelectedDateBtn:selectedDate inCellBtnArray:hdrCell.cellsButtonsArray];
        
        [myTable.tableSections addObject:sdPtr1];
        int section = 0;
        int row = 0;
        //C E L L S    F O R        S E C T I O N S
        
        
        
        //add simple text array for test     MYRA ADDED FOR TEST
     //a   CellTextDef *ctdPtr;
     //a   CellContentDef *cellContentPtr1;
     //a   cellContentPtr1=[[CellContentDef alloc] init];
     //a   ctdPtr=[CellTextDef initCellText:@"cellSec11" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor redColor] withTextFontSize:36 withTextFontName:nil];
     //a   ctdPtr.cellSeparatorVisible=TRUE;
     //a   cellContentPtr1.ccCellTypePtr=ctdPtr;
     //a   [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];

        
        
        //button cells section 1      B U T T O N S
        CellButtonsScroll *cbsPtr = [self buildAllProductsScrollView:pressedButton forProducts:allProductsDict atLoc:aLocDict forSection:section andRow:row withBtnSize:movieBtnSize];
        cbsPtr.indicateSelItem=YES;
        if (cbsPtr.cellsButtonsArray.count){
            cellContentPtr1=[[CellContentDef alloc] init];
            cellContentPtr1.ccCellTypePtr=cbsPtr;
            cellContentPtr1.ccTableViewCellPtr=nil;
            
            [sdPtr1.sCellsContentDefArr addObject:cellContentPtr1];
            
        }
    }
    // Generic Code End
    return myTable;
}


-(NSMutableArray *)showingsForNSDate:(NSDate *)aDate inShowings:(NSMutableArray*)showings atLocation:(NSMutableDictionary*)aLocationDict
{
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [dayFormatter setDateFormat:@"MMM dd"];
    NSMutableArray *showingsForDate = [[NSMutableArray alloc] init];
    NSMutableDictionary *aShowing;
    NSString *testDate;
    NSString *locationID = [aLocationDict objectForKey:kLocationIDKey];
    NSString *localDate = [dayFormatter stringFromDate:aDate];
    for (aShowing in showings){
        NSString* aTheatreID = [aShowing valueForKeyPath:kMovieTheaterID ];//TMS kProductShowingTheatreIDKey];//@"theatre.id"];
        if ([aTheatreID isEqualToString:locationID]){
            NSString* aShowingTimeString = [aShowing objectForKey:kMovieShowDateTime];//tms kProductShowingDateTimeKey];//@"dateTime"];
           NSDate* nsDateFromString = [self convertDateStringToNSDate:aShowingTimeString];// [dateFormatter dateFromString:aShowingTimeString];
            testDate = [dayFormatter stringFromDate:nsDateFromString];
            if ([localDate isEqualToString:testDate]){
                [showingsForDate addObject:aShowing];

            }
       }
    }
    return showingsForDate;
}
-(int)buildShowTimesBtnsCells:(NSMutableArray*)productShowingsArray inSection:(int)section inRow:(int)row forProduct:(NSMutableDictionary*)aProductDictHDI inLocation:(NSMutableDictionary*)aLocDict buttonsPerRow:(int)buttonsPerRow  sectionDef:(SectionDef *)sdPtr
{
    ActionRequest *aShowTimeButton;
    CGSize btnSize2 = sizeGlobalButton;//CGSizeMake(60,30);
    NSDate *aShowTime;
    NSString *tmsShowtimeStr;
    NSMutableDictionary *aShowing;
    NSDateFormatter* localTimeZone = [[NSDateFormatter alloc] init];
    [localTimeZone setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [localTimeZone setDateFormat:@"hh:mm a"];
    
    //    NSMutableArray *showTimesBtns = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:buttonsPerRow withButtonSize:btnSize2];
    
    //    int arrayIndex = 0;
    //    int rowDelta = 0;
    
    for (int arrayIndex = 0; arrayIndex < productShowingsArray.count;){
        //       NSMutableArray *showTimesBtns = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row+rowDelta buttonsPerRow:buttonsPerRow withTotalNumberOfBtns:productShowingsArray.count withButtonSize:btnSize2];
        NSMutableArray *showTimesBtns = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:buttonsPerRow withTotalNumberOfBtns:productShowingsArray.count withStartingIndex:arrayIndex withButtonSize:btnSize2];
        
        CellButtonsScroll * cButPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:showTimesBtns];
        
        NSString *ticketURL;
        for (int i = 0; i <showTimesBtns.count; i++){
            aShowTimeButton = [cButPtr.cellsButtonsArray  objectAtIndex:i];
            aShowing = [productShowingsArray objectAtIndex:arrayIndex+i];
            tmsShowtimeStr = [aShowing objectForKey:kMovieShowDateTime];
            aShowTime = [self convertDateStringToNSDate:tmsShowtimeStr];
            aShowTimeButton.buttonDate=aShowTime;
            aShowTimeButton.buttonName = [localTimeZone stringFromDate:aShowTime];
            aShowTimeButton.showingInfoDict = aShowing;
            aShowTimeButton.nextTableView = TVC8;
            aShowTimeButton.buttonArrayPtr=cButPtr.cellsButtonsArray;
            aShowTimeButton.buttonIndex= i;
            aShowTimeButton.buttonIsOn = YES;
            if ([self hasThisTimePassed:aShowTime])
                aShowTimeButton.buttonIsOn=NO;
            aShowTimeButton.reloadOnly = NO;
            aShowTimeButton.buttonType = kButtonTypeShowTime;
            aShowTimeButton.productDict = aProductDictHDI;
            aShowTimeButton.locDict= aLocDict;
            aShowTimeButton.aTime = aShowTimeButton.buttonName;
            ticketURL = [aShowing objectForKey:kMovieTicketBuyPath];
            if (!ticketURL){
                aShowTimeButton.buttonIsOn=NO;
                aShowTimeButton.uiButton.userInteractionEnabled=NO;
            }
            aShowTimeButton.locDict = aLocDict;
            
            
        }
        CellContentDef* cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=cButPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
        row++;
        arrayIndex = arrayIndex+buttonsPerRow;
        if (showTimesBtns.count<buttonsPerRow)
            break;
    }
    
    return row; //cButPtr;
}

-(void)forceSectionReloadABLEwithMaxCells:(int)maxTVCellsCreating sectionDef:(SectionDef *)sdPtr
{
    // maxTVCellsCreated will be created even if they are empty. if more exist than max, they will be deleted
    //reloadable means memory size cannot change during the reload (specifically - can't get bigger) without access violation (trap)
    
    
    if(maxTVCellsCreating < 2){   //failsafe?
        maxTVCellsCreating=2;
        
        
    }

    int builtCnt=(int)[sdPtr.sCellsContentDefArr count];
    
    if (builtCnt == maxTVCellsCreating) {
        return;   //no work to do
    }
    
    if ( builtCnt< maxTVCellsCreating) {
        
        for (int index=builtCnt; index<maxTVCellsCreating; index++) {   //create variable amount of  dummy area so don't get access violation on reload
            CellContentDef* cellContentPtr1=[[CellContentDef alloc] init];
            cellContentPtr1.ccCellTypePtr=nil;
            cellContentPtr1.ccTableViewCellPtr=nil;
            [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
        }
        return;
        
    }
    
    
    
    

    if ( builtCnt> maxTVCellsCreating){//row isn't just incremented by 1  in above for loop
        NSLog(@"");
        
        
        
        for (int index=builtCnt-1; index> maxTVCellsCreating-1; index--) {   //remove excess can't display;prevent reload's access violation
            [sdPtr.sCellsContentDefArr removeObjectAtIndex:index];
        }
        NSLog(@"");
    }
    
    
   
    
    
    
}

-(BOOL)hasThisTimePassed:(NSDate*)dateTwo
{
    BOOL   timeHasPassed = NO;
    NSDate *dateOne = [NSDate date];
    switch ([dateOne compare:dateTwo]) {
        case NSOrderedAscending:
            // dateOne is earlier in time than dateTwo
            
            break;
        case NSOrderedSame:
            // The dates are the same
            break;
        case NSOrderedDescending:
            // dateOne is later in time than dateTwo
            timeHasPassed = YES;
            break;
    }
    return timeHasPassed;
}

-(CellButtonsScroll*)buildAllProductsScrollView:(ActionRequest*)pressedBtn forProducts:(NSMutableDictionary*)allProductsDict atLoc:(NSMutableDictionary*)aLocDict forSection:(int)section andRow:(int)row withBtnSize:(CGSize)btnSize // forLocation:(NSMutableDictionary*)aLocDicTMS
{
    
    //values in allProductsDict are using TMS keys.  This isn't going to work for generic product.
    
    CellButtonsScroll *ctdPtr = nil;
//    NSMutableDictionary *aLocDict = [self fetchLocationDict:pressedBtn];
    NSInteger numberOfProductsAtLocation = 0;
    NSMutableArray *productDictNamesAtLoc = [[NSMutableArray alloc] init];
    NSMutableDictionary *aProductDict;//TMS;
 //   NSString *productName;
    NSMutableDictionary *productDictionaryWithNameAsKey = [self buildProductsDictionaryWithNameKey:allProductsDict];
    NSArray *allProductNames = [[productDictionaryWithNameAsKey allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (int j = 0; j < allProductNames.count; j++){   //allProductNames is in alphabetical order
 
        aProductDict = [productDictionaryWithNameAsKey objectForKey:[allProductNames objectAtIndex:j]];
        NSString *productID = [aProductDict objectForKey:kMovieUniqueKey]; //kProductIDKey]; was a tms key
        NSMutableArray *allInventory = [self.liveRuntimePtr.allProductInventory_HDI objectForKey:productID];
 //       BOOL isPlaying = [self addInfoToProductDictTMSonNSDate:aProductDictTMS forLocation:aLocDict onDate:pressedBtn.buttonDate];
        NSDate *aDate = [NSDate date];
        if (selectedDate)
            aDate=selectedDate;
        NSMutableArray *inventoryAtLoc = [self showingsForNSDate:aDate inShowings:allInventory atLocation:aLocDict];
//        BOOL isPlaying =  [self isProductAvailableAtLocationOnDate:aProductDict forLocation:aLocDict onDate:aDate];
//        if (!aLocDict || isPlaying){
        if (!aLocDict || inventoryAtLoc.count){
            numberOfProductsAtLocation ++;
            [productDictNamesAtLoc addObject:[aProductDict objectForKey:kMovieTitle]];
        }
        
    }
  //  NSMutableArray* hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfProductsAtLocation withTotalNumberOfBtns:numberOfProductsAtLocation withButtonSize:btnSize];
  
    NSMutableArray* hdiButtons = [self buildButtonsArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:numberOfProductsAtLocation withTotalNumberOfBtns:numberOfProductsAtLocation withStartingIndex:0 withButtonSize:btnSize];
    
    ActionRequest *aBtn;
    for(int col = 0; col  <numberOfProductsAtLocation; col++){
        //    aProductDict = [self.liveRuntimePtr.allMovieInfoOMDB objectForKey:[allMovieInfoOMDBKeys objectAtIndex:keyIndex]];
        aProductDict = [productDictionaryWithNameAsKey  objectForKey:[productDictNamesAtLoc objectAtIndex:col]];
        //               [self addProductInfoNewToProductDict:aProductDict];
        
        aBtn = [hdiButtons objectAtIndex:col];
        aBtn.buttonName = [aProductDict objectForKey:kMovieTitle];//tms kProductNameKey];
        //                aBtn.buttonName = pressedButton.buttonName;
        aBtn.buttonLabel = nil;
        aBtn.buttonImage = [aProductDict objectForKey:kProductImageKey];
        aBtn.retRecordsAsDPtrs = nil;//? why not guaranteed   looping queries re-use
        aBtn.nextTableView = pressedBtn.nextTableView; //TVCScrollButtonPress;
        aBtn.buttonIsOn=NO;
        aBtn.buttonDate = pressedBtn.buttonDate;
        aBtn.buttonType = kButtonTypeProduct;
        aBtn.locDict = aLocDict;
        aBtn.productDict = aProductDict;
        
        // Dictionary of Dictionaries
//        [self putLocationDictInParent:aBtn locDict:aLocDict];
//        [self putProductDictInParent:aBtn productDict:aProductDict];
        aBtn.reloadOnly = YES;
    }
    
    if (numberOfProductsAtLocation){
        aBtn = [hdiButtons objectAtIndex:0];
        pressedBtn.productDict = aBtn.productDict;
  //      aProductDict = [self fetchProductDict:aBtn];
  //      [self putProductDictInParent:pressedBtn productDict:aProductDict];
        ctdPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdiButtons];// buttonScroll:YES];
        pressedBtn.buttonName = aBtn.buttonName;
    }
    return ctdPtr;
}
-(NSMutableDictionary *)buildProductsDictionaryWithNameKey:(NSMutableDictionary *)allProductsDict
{
    NSMutableDictionary *productDictionaryWithNameAsKey = [[NSMutableDictionary alloc] init];
    NSArray *allProductIDs = [allProductsDict allKeys];
    NSString *aProductID;
    NSString *productName;
    NSMutableDictionary *aProductDict;
    for (aProductID in allProductIDs){
        aProductDict = [allProductsDict objectForKey:aProductID];
        productName = [aProductDict objectForKey:kMovieTitle] ;//]kProductNameKey];   //this was a TMS key 'title'
        [productDictionaryWithNameAsKey setObject:aProductDict forKey:productName];
    }
    
    return productDictionaryWithNameAsKey;
}
-(CellButtonsScroll*)buildMovieTrailerButtonsCell:(ActionRequest*)pressedBtn inSection:(int)section inRow:(int)row fromTrailerArray:(NSMutableArray*)trailerArray //forNumberOfTrailers:(int)numberOfTrailers
{
    CGSize tailerBtnSize = sizeGlobalVideo;//CGSizeMake(80,60);
    NSMutableArray *movieTraierBtns = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:row buttonsPerRow:trailerArray.count withButtonSize:tailerBtnSize];
    ActionRequest *aBtn;
    NSMutableDictionary *aTrailerDict;
    for (int i = 0;i<trailerArray.count;i++){
        aBtn = [movieTraierBtns objectAtIndex:i];
        aBtn.buttonName = [NSString stringWithFormat:@"%@ %d",kTrailerBtnName, i];
        aBtn.nextTableView = TVC5;
        aBtn.productDict=pressedBtn.productDict;
        aBtn.buttonType = kButtonTypeTrailer;
        aTrailerDict = [trailerArray objectAtIndex:i];
        if(self.inAVPlayerVC){

            NSString *trailerPath = [aTrailerDict objectForKey:kVideoPath];
            UIImage *trailerImage = [aTrailerDict objectForKey:kVideoImage];
            aBtn.trailerPath = trailerPath;
            aBtn.buttonImage = trailerImage;
        }else{
            aBtn.trailerPath = [self parseYouTubeStringForID:aTrailerDict];
            }
        
        
        }
 //      NSString  *aUrlStr = @"<http://www.totaleclips.com/Bounce/b?eclipid=e127195\u0026bitrateid=457\u0026vendorid=2223\u0026type=.mp4>";
        
      
    
     CellButtonsScroll *cbsPtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:movieTraierBtns];

    return cbsPtr;
}
-(NSMutableDictionary*)buildShowtimesButtonsDictOfArrays:(NSMutableArray*)productShowings
{
    NSMutableDictionary *showTimesDictOfDicts = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *showTimesDictOfArrays = [[NSMutableDictionary alloc] init];
    NSDictionary *aShowing;
//    NSMutableArray *aShowingGroup;
    NSMutableDictionary *aShowingGroupDict;
    NSString *groupKey;
//    NSString *qualsStr;
    for (aShowing in productShowings){
//        qualsStr = [aShowing objectForKey:kProductQualsKey];
 //       groupKey = [self parseQualse:qualsStr];
        groupKey = [self parseQualseAndReturnGroupKey:aShowing];
 //       if (!groupKey)
 //           groupKey=@"General Admission";
        aShowingGroupDict = [showTimesDictOfDicts objectForKey:groupKey];
        if (!aShowingGroupDict)
            aShowingGroupDict = [[NSMutableDictionary alloc] init];
        [aShowingGroupDict setObject:aShowing  forKey:[aShowing objectForKey:kMovieShowDateTime]];//@"dateTime"]];
        [showTimesDictOfDicts removeObjectForKey:groupKey];
        [showTimesDictOfDicts setObject:aShowingGroupDict forKey:groupKey];
        
    }
    NSArray *showingGroupKeys = [showTimesDictOfDicts allKeys];
    NSString *showTimeKey;
    for (groupKey in showingGroupKeys){
        aShowingGroupDict = [showTimesDictOfDicts objectForKey:groupKey];
        NSArray *showTimes = [[aShowingGroupDict allKeys] sortedArrayUsingSelector:@selector(compare:)];

        NSMutableArray *sortedGroupShowings = [[NSMutableArray alloc] init];
        for (showTimeKey in showTimes){
            aShowing = [aShowingGroupDict objectForKey:showTimeKey];
            [sortedGroupShowings addObject:aShowing];
                
            }
        [showTimesDictOfArrays setObject:sortedGroupShowings forKey:groupKey];
    }

    return showTimesDictOfArrays;
}
-(NSString*)parseQualseAndReturnGroupKey:(NSDictionary*)aShowing
{
    NSString *qualsStr = [aShowing objectForKey:kShowQuals];//kProductQualsKey];
    NSArray* qualsArray = [qualsStr componentsSeparatedByString: @"|"];
    NSMutableArray*parsedQualsArray = [[NSMutableArray alloc] init];
    NSString *aQual;
    for (aQual in qualsArray){
        if(![aQual isEqualToString:@"Closed Captioned"]){
            [parsedQualsArray addObject:aQual];
        }
    }
    NSMutableDictionary *qualsDict = [[NSMutableDictionary alloc] init];
    for (aQual in parsedQualsArray){
        [qualsDict setObject:@"Qual" forKey:aQual];
    }
    NSArray *sortedQuals = [[qualsDict  allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *mutableSortedQuals = [NSMutableArray arrayWithArray:sortedQuals];
    NSString *parsedQuals = @"General Admission";
    if (mutableSortedQuals.count){
        parsedQuals = [self implodeArrayOfStrings:mutableSortedQuals withSeparator:@" - "];
    }
    return parsedQuals;
  }
-(NSString *)implodeArrayOfStrings:(NSMutableArray *)stringArray withSeparator:(NSString*)separatorStr
{
    if (!stringArray.count)
        return nil;
    NSString *implodedString = [stringArray objectAtIndex:0];
    if (stringArray.count== 1)
        return implodedString;
    NSString *arrayStr;
    //    for (arrayStr in stringArray){
    for (int i = 1; i < stringArray.count; i++){
        
        arrayStr = [stringArray objectAtIndex:i];
        implodedString = [implodedString stringByAppendingString:[NSString stringWithFormat:@"%@%@",separatorStr, arrayStr]];
    }
    return implodedString;
}
-(NSString*)parseYouTubeStringForID:(NSMutableDictionary*)trailerDict
{
    NSString *trailerID;
    NSString *fullTrailerString = [trailerDict objectForKey:@"code"];
    NSString *stringAfterEmbed =  [self stringAfterString:@"embed/" inString:fullTrailerString];
    trailerID = [stringAfterEmbed substringToIndex:11];
    return trailerID;
}
-(NSString*)stringAfterString:(NSString*)match inString:(NSString*)string
{
    if ([string rangeOfString:match].location != NSNotFound)
    {
        NSScanner *scanner = [NSScanner scannerWithString:string];
        
        [scanner scanUpToString:match intoString:nil];
        
        NSString *postMatch;
        
        if(string.length == scanner.scanLocation)
        {
            postMatch = [string substringFromIndex:scanner.scanLocation];
        }
        else
        {
            postMatch = [string substringFromIndex:scanner.scanLocation + match.length];
        }
        
        return postMatch;
    }
    else
    {
        return string;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Helper Methods
/////////////////////////////////////////

-(TableDef *) makeFixedFooterWithSectionsAndCells
{
    TableDef *myTable;
    myTable=[TableDef initTableDefText:@"TABLE LABEL HERE" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:DEF_TITLEFONTSIZE withTextFontName:nil footerText:@"This is a message with enough text to span multiple lines. This text is set at runtime and might be short or long." withFooterTextColor:[UIColor whiteColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
    
    
    myTable.tableFooterFixed=TRUE;
    
    
    SectionDef *sdPtr1;
    
    //   sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    
    sdPtr1=[[SectionDef alloc]init];
    [myTable.tableSections addObject:sdPtr1];
    //C E L L S    F O R        S E C T I O N S
    
    
    CellContentDef *cellContentPtr;
    CellTextDef *ctdPtr;
    
    
    
    NSString *cellString;
    for (int item=0; item<50; item++) {
        cellString=[NSString stringWithFormat:@"Section 1 Cell %d", item];
        
        if (item % 2) { // odd
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil];
        }
        else{//even
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
        }
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    }
    
    
    
    
    
    
    
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
    
}

-(TableDef *) makeFixedHeaderWithSectionsAndCells
{
    TableDef *myTable;
    myTable=[self createTextHeaderinTable:nil withText:@"TABLE HEADER"];
    
    
    myTable.tableHeaderFixed=TRUE;
    
    
    SectionDef *sdPtr1;
    
 //   sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    
    sdPtr1=[[SectionDef alloc]init];
    [myTable.tableSections addObject:sdPtr1];
    //C E L L S    F O R        S E C T I O N S
    
    
    CellContentDef *cellContentPtr;
    CellTextDef *ctdPtr;
    
    
    //create uiview cell in section 1
    
    //debug this--- has a problem with scrollingback up... uiview doesnt use passing colors,etc....
    // ctdPtr=[CellTextDef initCellText:@"Sec1 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
   // ctdPtr=[CellUIView initCellInUIViewWithCellText:@"Sec1 Cell0 0 but this is to span more than 1 row will it actually do that? nobody knows.  It is actually to span more than 3 lines but now a lot more than two is being managed" withTextColor:nil withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil andViewBackColor:[UIColor blueColor]];
    
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    
    ctdPtr=[CellTextDef initCellText:@"Section1 Cell 0 blah blah blah blah blah blah blah.  More more more more more more.  The end" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
    
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    
    
    NSString *cellString;
    for (int item=1; item<50; item++) {
        cellString=[NSString stringWithFormat:@"Section 1 Cell %d", item];
        
        if (item % 2) { // odd
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:0 withTextFontName:nil];
        }
        else{//even
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:0 withTextFontName:nil];
        }
        

        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
    }
    
    
    
    
    
    
    
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;

}
-(TableDef *) makeTitleWithUIViewAndSectionWith1UIViewCell
{
    TableDef *myTable;
    myTable=[self createTextHeaderinTable:nil withText:@"TABLE HEADER"];
    
    
    SectionDef *sdPtr1;
    
    sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N
    [self createContainerCells_Test1_ForSection:sdPtr1 sectionIdentifier:@"Section 0" numberOfTextCells:10];
    
  
    
    
    
    
    
    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}
-(TableDef *) makeTitleWithUIViewAndSection
{
    TableDef *myTable;
        myTable=[self createTextHeaderinTable:nil withText:@"TABLE HEADER"];
    
    
    SectionDef *sdPtr1;
    
    sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"MySection1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];

//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}
-(TableDef *)  makeTitleSection1_ButtonsSection2Cells
{
    TableDef *myTable;
    //create image only table header       note, footer is just a text cell
    myTable=[TableDef initTableHeaderImageName:@"buffy100x100" withBackgroundColor:[UIColor blueColor] footerText:@" Table - Footer" withFooterTextColor:[UIColor blueColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
    
    
    SectionDef *sdPtr1;
    SectionDef *sdPtr2;
    sdPtr1=[SectionDef initSectionHeaderAsButtons:[UIColor blueColor] footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];
    
    sdPtr2=[SectionDef initSectionHeaderText:@"mySection2 header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"mySection2 footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr2];

    //C E L L S    F O R        S E C T I O N S
    
    CellContentDef *cellContentPtr;
    CellTextDef *ctdPtr;
    
    //no cells section 1
    
    //create text cells in section 2
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
  
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];

    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}



-(TableDef *) makeTitleRotateWithTwoButtonSectionsNoRows
{
    TableDef *myTable;
    myTable=[TableDef initTableHeaderROTateImageName:@"buffy100x100" withBackgroundColor:[UIColor clearColor] footerText:nil withFooterTextColor:nil withFooterBackgroundColor:nil withFooterTextFontSize:0 withFooterTextFontName:nil];
    
    SectionDef *sdPtr1;
    SectionDef *sdPtr2;
    sdPtr1=[SectionDef initSectionHeaderAsButtons:[UIColor blueColor] footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];
    
    sdPtr2=[SectionDef initSectionHeaderAsButtons:[UIColor orangeColor] footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr2];
    
    
//[self.tablesToDisplayArray addObject:myTable];
    return myTable;
}

-(TableDef *) makeTitleSectionWithStackView
{
    TableDef *myTable;
    //create image only table header       note, footer is just a text cell
    myTable=[TableDef initTableHeaderImageName:@"buffy100x100" withBackgroundColor:[UIColor redColor] footerText:@" Table - Footer" withFooterTextColor:[UIColor blueColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
    
    //create section in table
    SectionDef *sdPtr1;

    
    
    sdPtr1=[SectionDef initSectionHeaderAsSimpleStackView:[UIColor blueColor] footerText:@" Section 1 - Footer" footerTextColor:[UIColor orangeColor] footerBackgroundColor:[UIColor blueColor] footerTextFontSize:18 footerTextFontName:nil];
 
    [myTable.tableSections addObject:sdPtr1];
    
    

    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}


-(TableDef *) makeTableHeaderSectionsRowsNoButtons
{
    
    
    
    TableDef *myTable;
    //H E A D E R     &     F O O T E R
    myTable=[TableDef initTableDefText:@"TABLE LABEL HERE" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:DEF_TITLEFONTSIZE withTextFontName:nil footerText:@"This is a message with enough text to span multiple lines. This text is set at runtime and might be short or long." withFooterTextColor:[UIColor whiteColor] withFooterBackgroundColor:[UIColor yellowColor] withFooterTextFontSize:DEF_TITLEFONTSIZE withFooterTextFontName:nil];
    
    //S E C T I O N S:    H E A D E R     &     F O O T E R
    
    SectionDef *sdPtr1;
    SectionDef *sdPtr2;
    SectionDef *sdPtr3;
    
    sdPtr1=[SectionDef initSectionHeaderText:@"mySection1 Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section 1 Footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject:sdPtr1];
     sdPtr2=[SectionDef initSectionHeaderText:@"mySection2 header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil footerText:@"Section2 footer" footerTextColor:[UIColor orangeColor]footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
     [myTable.tableSections addObject:sdPtr2];
     sdPtr3=[SectionDef initSectionHeaderText:@" Section3 - Header" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:18 withTextFontName:nil footerText:@" SECTION 3 - Footer" footerTextColor:[UIColor orangeColor] footerBackgroundColor:[UIColor blueColor] footerTextFontSize:0 footerTextFontName:nil];
     [myTable.tableSections addObject: sdPtr3];
     

    
    //C E L L S    F O R        S E C T I O N S
    
    CellContentDef *cellContentPtr;
     CellTextDef *ctdPtr;
    
    //no cells section 1
    
    //create text cells in section 2
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell1" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
   
    cellContentPtr=[[CellContentDef alloc] init];
    cellContentPtr.ccCellTypePtr=ctdPtr;
    cellContentPtr.ccTableViewCellPtr=nil;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    
    ctdPtr=[CellTextDef initCellText:@"Sec2 Cell2 this is a very long long long cell.  SO how many lines can this cell span?  Any information would be interesting for us to see" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
     [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
     
     ctdPtr=[CellTextDef initCellText:@"Sec2 Cell3 this too is  a very long long long long long cell. As a matter of fact it should take up multiple lines, but I'm not sure my logic will caclulate the maximum height of this cell by determining how many words it contains.  WIll it work or will it fail?  Nobody knows until it decides to display itself.  Can this go on forever" withTextColor:[UIColor orangeColor] withBackgroundColor:[UIColor yellowColor] withTextFontSize:0 withTextFontName:nil];
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
  
     [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    //create cells in section 3
    
    
     ctdPtr=[CellTextDef initCellText:@"Sec3 Cell1" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
   
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
     [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
     
     ctdPtr=[CellTextDef initCellText:@"Sec3 Cell2" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
   
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
     [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
     
     ctdPtr=[CellTextDef initCellText:@"Sec3 Cell3" withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil];
    
     cellContentPtr=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
     [sdPtr3.sCellsContentDefArr addObject:cellContentPtr];
     
     

    
    
    
 //    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
}
-(TableDef *)testButtonsFixedHeaderAndFooter
{
    TableDef *myTable;
    
//    myTable=[self createButtonsForFixedHeaderinTable:nil];
    CGSize btnSize = sizeGlobalButton;
    myTable=[self createButtonsForFixedFooterinTable:myTable withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N S
    [self createTextCellsForSection:sdPtr1 sectionIdentifier:@"section 0 " numberOfTextCells:50];
    
    
  //  [self.tablesToDisplayArray addObject:myTable];
    return myTable;
    
}

-(TableDef *)testButtonsFixedHeaderOnly
{
    TableDef *myTable;
    
 //   myTable=[self createButtonsForFixedHeaderinTable:nil];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N S
    [self createTextCellsForSection:sdPtr1 sectionIdentifier:@"section 0 " numberOfTextCells:50];
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
    
}
-(TableDef *)testButtonsFixedFooterOnly
{
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:nil withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N S
    [self createTextCellsForSection:sdPtr1 sectionIdentifier:@"section 0 " numberOfTextCells:50];
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
    
}
-(TableDef *)testCellImageLTextR
{
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:nil withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N S
    [self createImageLTextRCellsForSection:sdPtr1 sectionIdentifier:@"section 0 " numberOfTextCells:50];
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;

}
-(TableDef *)testCellImageOnly
{
    TableDef *myTable;
    CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
    myTable=[self createButtonsForFixedFooterinTable:nil withFooterBtns:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];// buttonsScroll:NO];
    
    SectionDef *sdPtr1;
    // SectionDef *sdPtr2;
    
    sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    
    
    //C E L L S    F O R        S E C T I O N
    [self createImageAllCellsForSection:sdPtr1  numberOfTextCells:50];
    
    
//    [self.tablesToDisplayArray addObject:myTable];
    return myTable;
    
}






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark CREATE Methods
/////////////////////////////////////////
-(void) createContainerCells_Test4_ForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{
    CellContentDef *cellContentPtr;
    CellUIView *cuvPtr;
    NSString *cellString;
//    NSString *internalLabelString;
    CellInputField *entryFPtr,*entryFPtr1;
//    CellImageOnly *cioPtr;
    CellTextDef *placeholderTxt;
    
    //create uiview cells
    for (int item=0; item<totalCells; item++) {
        
        
        cellString=[NSString stringWithFormat:@"Sec%@ Cell%d Lab0 this is a vey long string because I want to see it span multiple lines. Will it work?  It has before. How long can this cellstring actually be before it runs out of space to write", secIdentifier, item];
        
        
        cuvPtr=[[CellUIView alloc]init];
        
        cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
        // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM;//kDISP_TEMPLATE_BUTTONSLEFT_LABLESRIGHT;
        // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSLEFT_IMAGERIGHT;
        cuvPtr.displayTemplate=kDISP_TEMPLATE_INPUTFIELDS_ONLY;
        
        
        
        
        
        //DO entryField with PlaceHolder AND Label:   U S E R    I D
        entryFPtr=[[CellInputField alloc]init];
        
        placeholderTxt=[CellTextDef initCellText:@"alpha" withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
        placeholderTxt.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
        if (entryFPtr.placeholderTextDefPtr) {
            [entryFPtr.placeholderTextDefPtr killYourself];
        }
        entryFPtr.placeholderTextDefPtr=placeholderTxt;
        entryFPtr.leftSideDispTextPtr=[CellTextDef initCellText:@"Your User ID:" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
        entryFPtr.leftSideDispTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentRight;
        
       
        [cuvPtr.cInputFieldsArray addObject:entryFPtr];
        
        //DO entryField with PlaceHolder AND Label:     P A S S W O R D
        entryFPtr1=[[CellInputField alloc]init];
        
        placeholderTxt=[CellTextDef initCellText:@"alpha" withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
        placeholderTxt.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
        if (entryFPtr1.placeholderTextDefPtr) {
            [entryFPtr1.placeholderTextDefPtr killYourself];
        }
        entryFPtr1.placeholderTextDefPtr=placeholderTxt;
        entryFPtr1.leftSideDispTextPtr=[CellTextDef initCellText:@"Your Password:" withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
        entryFPtr1.secureEntry=TRUE;
        entryFPtr1.leftSideDispTextPtr.cellDispTextPtr.alignMe=NSTextAlignmentRight;
        
       
        [cuvPtr.cInputFieldsArray addObject:entryFPtr1];
        
        
        
        
        
        
        
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=cuvPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for this cell
    
    
}


-(void) createContainerCells_Test3_ForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{   //UI TEXT FIELDS - input
        CellContentDef *cellContentPtr;
    CellTextDef *txtTypePtr;
    CellTextDef *txtTypePtr1;
    
    CellInputField *entryFPtr;
    NSString *cellString;
    
    for (int item=0; item<totalCells; item++) {
        cellString=[NSString stringWithFormat:@"Sec%@ Cell%d ", secIdentifier, item];
        
        if (item % 2) { // odd
            
            entryFPtr=[[CellInputField alloc]init];
            
            txtTypePtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
            txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
            if (entryFPtr.placeholderTextDefPtr) {
                [entryFPtr.placeholderTextDefPtr killYourself];
            }
            entryFPtr.placeholderTextDefPtr=txtTypePtr;
            
            

            
        }
        else{   //even
  
            entryFPtr=[[CellInputField alloc]init];
            
            txtTypePtr=[CellTextDef initCellText:cellString withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
            txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
            if (entryFPtr.placeholderTextDefPtr) {
                [entryFPtr.placeholderTextDefPtr killYourself];
            }
            entryFPtr.placeholderTextDefPtr=txtTypePtr;
            
            
            txtTypePtr1=[CellTextDef initCellText:@"Descr:" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
            if (entryFPtr.leftSideDispTextPtr) {
                [entryFPtr.leftSideDispTextPtr killYourself];
            }
            entryFPtr.leftSideDispTextPtr=txtTypePtr1;

        }
        
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=entryFPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for this cell

    
}
-(void) createContainerCells_Test2_ForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{
    CellContentDef *cellContentPtr;
    CellUIView *cuvPtr;
    NSString *cellString;
 //   NSString *internalLabelString;
    CellImageOnly *cioPtr;
    CellButtonsScroll *cButPtr;
    CellTextDef *txtTypePtr;//, *txtTypePtr1, *txtTypePtr2;
    //create uiview cells
    for (int item=0; item<totalCells; item++) {
        cellString=[NSString stringWithFormat:@"Sec%@ Cell%d Lab0 this is a vey long string because I want to see it span multiple lines. Will it work?  It has before How long can this cell string actually be before it runs out of space to write?", secIdentifier, item];
        
        if (item % 2) { // odd
            
            cuvPtr=[[CellUIView alloc]init];
            
            txtTypePtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor whiteColor] withTextFontSize:20 withTextFontName:nil];
            txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
            [cuvPtr.cTextDefsArray addObject:txtTypePtr];
            cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
           // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM;//kDISP_TEMPLATE_BUTTONSLEFT_LABLESRIGHT;
           // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSLEFT_IMAGERIGHT;
            cuvPtr.displayTemplate=kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSTOP_LABELBOTTOM;
            
        }
        else{   //even
            cuvPtr=[[CellUIView alloc]init];
            txtTypePtr=[CellTextDef initCellText:cellString withTextColor:[UIColor blueColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:10 withTextFontName:nil];
            txtTypePtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;//NSTextAlignmentCenter;
            [cuvPtr.cTextDefsArray addObject:txtTypePtr];
            cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
           // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM;//kDISP_TEMPLATE_BUTTONSRIGHT_LABLESLEFT;
            cuvPtr.displayTemplate=kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP;
           // cuvPtr.displayTemplate=kDISP_TEMPLATE_BUTTONSRIGHT_IMAGELEFT;

        }
        
        
        //more text labels inside uiview cell
 
        CGSize btnSize = sizeGlobalButton;//CGSizeMake(60, 30);
        NSMutableArray *hdrButtons = [self buildSpecialButtons:BUTTONS_NORMAL_CELL inSection:0 withButtonNames:footerButtonNames1 withNextTVCs:footerButtonNextTableViews1 withButtonSize:btnSize];
        
        cButPtr=[CellButtonsScroll initCellDefaultsWithBackColor:[UIColor blueColor] withCellButtonArray:hdrButtons];// buttonScroll:NO];
        [cuvPtr.cButtonsArray addObject:cButPtr];
        
        cioPtr=[CellImageOnly initCellDefaults:nil withPNGName:@"buffy100x100" withBackColor:[UIColor blackColor] rotateWhenVisible:NO];
        [cuvPtr.cioPtrArr addObject:cioPtr];
        
        
        
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=cuvPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for this cell
    

}
-(void) createContainerCells_Test1_ForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{
    CellContentDef *cellContentPtr;
    CellUIView *ctdPtr;
    NSString *cellString;
    NSString *internalLabelString;
    CellImageOnly *cioPtr;
    
    //create uiview cells
    for (int item=0; item<totalCells; item++) {
        cellString=[NSString stringWithFormat:@"Sec%@ Cell%d Lab0 this is a vey long string because I want to see it span multiple lines. Will it work?  It has before. How long can this cellstring actually be before it runs out of space to write", secIdentifier, item];
        
        if (item % 2) { // odd
            ctdPtr=[CellUIView initCellInUIViewWithCellText:cellString withTextColor:[UIColor blackColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:20 withTextFontName:nil andViewBackColor:nil];
            //first string set and background color now set
            ctdPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
            
            // ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
            // ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT;
            ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT;
        }
        else{   //even
            ctdPtr=[CellUIView initCellInUIViewWithCellText:cellString withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:30 withTextFontName:nil andViewBackColor:nil];
            //first string set and background color now set
            ctdPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
            
            // ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
             ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT;
           // ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT;
        }
        
        //more text labels inside uiview cell
        for (int lab=1; lab<6; lab++) {
            internalLabelString=[NSString stringWithFormat:@"Sec%@ Cell%d Lab%d", secIdentifier, item,lab];
            CellTextDef *internalLabPtr;
            if (lab % 2) { // odd
                internalLabPtr=[CellTextDef initCellText:internalLabelString withTextColor:nil withBackgroundColor:[UIColor whiteColor] withTextFontSize:0 withTextFontName:nil];
            }
            else{
                internalLabPtr=[CellTextDef initCellText:internalLabelString withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:0 withTextFontName:nil];
            }
            [ctdPtr.cTextDefsArray addObject:internalLabPtr];
            
        }//end for labels in cell
        
        
        
        cioPtr=[CellImageOnly initCellDefaults:nil withPNGName:@"buffy100x100" withBackColor:[UIColor blackColor] rotateWhenVisible:NO];
        [ctdPtr.cioPtrArr addObject:cioPtr];
        
 

        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for this cell
    

}



-(void) createImageLTextRCellsForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{
    //C E L L S    F O R        S E C T I O N
    
    
    CellContentDef *cellContentPtr;
    CellImageLTextR *ctdPtr;
    NSString *cellString;
    
    
    //create uiview cell in section 0
    for (int item=0; item<totalCells; item++) {
        cellString=[NSString stringWithFormat:@"Section %@ Cell %d", secIdentifier, item];
        
        if (item % 2) { // odd
            
            ctdPtr=[CellImageLTextR initCellWithImageAndText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:15 withTextFontName:nil withImage:nil
                    withImageName:@"buffy100x100" withImageBackColor:[UIColor blackColor]];
            
            
 
        }
        else{//even
            
            ctdPtr=[CellImageLTextR initCellWithImageAndText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:15 withTextFontName:nil withImage:nil
                                               withImageName:@"buffy100x100" withImageBackColor:[UIColor blackColor]];
            

            
 
        }
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for

}
-(void) createImageAllCellsForSection:(SectionDef *)thisSectionPtr  numberOfTextCells:(int)totalCells
{
    //C E L L S    F O R        S E C T I O N
    
    
    CellContentDef *cellContentPtr;
    CellImageOnly *ctdPtr;
   
    
    
    //create uiview cell in section 0
    for (int item=0; item<totalCells; item++) {
      
        
        if (item % 2) { // odd
            
            ctdPtr=[CellImageOnly initCellDefaults:nil withPNGName:@"buffy100x100" withBackColor:viewBackColor rotateWhenVisible:NO];
            
        }
        else{//even
            ctdPtr=[CellImageOnly initCellDefaults:nil withPNGName:@"buffy100x100" withBackColor:viewBackColor rotateWhenVisible:NO];

            
        }
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for
    
}


-(void) createTextCellsForSection:(SectionDef *)thisSectionPtr sectionIdentifier:(NSString *)secIdentifier numberOfTextCells:(int)totalCells
{
    //C E L L S    F O R        S E C T I O N
    
    
    CellContentDef *cellContentPtr;
    CellTextDef *ctdPtr;
    NSString *cellString;
    
    
    //create uiview cell in section 0
    for (int item=0; item<totalCells; item++) {
        cellString=[NSString stringWithFormat:@"Section %@ Cell %d", secIdentifier, item];
        
        if (item % 2) { // odd
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
        }
        else{//even
            ctdPtr=[CellTextDef initCellText:cellString withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
        }
        
        
        cellContentPtr=[[CellContentDef alloc] init];
        cellContentPtr.ccCellTypePtr=ctdPtr;
        cellContentPtr.ccTableViewCellPtr=nil;
        [thisSectionPtr.sCellsContentDefArr addObject:cellContentPtr];
    }//end for
}
-(TableDef *) createTextHeaderinTable:(TableDef*)myTable withText:(NSString*)text
{
    //IF table nil, makeone
    
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableHeaderContentPtr) {
            [myTable.tableHeaderContentPtr killYourself];
        }
    }
    myTable.tableHeaderContentPtr.ccCellTypePtr=[CellTextDef initCellText:text withTextColor:viewTextColor withBackgroundColor:viewBackColor withTextFontSize:0 withTextFontName:nil];
    myTable.tableHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableHeaderFixed=FALSE;
    
    return myTable;
}
-(TableDef *) createEmptyTableDef:(TableDef *)myTable
{
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    return myTable;

}
-(TableDef *) createFixedTableHeaderUsingText:(NSString *)thisText forTable:(TableDef *)myTable
{
    //IF table nil, makeone
    
        if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableHeaderContentPtr) {
            [myTable.tableHeaderContentPtr killYourself];
        }
    }
    
    CellTextDef *ctdPtr=[CellTextDef initCellText:thisText withTextColor:self.viewTextColor withBackgroundColor:self.headerBackColor withTextFontSize:20 withTextFontName:nil];
    
        myTable.tableHeaderContentPtr.ccCellTypePtr=ctdPtr;
        ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    
    
    
    myTable.tableHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableHeaderFixed=TRUE;
    
    return myTable;
}
-(TableDef *) createFixedTableFooterUsingText:(NSString *)thisText forTable:(TableDef *)myTable
{
    //IF table nil, makeone
    
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableFooterContentPtr) {
            [myTable.tableFooterContentPtr killYourself];
        }
    }
    
    CellTextDef *ctdPtr=[CellTextDef initCellText:thisText withTextColor:self.viewTextColor withBackgroundColor:self.headerBackColor withTextFontSize:20 withTextFontName:nil];
    
    myTable.tableFooterContentPtr.ccCellTypePtr=ctdPtr;
    ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    
    
    
    myTable.tableFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableFooterFixed=TRUE;
    
    return myTable;
}

-(TableDef *) createButtonsForFixedHeaderinTable:(TableDef*)myTable withFooterBtns:(NSArray *)footerNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
    //    CGSize btnSize = CGSizeMake(60, 30);
    NSMutableArray *hdrButtons = [self buildSpecialButtons:BUTTONS_TITLE_HEADER inSection:0 withButtonNames:footerNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableHeaderContentPtr) {
            [myTable.tableHeaderContentPtr killYourself];
        }
    }
    
    //    CellButtonsScroll* thisButtonView = (CellButtonsScroll*) myTable.tableHeaderContentPtr.ccCellTypePtr;
    //   thisButtonView.buttonViewScrolls=YES;
    myTable.tableHeaderContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdrButtons];// buttonScroll:buttonsScroll];
    myTable.tableHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableHeaderFixed=TRUE;
    
    return myTable;
}

-(TableDef *) createButtonsForFixedFooterinTable:(TableDef*)myTable withFooterBtns:(NSArray *)footerNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
    //IF table nil, makeone
 //   CGSize btnSize = CGSizeMake(60, 30);
    NSMutableArray *hdrButtons = [self buildSpecialButtons:BUTTONS_TITLE_FOOTER inSection:0 withButtonNames:footerNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableFooterContentPtr) {
            [myTable.tableFooterContentPtr killYourself];
        }
    }
    
    myTable.tableFooterContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:hdrButtons];// buttonScroll:buttonsScroll];
    myTable.tableFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableFooterFixed=TRUE;
    
    return myTable;
}


-(SectionDef*) createButtonsAsSectionHeader:(SectionDef*)mySection sectionNumber:(int)secNum  inTable:(TableDef *)myTable withBtnNames:(NSArray *)butNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
  
    
    NSMutableArray *secButtons = [self buildSpecialButtons:BUTTONS_SEC_HEADER inSection:secNum withButtonNames:butNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
    
    
    
        if (mySection.sectionHeaderContentPtr) {
            [mySection.sectionHeaderContentPtr killYourself];
        }
        
    
    else{
        mySection=[[SectionDef alloc]init];
    }
    mySection.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    mySection.sectionHeaderContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:secButtons];// buttonScroll:buttonsScroll];
    mySection.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    mySection.sectionHeaderContentPtr.ccCellTypePtr.cellMaxHeight=btnSize.height+2;
    return mySection;

    
    
  }
-(SectionDef*) createDateButtonsAsSectionHeader:(SectionDef*)mySection sectionNumber:(int)secNum  inTable:(TableDef *)myTable actionReq:(ActionRequest*)actionReq withButtonSize:(CGSize)btnSize// nextTVC:(NSInteger)nextTVC// withBtnNames:(NSArray *)butNamesPtr withNextTVCs:(NSArray *)nextTVCsPtr withButtonSize:(CGSize)btnSize// buttonsScroll:(BOOL)buttonsScroll
{
    //    CGSize btnSize = CGSizeMake(60, 30);
    
//    NSMutableArray *secButtons = [self buildSpecialButtons:BUTTONS_SEC_HEADER inSection:secNum withButtonNames:butNamesPtr withNextTVCs:nextTVCsPtr withButtonSize:btnSize];
    
    NSMutableArray *secButtons = [self buildDatesButtons:actionReq forNumberOfDays:5 inSection:secNum withButtonSize:btnSize nextTVC:actionReq.nextTableView];
    if (mySection.sectionHeaderContentPtr) {
        [mySection.sectionHeaderContentPtr killYourself];
    }
    
    
    else{
        mySection=[[SectionDef alloc]init];
        [mySection.sectionFooterContentPtr killYourself];//no footers used here
        mySection.sectionFooterContentPtr=nil;
    }
    mySection.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    mySection.sectionHeaderContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaultsWithBackColor:viewBackColor withCellButtonArray:secButtons];// buttonScroll:buttonsScroll];
    mySection.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    mySection.sectionHeaderContentPtr.ccCellTypePtr.cellMaxHeight=btnSize.height+2;
    return mySection;
    
    
    
}

-(NSMutableArray*)buildDatesButtons:(ActionRequest*)pressedBtn forNumberOfDays:(int)numberOfDays inSection:(int)section withButtonSize:(CGSize)btnSize nextTVC:(NSInteger)nextTVC
{
    NSMutableArray *dateButtons = [self buildBasicButtonArray:BUTTONS_SEC_HEADER inSection:section inRow:0 buttonsPerRow:numberOfDays withButtonSize:btnSize];
//    NSMutableDictionary *aLocDicTMS = pressedBtn.locDict;// [self fetchLocationDict:pressedBtn];//pressedBtn.aLocDict;

//    [headerDateButtons removeAllObjects];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];;
    [dateFormatter setDateFormat:@"MMM dd"];
    NSString *todayStr = [dateFormatter stringFromDate:[NSDate date]];
    ActionRequest *aDateBtn;
    NSDate *aDate;// = [NSDate date];
    for (int i = 0; i < numberOfDays; i++){
        aDateBtn = [dateButtons objectAtIndex:i];
        aDate = [[NSDate date] dateByAddingTimeInterval:i*86400];
        aDateBtn.buttonDate=aDate;
        NSString *aShowingDate = [dateFormatter stringFromDate:aDate];
        if ([aShowingDate isEqualToString:todayStr])
            aShowingDate = @"Today";
        aDateBtn.buttonName = aShowingDate;
        aDateBtn.nextTableView=nextTVC;
        aDateBtn.reloadOnly = NO;
//        [self putLocationDictInParent:aDateBtn locDict:aLocDicTMS];
        aDateBtn.locDict=pressedBtn.locDict;
        aDateBtn.productDict=pressedBtn.productDict;
        aDateBtn.retRecordsAsDPtrs = [NSMutableArray arrayWithArray:pressedBtn.retRecordsAsDPtrs];
        aDateBtn.buttonIndex = i;
        aDateBtn.buttonType=kButtonTypeDate;
    }
        
    return dateButtons;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark BUTTON SUPPORT Methods
/////////////////////////////////////////

-(NSMutableArray*)buildSpecialButtons:(int)location inSection:(int)section withButtonNames:(NSArray *)buttonNamesPtr withNextTVCs:(NSArray *)nextTVCptr withButtonSize:(CGSize)btnSize
{

//    CGSize btnSize = CGSizeMake(60, 30);
    NSMutableArray *viewButtons = [self buildBasicButtonArray:location inSection:section inRow:0 buttonsPerRow:buttonNamesPtr.count withButtonSize:btnSize];
//    NSMutableArray *viewButtons = [self buildButtonsArray:location inSection:section inRow:0 buttonsPerRow:buttonNamesPtr.count withTotalNumberOfBtns:buttonNamesPtr.count withButtonSize:btnSize];
//    NSMutableArray *viewButtons = [self buildButtonsArray:location inSection:section inRow:0 totalButtonCount:buttonNamesPtr.count startingRecordIndex:0 buttonsPerCell:buttonNamesPtr.count withButtonSize:btnSize];
    ActionRequest *fBtn;
    for (int i=0; i < buttonNamesPtr.count; i++){
        fBtn = [viewButtons objectAtIndex:i];
        fBtn.buttonName= [buttonNamesPtr objectAtIndex:i];
        if (nextTVCptr)
            fBtn.nextTableView = [(NSNumber *)[nextTVCptr objectAtIndex:i] integerValue];
    }
    return viewButtons;
}
//-(NSMutableArray *)buildButtonsArray:(int)section inRow:(int)row totalButtonCount:(NSInteger)numberOfButtons startingRecordIndex:(int)startingIndex buttonsPerCell:(NSInteger)buttonsPerCell withButtonSize:(CGSize)btnSize;
-(NSMutableArray *)buildButtonsArray:(int)location inSection:(int)section inRow:(int)row buttonsPerRow:(NSInteger)buttonsPerRow withTotalNumberOfBtns:(NSInteger)totalNumberOfButtons withStartingIndex:(int)startingIndex withButtonSize:(CGSize)btnSize;
{
    NSMutableArray  *hdiButtonArray = [[NSMutableArray alloc] init];
    ActionRequest *hdiBtn;
    int sectionMod = kCellSectionModulus;
    int rowMod = kCellRowModulus;
    int locMod = kLocationModulus;
    NSInteger buttonsToMake = buttonsPerRow;
 //   NSInteger startingIndex = row*buttonsPerRow;
    NSInteger endingIndex = startingIndex + buttonsPerRow;
    if (endingIndex >= totalNumberOfButtons)
        buttonsToMake =  totalNumberOfButtons-startingIndex;
    for (int i = 0; i < buttonsToMake; i ++){
        hdiBtn = [[ActionRequest alloc] init];
        hdiBtn.buttonTag = locMod*location + sectionMod*section + rowMod*row + i;
        hdiBtn.buttonSize = btnSize;
        hdiBtn.tableRow= row;
        hdiBtn.tableSection= section;
        hdiBtn.buttonIndex = i;
        hdiBtn.reloadOnly = NO;
        [hdiButtonArray addObject:hdiBtn];
    }
    return hdiButtonArray;
}
-(NSMutableArray *)buildBasicButtonArray:(int)location inSection:(int)section inRow:(int)row buttonsPerRow:(NSInteger)buttonsPerRow withButtonSize:(CGSize)btnSize;
{
    
    ActionRequest *hdiBtn;
    int sectionMod = kCellSectionModulus;
    int rowMod = kCellRowModulus;
    int locMod = kLocationModulus;
    NSMutableArray  *hdiButtonArray = [[NSMutableArray alloc] init];
    for (int btnIndex = 0; btnIndex < buttonsPerRow; btnIndex ++){
        hdiBtn = [[ActionRequest alloc] init];
        hdiBtn.buttonTag = locMod*location + sectionMod*section + rowMod*row + btnIndex;
        hdiBtn.buttonSize = btnSize;
        hdiBtn.tableRow= row;
        hdiBtn.tableSection= section;
        hdiBtn.buttonIndex = btnIndex;
        hdiBtn.reloadOnly = NO;
        [hdiButtonArray addObject:hdiBtn];
    }
    return hdiButtonArray;
}
-(void)turnOnButton:(NSInteger)btnNumber inCellBtnArray:(NSMutableArray *)footerButtons
{
    ActionRequest *aFtrBtn;
    for (aFtrBtn in footerButtons){
        aFtrBtn.buttonIsOn = NO;
        if (aFtrBtn.nextTableView == btnNumber)
            aFtrBtn.buttonIsOn = YES;

    }
}
-(void)turnOnButtonAtIndex:(NSInteger)btnIndex inCellBtnArray:(NSMutableArray *)buttonArray
{
    ActionRequest *aBtn;
    for (int i = 0; i < buttonArray.count; i++){
        aBtn = [buttonArray objectAtIndex:i];
        aBtn.buttonIsOn = NO;
        if (btnIndex == i)
            aBtn.buttonIsOn = YES;
        
    }
}
-(void)turnOnSelectedDateBtn:(NSDate *)aDate inCellBtnArray:(NSMutableArray *)buttonArray
{
    ActionRequest *aBtn;
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CST"]];
    [dayFormatter setDateFormat:@"MMM dd"];
    NSString *aDateStr = [dayFormatter stringFromDate:aDate];
    NSString *btnDateStr;
    if (!aDate)
        aDate=[NSDate date];
    for (int i = 0; i < buttonArray.count; i++){
        aBtn = [buttonArray objectAtIndex:i];
        aBtn.buttonIsOn = NO;
        btnDateStr=[dayFormatter stringFromDate:aBtn.buttonDate];
        if ([aDateStr isEqualToString:btnDateStr])
            aBtn.buttonIsOn = YES;
        
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XTRA SUPPORT Methods
/////////////////////////////////////////
-(void)logwhatsup
{
    [self.liveRuntimePtr logwhatsup];
}

*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark SPLASH SCREEN DEF Methods
/////////////////////////////////////////

-(TableDef *) createFixedTableFooterUsingText:(NSString *)thisText forTable:(TableDef *)myTable
{
    //IF table nil, makeone
    
    if (!myTable) {
        //makeone
        myTable=[[TableDef alloc]init];
    }
    else{
        if (myTable.tableFooterContentPtr) {
            [myTable.tableFooterContentPtr killYourself];
        }
    }
    
    CellTextDef *ctdPtr=[CellTextDef initCellText:thisText withTextColor:self.viewTextColor withBackgroundColor:self.headerBackColor withTextFontSize:20 withTextFontName:nil];
    
    myTable.tableFooterContentPtr.ccCellTypePtr=ctdPtr;
    ctdPtr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
    
    
    
    myTable.tableFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    myTable.tableFooterFixed=TRUE;
    
    return myTable;
}

-(void)mkTableDefTesterSplashScreen0:(TableDef*)myTable
{
    //  this tests displayed text in section header and cells   - preserving background color/text color
    //  note it you pass nil to textColot cell will put text in black.  default text cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    
    //CellUIView and CellTextDef contain canMyRowHaveTVFocus
    
    SectionDef *sdPtr;
    SectionDef *sdPtr2;
    CellTextDef *ctdInSectionptr;
       myTable = [self createFixedTableHeaderUsingText:@"Fixed Table Header" forTable:myTable];
    
    myTable = [self createFixedTableFooterUsingText:@"Fixed Table Footer" forTable:myTable];
    sdPtr=[SectionDef initSectionHeaderText:@"mySection1" withTextColor:[UIColor blueColor] withBackgroundColor:viewBackColor withTextFontSize:35 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    ctdInSectionptr=(CellTextDef*) sdPtr.sectionHeaderContentPtr.ccCellTypePtr;
    ctdInSectionptr.canMyRowHaveTVFocus=YES;
    
    
    [myTable.tableSections addObject:sdPtr];
    sdPtr2=[SectionDef initSectionHeaderText:@"mySection2" withTextColor:[UIColor blueColor] withBackgroundColor:viewBackColor withTextFontSize:35 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject: sdPtr2];
    
    
    
    
    //create cells in section 1
    CellContentDef *cellContentPtr1;
    CellTextDef *ctdPtr;
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R1" withTextColor:[UIColor whiteColor] withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1.ccCellTypePtr=ctdPtr;
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R2" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R3" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R4" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R5" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R6" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R7" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R8" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R9" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    ///
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1 R10" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1 R11" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R12" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R13" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R14" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R15" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R16" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R17" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R18" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec1R19" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    ///
    //create cells in section 2
    
    
    ctdPtr=[CellTextDef initCellText:@"cellSec2R1" withTextColor:[UIColor whiteColor]withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    ctdPtr.cellSeparatorVisible=TRUE;
    ctdPtr.canMyRowHaveTVFocus=YES;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    ctdPtr=[CellTextDef initCellText:@"cellSec2R2" withTextColor:[UIColor whiteColor] withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    ctdPtr=[CellTextDef initCellText:@"cellSec2R3" withTextColor:[UIColor whiteColor] withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R4" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R5" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R6" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R7" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R8" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R9" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    ///
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2 R10" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2 R11" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    // ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R12" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R13" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R14" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //  ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R15" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R16" withTextColor:nil withBackgroundColor:viewBackColor withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R17" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R18" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    //   ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec2R19" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    ctdPtr.canMyRowHaveTVFocus=YES;   //added for section header scrolling test, TVOS
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    
    NSLog(@"");
    
    
}

-(void) mkTableDefSplashScreen:(TableDef*)myTable
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"uma300wx400h" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useWHoleSize=useImage.size;
    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaWave" withBackColor:[UIColor clearColor] rotateWhenVisible:NO withSize:useWHoleSize];
    myTable.tableHeaderContentPtr=nil;
    myTable.tableFooterContentPtr=nil;
    
    
    
    CellUIView *cuvPtr=[[CellUIView alloc]init];
    
    
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    cuvPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
    [cuvPtr.cioPtrArr addObject:cioPtr];
    cellContentPtr.ccCellTypePtr=cuvPtr;

    SectionDef *sdPtr1=[SectionDef initSectionHeaderCenteredText:@"MOVIE MANIA" withTextColor:viewTextColor withBackgroundColor:headerBackColor withTextFontSize:20 withTextFontName:nil footerCenteredText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];
}
-(CellUIView *)cuvPtrCreateTest
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"umaRuler300x400" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useQTRSize=CGSizeMake(useImage.size.width/4, useImage.size.height/4);//useImage.size;
    //CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaRuler" withBackColor:[UIColor blueColor] rotateWhenVisible:NO withSize:useQTRSize];
    CellUIView *cuvPtr=[[CellUIView alloc]init];
    
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    // cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;
    cuvPtr.displayTemplate=kDISP_TEMPLATE_IMAGEBOTTOM_LABELSTOP;
    [cuvPtr.cioPtrArr addObject:cioPtr];
    
    CellTextDef *ctdPtr;
    ctdPtr=[CellTextDef initCellText:@"MovieInfo" withTextColor:[UIColor redColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    [cuvPtr.cTextDefsArray addObject:ctdPtr];

    
    return cuvPtr;
}
-(void)mkTableDefTesterSplashScreen4:(TableDef*)myTable
{
    //  this tests cell UIView ability to preserving background color
    //  note  default  cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"umaRuler300x400" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useWHoleSize=useImage.size;
    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaRuler" withBackColor:[UIColor clearColor] rotateWhenVisible:NO withSize:useWHoleSize];
    myTable.tableHeaderContentPtr=nil;
    myTable.tableFooterContentPtr=nil;
    
    
    
    CellUIView *cuvPtr=[[CellUIView alloc]init];
    
    
    
    SectionDef *sdPtr=[SectionDef initSectionHeaderText:@"mySection1" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:18 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    CellContentDef *cellContentPtr1;
    CellTextDef *ctdPtr1;
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr1=[CellTextDef initCellText:@"cellSec11" withTextColor:[UIColor redColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil]; //was font size 36
    ctdPtr1.cellSeparatorVisible=TRUE;
    
    cellContentPtr1.ccCellTypePtr=ctdPtr1;
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    [myTable.tableSections addObject:sdPtr];
    
    
   
    
    //new test
    
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
   // cuvPtr.displayTemplate=kDISP_TEMPLATE_LABELS_ONLY;
    cuvPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
    [cuvPtr.cioPtrArr addObject:cioPtr];
    
    cellContentPtr.ccCellTypePtr=cuvPtr;
    
    
    
    SectionDef *sdPtr2=[SectionDef initSectionHeaderText:@"mySection2" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    //SectionDef *sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    // sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr2.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr2];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr];
    
    
    CellTextDef *ctdPtr;
    ctdPtr=[CellTextDef initCellText:@"cellSec21" withTextColor:[UIColor redColor] withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    [cuvPtr.cTextDefsArray addObject:ctdPtr];
    ctdPtr.cellSeparatorVisible=TRUE;
    ctdPtr=[CellTextDef initCellText:@"cellSec22" withTextColor:[UIColor redColor] withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    [cuvPtr.cTextDefsArray addObject:ctdPtr];
    ctdPtr.cellSeparatorVisible=TRUE;

    
}
-(void)mkTableDefTesterSplashScreen3:(TableDef*)myTable
{
    //  this tests cell UIView ability to preserving background color
    //  note  default  cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"umaRuler300x400" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useWHoleSize=useImage.size;
    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaRuler" withBackColor:[UIColor clearColor] rotateWhenVisible:NO withSize:useWHoleSize];
    myTable.tableHeaderContentPtr=nil;
    myTable.tableFooterContentPtr=nil;
    
    
    
    CellUIView *cuvPtr=[[CellUIView alloc]init];
    
 
    cuvPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    cuvPtr.displayTemplate=kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM;
    [cuvPtr.cioPtrArr addObject:cioPtr];
    cellContentPtr.ccCellTypePtr=cuvPtr;
    
    SectionDef *sdPtr1=[SectionDef initSectionHeaderText:nil withTextColor:nil withBackgroundColor:nil withTextFontSize:0 withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    sdPtr1.sectionHeaderContentPtr=nil;
    sdPtr1.sectionFooterContentPtr=nil;
    
    [myTable.tableSections addObject:sdPtr1];
    [sdPtr1.sCellsContentDefArr addObject:cellContentPtr];

    
}
-(void)mkTableDefTesterSplashScreen2:(TableDef*)myTable
{
    //  this tests displayed images  - preserving background color
    //  note  default  cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"umaRuler375x647" ofType:@"png"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"umaRuler300x400" ofType:@"png"];
    UIImage * useImage = [UIImage imageWithContentsOfFile:filePath];
    CGSize useWHoleSize=useImage.size;
    CellContentDef *cellContentPtr=[[CellContentDef alloc] init];
    
    CellImageOnly *cioPtr=[CellImageOnly initCellDefaults:useImage withPNGName:@"umaRuler" withBackColor:[UIColor clearColor] rotateWhenVisible:NO withSize:useWHoleSize];
    myTable.tableHeaderContentPtr=nil;
    myTable.tableFooterContentPtr=nil;
    
    
    
    
     //MAKE UMARuler image as CellImageOnly
     SectionDef *sdPtr=[[SectionDef alloc] init];
     sdPtr.sectionHeaderContentPtr=nil;
     sdPtr.sectionFooterContentPtr=nil;
     [myTable.tableSections addObject:sdPtr];
     cellContentPtr.ccCellTypePtr=cioPtr;
     [sdPtr.sCellsContentDefArr addObject:cellContentPtr];
    
    
}
-(void)mkTableDefTesterSplashScreen1:(TableDef*)myTable
{
    //  this tests displayed text in section header and cells   - preserving background color/text color
    //  note it you pass nil to textColot cell will put text in black.  default text cell background color is clearColor
    // IN RUNTIME.M  change the default color to something that will bleed through
    //   ---->     thistv.backgroundColor=[UIColor magentaColor];//self.gGTPptr.viewBackColor;
    
    
    
    SectionDef *sdPtr;
    SectionDef *sdPtr2;
    
    sdPtr=[SectionDef initSectionHeaderText:@"mySection1" withTextColor:[UIColor greenColor] withBackgroundColor:[UIColor blueColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    
    [myTable.tableSections addObject:sdPtr];
    sdPtr2=[SectionDef initSectionHeaderText:@"mySection2" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil footerText:nil footerTextColor:nil footerBackgroundColor:nil footerTextFontSize:0 footerTextFontName:nil];
    [myTable.tableSections addObject: sdPtr2];
    
    
    
    
    //create cells in section 1
    CellContentDef *cellContentPtr1;
    CellTextDef *ctdPtr;
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec11" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    cellContentPtr1.ccCellTypePtr=ctdPtr;
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    
    
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec12" withTextColor:nil withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    cellContentPtr1=[[CellContentDef alloc] init];
    ctdPtr=[CellTextDef initCellText:@"cellSec13" withTextColor:nil withBackgroundColor:nil withTextFontSize:sizeGlobalTextFontBig withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr.sCellsContentDefArr addObject:cellContentPtr1];
    
    //create cells in section 2
    
    
    ctdPtr=[CellTextDef initCellText:@"cellSec21" withTextColor:[UIColor whiteColor]withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    ctdPtr.cellSeparatorVisible=TRUE;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    ctdPtr=[CellTextDef initCellText:@"cellSec22" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    ctdPtr.cellSeparatorVisible=TRUE;
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];
    
    ctdPtr=[CellTextDef initCellText:@"cellSec23" withTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor greenColor] withTextFontSize:sizeGlobalTextFontMiddle withTextFontName:nil];
    ctdPtr.cellSeparatorVisible=TRUE;
    cellContentPtr1=[CellContentDef initCellContentDefWithThisCell:ctdPtr ];
    [sdPtr2.sCellsContentDefArr addObject:cellContentPtr1];

 

}

@end
