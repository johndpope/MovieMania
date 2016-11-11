//
//  TableViewController.m

//
#import "TableViewController.h"



@interface TableViewController()

@property ( nonatomic, readwrite) TableDef *tableDataPtr;
@property (strong, nonatomic) GlobalTableProto *gGTPptr;
@property (strong, nonatomic) GlobalCalcVals *gGCVptr;
@property (nonatomic, readwrite) CGRect _myInitFrame;
@property (nonatomic, readwrite) BOOL _infoSet;
@end

@implementation TableViewController

@synthesize _myInitFrame;

//@synthesize inMovieVC;
- (id)initWithTableDataPtr:(TableDef *)tableDefPtr usingTableViewStyle:(UITableViewStyle)tvcStyle viewFrame:(CGRect)thisFrame
{
    _myInitFrame=thisFrame;//fixes scrolling problem in sections
    __infoSet=NO;
    self = [super init];
    if (self) {
       // self.title=@"TablePRO";
        self.tableDataPtr=tableDefPtr;
 //       NSLog(@"sep init style  %ld",(long)self.tableView.separatorStyle);
       // self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
 //       NSLog(@"sep init SET style  %ld",(long)self.tableView.separatorStyle);
       //self.tableView.separatorColor=[UIColor clearColor];
        
        
        [self assignDetails];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tvcDisplayVisible:)    //method
                                                     name:ConstTVCDisplayVisible          //const in TableProntoDefines.h
                                                   object:nil];
        
        
        
        return self;

    }
    return nil;
    
     
}
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
- (void) tvcDisplayVisible:(NSNotification *) notification
{
   // NSLog(@"NOTIFICATION FROM TVC viewDidLayoutSubviews");
    GlobalTableProto *gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    if (self.isViewLoaded && self.view.window){
    //if (self.isViewLoaded) {   //if (self.isViewLoaded && self.view.window){     myra put back?

    
        
        if (!self.tableDataPtr.tableDisplayFirstVisibleNotification) {
            NSLog(@"TVC isViewLoaded & TVC.Window  are TRUE Do FIrst notify");
            self.tableDataPtr.tableDisplayFirstVisibleNotification=TRUE;   //so only notify once per this table
            [[NSNotificationCenter defaultCenter] postNotificationName: ConstTVCDisplayedNotifyRuntime  object:nil];
        }
    }
    else { // viewController is not visible
        NSLog(@"TVC isViewLoaded & TVC.Window  ONE or BOTH are FALSE");
        [gGTPptr logwhatsup];
    }
   
    
    
    NSLog(@"");
}
// The following code will insert our custom fixed header view in the appropriate hierarchy
/*- (void) viewWillAppear:(BOOL)animated
{
    CGSize intrinsicSize = self.tableDataPtr.fixedHeaderUIView.intrinsicContentSize;
    CGFloat height = (intrinsicSize.height > 0) ? intrinsicSize.height : 100; // replace with some fixed value as needed
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGRect frame = CGRectMake(0, 0, width, height);
    
    self.tableDataPtr.fixedHeaderUIView.frame = frame;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(height, 0, 0, 0);
    
    UIView *wrapperView = self.tableView.subviews[0]; // this is a bit of a hack solution, but should always pull out the UITableViewWrapperView
    [self.tableView insertSubview:self.tableDataPtr.fixedHeaderUIView aboveSubview:wrapperView];
}*/
-(void) viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];
    // Get the subviews of the view
   // NSArray *subviews = [self.view subviews];
   // NSLog(@"TVCviewDidLayoutSubviews %p totalSubviews:%ld",self.view,[subviews count]);
   // BOOL myViewLoaded=[self isViewLoaded];
   // NSLog(@"TABLEVIEWCONTROLLER loaded? %d view.window %p ",myViewLoaded,self.view.window);
   // NSLog(@"%@ %@", NSStringFromCGRect(self.view.bounds),NSStringFromCGRect(self.view.frame));
    // Return if there are no subviews
 /*   if ([subviews count] == 0){
        
        return;
    }
    else{
        [self listSubviewsOfView:self.view];
    }*/
    
    
      if (!self.tableDataPtr.tableDisplayFirstVisibleNotification) {   //this is a two post kinda thing....can't know for sure its up
          [[NSNotificationCenter defaultCenter] postNotificationName: ConstTVCDisplayVisible  object:nil];
      }
}


- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0){
        
        return;
    }
    
    for (UIView *subview in subviews) {
        
        NSLog(@"   %p TVCSUBVIEW: %p", view,subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}
-(void) viewDidLoad{
    [super viewDidLoad];
    NSLog(@"TVCviewDidLoad");
    
    //do only once?
    if (!__infoSet) {
        //the following fixes TVOS tableview scrolling over fixed header AND gradient colors at top & bot of scrolling tableview
        
        //NSLog(@"0. TBVCTRL frame %@ bounds %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.view.bounds));
        self.view.maskView=nil;//tvos test - fixes scroll gradient but now scrolls over fixed header
        self.view.opaque=NO;//tvos test - fixes scroll gradient but now scrolls over fixed header
        self.view.clipsToBounds=YES;
       // NSLog(@"1. TBVCTRL frame %@ bounds %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.view.bounds));
        __infoSet=YES;
    }
    
    
    
    /*
#if TARGET_OS_TV


    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
//    [tapGestureRecognize requireGestureRecognizerToFail:tapRecognized:];
    [self.view addGestureRecognizer:tapGestureRecognize];
#endif
*/
}
-(void)tapRecognized:(id)sender
{
//    UIButton * uiButtonPressed = sender;
 //   [[NSNotificationCenter defaultCenter] postNotificationName:@"TapGestureReceived" object:sender];
    NSLog(@"Tap Gesture Received in TableViewController" );
//    NSNumber *touchedButton = [NSNumber numberWithInteger:self.buttonTag];
}


-(void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
#if TARGET_OS_TV
    
        [self setNeedsFocusUpdate];
        [self updateFocusIfNeeded];

#else
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
#endif
    
    
  //  [self.tableView reloadData]; //NO NO NO

}




-(void) viewWillAppear:(BOOL)animated
{
   // NSLog(@"sep viewwillappear hasstyle  %ld",(long)self.tableView.separatorStyle);
#if !TARGET_OS_TV
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
#endif
   // NSLog(@"sep viewwillappear sets style  %ld",(long)self.tableView.separatorStyle);
    NSLog(@"");
    
    [super viewWillAppear:animated];
}


- (void)loadView
{
    [super loadView];
#if !TARGET_OS_TV
    NSLog(@"sep loadview hasstyle  %ld",(long)self.tableView.separatorStyle);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        NSLog(@"sep loadview sets style  %ld",(long)self.tableView.separatorStyle);
    NSLog(@"");
#endif
   // [self assignDetails];
}
-(void) assignDetails
{
//    [GlobalCalcVals sharedGlobalCalcVals].tvc = self;
   
    
    
    // self.navigationItem.hidesBackButton=YES;      //no effect
    // self.navigationItem.backBarButtonItem.enabled=NO; //no effect
    // [self.navigationItem setHidesBackButton:YES animated:YES];   //no effect
    //[self.navigationItem setBackBarButtonItem:nil];   //this gets rid of "<"  or link  but 'back' still displays
    //[self.navigationItem setHidesBackButton:YES]; //no effect
    //below hides the <back link   so starup view controller is not accessible and the text "<back" isn't either

    
    self.navigationItem.leftBarButtonItem =     [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    
    
       
    self.gGTPptr=[GlobalTableProto sharedGlobalTableProto];
    self.gGCVptr=[GlobalCalcVals sharedGlobalCalcVals];
    self.gGCVptr.tableCreatedWidth=self.view.frame.size.width;
    self.gGCVptr.tableCreatedHeight=self.view.frame.size.height;
    NSLog(@"TABLE CREATED w: %f h:%f",self.view.frame.size.width,self.view.frame.size.height);
    
    CGRect mainRect=[[UIScreen mainScreen] bounds];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    NSLog(@"mainScreen bounds.size  %@",NSStringFromCGSize(result));
    
    // set the title
    //note    self = initialized and allocated by Runtime.m
    NSLog(@"tvctrlVIEW bounds %@  frame %@",NSStringFromCGRect(self.view.bounds),NSStringFromCGRect(self.view.frame));
    
    [self.tableDataPtr showMeInDisplay:self tvcCreatedWidth:self.view.frame.size.width tvcCreatedHeight:self.view.frame.size.height];      //causes table to be displayed
    
    
    
    
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  helper
//////////////////

-(UILabel *)makeALabel2LinesString:(NSString *)thisString
{
    UILabel *title;
    title = [[UILabel alloc] init];
    title.text=thisString;
    title.textColor=[UIColor blackColor];
    title.backgroundColor=[UIColor magentaColor];
    title.frame=CGRectMake(0, 0,20,40);
    title.numberOfLines=2;
    //title.intrinsicContentSize=CGSizeMake(100, 20);
    return title;
}

-(UILabel *)makeALabelSimpleString:(NSString *)thisString
{
    UILabel *title;
    title = [[UILabel alloc] init];
    title.text=thisString;
    title.textColor=[UIColor blackColor];
    title.backgroundColor=[UIColor blueColor];
    title.frame=CGRectMake(0, 0,100,20);
    //title.intrinsicContentSize=CGSizeMake(100, 20);
    return title;
}
-(UIStackView *) makeSimpleStackView
{
    
    
    
    
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
    

    UILabel *mlabel1 = [self makeALabelSimpleString:@"simple 1"];

    UILabel *mlabel2 = [self makeALabelSimpleString:@"simple 2"];
    [labelsStack addArrangedSubview:mlabel1];
    [labelsStack addArrangedSubview:mlabel2];
    
    
    
    return labelsStack;
    
    
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  Table View Data Source
// Customize the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    //NSLog(@"tableView titleForHeaderInSection:");
    // switch(section) //return text title for section
    // {
    //     case 0: return @"Profile";
    //     case 1: return @"Social";
    // }
    // return nil;
    
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
    NSString *answer=[sectionPtr.sectionHeaderContentPtr.ccCellTypePtr giveCellTextStr];
  //  NSLog(@"tableView titleForHeaderInSection:%@",answer);
    return answer;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
       // switch(section) //return footer title for section
    // {
    //     case 0: return @"FFFProfile";
    //     case 1: return @"FFFSocial";
    // }
    // return nil;
    
    
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
    NSString *answer=[sectionPtr.sectionFooterContentPtr.ccCellTypePtr giveCellTextStr];
   // NSLog(@"tableView titleForFooterInSection: %@",answer);

    return answer;
}



// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // return 2;
    NSInteger answer =[self.tableDataPtr.tableSections count];
    //NSLog(@"number of section is %d",answer);
    return answer;
}

// R E Q U I R E D   Return the number of rows for each section in your static table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    SectionDef *sectionPtr;
    
    
  /*  switch(section)
    {
        case 0:  return 2;  // section 0 has 2 rows
        case 1:  return 1;  // section 1 has 1 row
        default: return 0;
    };
   */
    
    sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
   NSInteger answer = [sectionPtr.sCellsContentDefArr count];
   // NSLog(@"section %ld number of rows is %ld",section,(long)answer);
    return answer;
}
//
//
//

// R E Q U I R E D    Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TABLEVIEWCONTROLLER cellForRowAtIndexPath sec:%ld  row:%ld",(long)indexPath.section, (long)indexPath.row);
    SectionDef *sectionPtr;
    sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:indexPath.section];
    
    if (!sectionPtr) {
        return nil;
    }
    
    
    CellContentDef *sectionCellsPtr;
    sectionCellsPtr=[sectionPtr.sCellsContentDefArr objectAtIndex:indexPath.row];
    if (!sectionCellsPtr) {
        return nil;
    }

    //UITableViewCell *thisCell=sectionCellsPtr.ccTableViewCellPtr;
    
    CustomTVCell *thisCell=sectionCellsPtr.ccTableViewCellPtr;
    int someSection = (int) indexPath.section;
    int someRow= (int) indexPath.row;
    
    
    
    [thisCell mkSelfForSection:someSection andRow:someRow onTableDef:self.tableDataPtr];
    
    
    
    thisCell.selectionStyle=UITableViewCellSelectionStyleNone;
  //   thisCell.focusStyle=UITableViewCellFocusStyleCustom;//tvos test- no change
   // thisCell.maskView=nil;//tvos test - no effect
   // thisCell.opaque=NO;//tvos test - no effect
   
    
    //do only once? works but moved to viewDidLoad
 /*   if (!__infoSet) {
        //the following fixes TVOS tableview scrolling over fixed header AND gradient colors at top & bot of scrolling tableview
        
        NSLog(@"0. TBVCTRL frame %@ bounds %@",NSStringFromCGRect(tableView.frame),NSStringFromCGRect(tableView.bounds));
        tableView.maskView=nil;//tvos test - fixes scroll gradient but now scrolls over fixed header
        tableView.opaque=NO;//tvos test - fixes scroll gradient but now scrolls over fixed header
        tableView.clipsToBounds=YES;
        NSLog(@"1. TBVCTRL frame %@ bounds %@",NSStringFromCGRect(tableView.frame),NSStringFromCGRect(tableView.bounds));
        __infoSet=YES;
    }
*/
    
    
    
    //do I have any subviews?
    int subsCount=[[thisCell.contentView subviews] count];
    
    //am I a reloadOnly and already exist?
    CellButtonsScroll *aButtonView;
    BOOL iamreloading=NO;
    if ([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellButtonsScroll class]]){
        aButtonView = (CellButtonsScroll*)sectionCellsPtr.ccCellTypePtr;
        if (aButtonView.reloadOnly){
            iamreloading=YES;
            NSLog(@"");
            return thisCell;
            
        }
    
    }
    
    
    
    
    
    
    //if (!iamreloading) {
    [[thisCell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    //}
    
    
    
    
    
    thisCell.contentView.backgroundColor=[UIColor clearColor];
    thisCell.backgroundColor=[UIColor clearColor];
    
   // thisCell.selectionStyle=UITableViewCellSelectionStyleNone;
   // thisCell.focusStyle=UITableViewCellFocusStyleDefault;   //turns white
    thisCell.focusStyle=UITableViewCellFocusStyleCustom;
    
    
    if ([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellMovieView class]]){
        CellMovieView *movieViewCell = (CellMovieView*)sectionCellsPtr.ccCellTypePtr;
        NSLog(@"movieActionReq.buttonName = %@",movieViewCell.movieActionReq.buttonName);
        
    }
    //UITableViewCell *answer;
   // UIView * additionalSeparator;
    
    // NSString *specificCell=[NSString stringWithFormat:@"Cell-%d-%d",i,c ];
    // NSLog(@"make cell %p text %@ withrect %@",cell,specificCell, NSStringFromCGRect(cell.contentView.frame));
    
    if ([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellCollectionView class]] && sectionCellsPtr.ccCellTypePtr.reloadOnly){
        CellCollectionView *aCollectionView = (CellCollectionView*)sectionCellsPtr.ccCellTypePtr;
        [thisCell addSubview:aCollectionView.collectionVH];
        return thisCell;
    }
    if ([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellButtonsScroll class]] && sectionCellsPtr.ccCellTypePtr.reloadOnly){
        aButtonView = (CellButtonsScroll*)sectionCellsPtr.ccCellTypePtr;
        [thisCell addSubview:aButtonView.buttonContainerView];
        
    }else{
        [sectionCellsPtr.ccCellTypePtr putMeInTableViewCell:thisCell withTVC:self maxWidth:self.tableDataPtr.tvcCreatedWidth maxHeight:self.tableDataPtr.tvcCreatedHeight];
        
        
        // works - ish    moved to cell
       // answer=thisCell;
      //  additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,answer.frame.size.height,self.tableDataPtr.tvcCreatedWidth,3)];
      //  additionalSeparator.backgroundColor = [UIColor yellowColor];
      //  [answer addSubview:additionalSeparator];
      //  sectionCellsPtr.ccCellTypePtr.cellMaxHeight=sectionCellsPtr.ccCellTypePtr.cellMaxHeight+3;
    }

    
    
    

     

    
    
    
    
      // [thisCell setNeedsLayout]; //?
     //  [thisCell layoutIfNeeded]; //?
    return thisCell;
    

    
 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SectionDef *sectionPtr;
    sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:indexPath.section];
    
    if (!sectionPtr) {
        return 0;
    }
    
    
    CellContentDef *sectionCellsPtr;
    sectionCellsPtr=[sectionPtr.sCellsContentDefArr objectAtIndex:indexPath.row];
    if (!sectionCellsPtr) {
        return 0;
    }
    
    UITableViewCell *thisCell=sectionCellsPtr.ccTableViewCellPtr;

   CGFloat answer= [sectionCellsPtr.ccCellTypePtr  provideCellHeight:thisCell];
   // NSLog(@"TVCtrl  heightForRowAtIndexPath:%f" ,answer);
    
    return answer;
    
     
    
    
}

//============================================================================================
#pragma mark  Table View Delegate - Modifying Header and Footer of Sections
//=======================================
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 //   NSLog(@"viewForHeaderinSection");
   // The returned object can be a UILabel or UIImageView object, as well as a custom view. This method only works correctly when tableView:heightForHeaderInSection: is also implemented.
    
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
  //  NSLog(@"show this section header %ld secptr %p",(long)section,sectionPtr);
    UIView *customView =[sectionPtr showMyHeaderInDisplay:self];;
    customView.backgroundColor= [UIColor clearColor];
    
    return customView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
   // NSLog(@"viewForFooterInSection");
    //The returned object can be a UILabel or UIImageView object, as well as a custom view. This method only works correctly when tableView:heightForFooterInSection: is also implemented
    
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
    
  //  NSLog(@"show this section footer %ld secptr %p",(long)section,sectionPtr);
    UIView *customView =[sectionPtr showMyFooterInDisplay:self];;
    customView.backgroundColor=[UIColor clearColor];

    
    return customView;
}


- (CGFloat)tableView:(UITableView *)tableView   heightForFooterInSection:(NSInteger)section
{
   // NSLog(@"heightForFooterInSection");
    //return 0 if no footer in this section
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
     int answer=0;
    if (sectionPtr) {
        answer=[sectionPtr heightForFooterInSection];

        return answer;
    }
    else
        return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{ //return 0 if no header in this section
    int answer=0;
    SectionDef *sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:section];
   // NSLog(@"heightForHeaderInSection");
    if (sectionPtr) {
        answer=[sectionPtr heightForHeaderInSection];
        NSLog(@"TVCTRL heightForHeaderInSection %ld is %d",(long)section,answer);
        if(answer < 1)
            NSLog(@"");
      //  if (answer > 0) {
      //      NSLog(@"CHECK THIS");
      //  }
       
        return [sectionPtr heightForHeaderInSection];
    }
    else{
        //NSLog(@"htforheaderinsection  ...sectionptr nil for %ld section",section);
       NSLog(@"TVCTRL heightForHeaderInSection %ld is 0",section);
        return 0;
    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{   //
  //  NSLog(@"willdisplayFooterView");
  //  SectionDef *sectionPtr=[self.gGTPptr.myTable.tableSections  objectAtIndex:section];
    //doesn't work - DON"T DO THIS HERE  it doesn't exist yet this is a 'will'
    // Background color
    //view.tintColor = [UIColor blueColor];//[UIColor colorWithRed:77.0/255.0 green:162.0/255.0 blue:217.0/255.0 alpha:1.0];
    // Text Color
  //  UITableViewHeaderFooterView *footerv = (UITableViewHeaderFooterView *)view;
    // [header.textLabel setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableSection"]]];
    // [footerv.textLabel setTextColor:[UIColor redColor]];
   // [footerv.textLabel setTextColor:sectionPtr.sFooterDispTText.textColor];
  //  UIColor *whatColor=[sectionPtr.sectionFooterCellPtr giveCellTextColor];
    
  //  [footerv.textLabel setTextColor:whatColor];

}



- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
  //  NSLog(@"willDisplayheaderView");
    //Tells the delegate that a header view is about to be displayed for the specified section.
  //  SectionDef *sectionPtr=[self.gGTPptr.myTable.tableSections  objectAtIndex:section];
    
    //doesn't work - DON"T DO THIS HERE - it doesn't exist yet this is a 'will'
    // Background color
    //view.tintColor = [UIColor blueColor];//[UIColor colorWithRed:77.0/255.0 green:162.0/255.0 blue:217.0/255.0 alpha:1.0];
    // Text Color
//    UITableViewHeaderFooterView *headerv = (UITableViewHeaderFooterView *)view;
   // [header.textLabel setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableSection"]]];
   // [headerv.textLabel setTextColor:[UIColor redColor]];
//    UIColor *whatColor=[sectionPtr.sectionHeaderCellPtr giveCellTextColor];
   // [headerv.textLabel setTextColor:sectionPtr.sHeaderDispTText.textColor];
   //TRAPS [headerv.textLabel setTextColor:whatColor];
 //TRAPS   [headerv.textLabel setTextColor:[UIColor yellowColor]];
    /*
    SectionDef *sectionPtr=[self.gGTPptr.myTable.tableSections  objectAtIndex:section];
    
    if (sectionPtr) {
        NSLog(@"TableViewController willDisplayHeaderView %p for section %ld",view,section);
        [sectionPtr vcWillDisplayHeaderView:view myVC:self];

    }
    else{
        NSLog(@"willDisplayHeaderView:  ...sectionptr nil for %ld section",section);
        
    }

    
    */
    
}
/*
NEVER called - requires custom uitableviewcell    -(void) setSelected:(BOOL)selected
{
    NSLog(@"TableViewController setSElected %d",selected);
}
 */
//============================================================================================
#pragma mark  Table View Delegate - Modifying Row of Section
//=======================================
// Configure the row selection code for any cells that you want to customize the row selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSInteger givenRow=indexPath.row;
    NSInteger givenSection=indexPath.section;
    NSLog(@"TABLEVIEWCONTROLLER didSelectRow   indexpath  section:%ld row:%ld",(long)givenSection,(long)givenRow);
    
    
    SectionDef *sectionPtr;
    CellContentDef *sectionCellsPtr;
    sectionPtr=[self.tableDataPtr.tableSections  objectAtIndex:indexPath.section];
    
    if (sectionPtr) {
       
        sectionCellsPtr=[sectionPtr.sCellsContentDefArr objectAtIndex:indexPath.row];
        
    }
    
    CellInputField *cifPtr;
    if([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellInputField class]]){
        NSLog(@"       didSelectRow that is CellInputField class");
        cifPtr=(CellInputField *)sectionCellsPtr.ccCellTypePtr;
        [cifPtr enterWasPressed];
        return;
    }
    
    
    if(!sectionCellsPtr.ccCellTypePtr.enableUserActivity){
         [tableView deselectRowAtIndexPath:indexPath animated:false];
        return;

    }
    

    
   


    NSInteger touchInput = BUTTONS_NORMAL_CELL * kLocationModulus + indexPath.section*kCellSectionModulus+ indexPath.row*kCellRowModulus;
    NSNumber *touchedButton = [NSNumber numberWithInteger:touchInput];

    CellContentDef* ccontentDefPtr = [sectionPtr.sCellsContentDefArr objectAtIndex:indexPath.row];
    
    CellTypesAll *aCell = ccontentDefPtr.ccCellTypePtr;
    ActionRequest *cellButton = [[ActionRequest alloc]init];


    cellButton.tableSection = indexPath.section;// indexPath.section;
    cellButton.tableRow = indexPath.row;
    cellButton.buttonTag = touchInput;
    cellButton.nextTableView = aCell.nextTableView;
    cellButton.buttonIndex = 0;
    cellButton.buttonDate = aCell.cellDate;

    cellButton.productDict=aCell.productDict;
    cellButton.locDict=aCell.locDict;
    cellButton.buttonType=aCell.buttonType;
 
    


    [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary setObject:cellButton forKey:[NSString stringWithFormat:@"%li",cellButton.buttonTag]];
    NSLog(@"             postsNotifcation userTOuchInput");
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];

    return;
    
    }

////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Focus
////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //HERE's the DEAL:   SAY NO if you want the contents of the row to handle the focus messages.  (i.e., they contain buttons)
    //TRICKY TRICKY TRICKY
    //when the button gets nextFocus, it alerts its cell owner it should have focus so it changes color, done in CustomTVCellControl
    
    
    CustomTVCell *cell=(CustomTVCell*)[tableView cellForRowAtIndexPath:indexPath];
    int section=(int) indexPath.section;
    int row=(int)indexPath.row;
    BOOL answer=cell.focusThisCellvar;
    NSString *it;
    if (answer) {
        it=@"YES";
    }
    else {
            it=@"no";

    }
        
    NSLog(@"TABLEviewCNTRLR canfocusRowAtInexPath  %@ section:%d row:%d ",it,section,row);
    NSLog(@"");
    
    return answer;

    
  
    
    
}

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
    
    NSString *classPREV;
    NSString *classNEXT;
    classPREV=NSStringFromClass([context.previouslyFocusedView class]);
    classNEXT=NSStringFromClass([context.nextFocusedView class]);
    
    NSLog(@"***TABLEViewController didUpdateFocusInContext:   prevFoc %@   nextFoc(GO FOCUS)  %@",classPREV, classNEXT);
 
/*
    if ([context.nextFocusedView isKindOfClass:[UIButton class]]){
        UIButton *cellNext = (UIButton* )context.nextFocusedView;
        cellNext.superview.backgroundColor=[UIColor greenColor];
        NSString *nextTag = [NSString stringWithFormat:@"%li",cellNext.tag];
        ActionRequest *nextButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:nextTag];
        NSLog(@"nextButton.buttonName = %@",nextButton.buttonName);
        //       currentButtonInCenter=nextButton;
//        selectedButton=nextButton;
        [coordinator addCoordinatedAnimations:^{
            context.nextFocusedView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            // cellNext.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:nil];
        
        if (nextButton.reloadOnly){
            
//            currentButtonInCenter=selectedButton;
//            [self moveToButtonInCenter:currentButtonInCenter.buttonIndex];
        }
        
    }
    if ([context.previouslyFocusedView isKindOfClass:[UIButton class]]){
        
        UIButton *cellPrev = (UIButton* )context.previouslyFocusedView;
        cellPrev.superview.backgroundColor=[UIColor clearColor];
        NSString *prevTag = [NSString stringWithFormat:@"%li",cellPrev.tag];
        ActionRequest *prevButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:prevTag];
        NSLog(@"preButton.buttonName = %@",prevButton.buttonName);
        
        [coordinator addCoordinatedAnimations:^{
            context.previouslyFocusedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            //cellPrev.imageView .transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
        
        
    }
 */ 
    if ([context.previouslyFocusedView isKindOfClass:[UITableViewCell class]]){
        
        UITableViewCell *thisTVC = (UITableViewCell*)context.previouslyFocusedView;
        
        thisTVC.contentView.layer.borderColor=[UIColor clearColor].CGColor;
        
        
    }
    if ([context.nextFocusedView isKindOfClass:[UITableViewCell class]]){
        UITableViewCell *thisTVC = (UITableViewCell*)context.nextFocusedView;

        
        thisTVC.contentView.layer.borderColor = [UIColor greenColor].CGColor;
        thisTVC.contentView.layer.borderWidth = 3.0;
        
        
    }
    
    
    
    
    
    
    
}
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollViewDelegate
////////////////////////////////////////////////////////////////////////////////////////
/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"do I get scrollViewDidScroll messages?");
    NSLog(@"scrollview %p",scrollView);
   // CGRect rect = self.toolbarContainerView.frame;
  //  rect.origin.y = MIN(0,scrollView.contentOffset.y + scrollView.contentInset.top);
    //self.toolbarContainerView.frame = rect;
    
    
    // Adjust the header's frame to keep it pinned to the top of the scroll view
    CGRect headerFrame = self.tableDataPtr.fixedHeaderUIView.frame;
    CGFloat yOffset = scrollView.contentOffset.y;
    headerFrame.origin.y = MAX(0, yOffset);
    self.tableDataPtr.fixedHeaderUIView.frame = headerFrame;
    
    // If the user is pulling down on the top of the scroll view, adjust the scroll indicator appropriately
    CGFloat height = CGRectGetHeight(headerFrame);
    if (yOffset< 0) {
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(ABS(yOffset) + height, 0, 0, 0);
    }
    
    
    
}*/
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  Button processing
////////////////////////////////////////////////////////////////////////////////////////

/*
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    //called after the focus has changed
    
//    UITableViewCell *cellNext = (UITableViewCell* )context.nextFocusedView;
    
 //   UITableViewCell *cellPrev = (UITableViewCell* )context.previouslyFocusedView;
    
    
        //LET CELL PROCESS THIS?
    //just update our focus engine var so we know what is currentle being focused on
    
    //only TVOS gets this message
    
    
//    CustomTVCellControl * previouslyFocusedCell=(CustomTVCellControl*)context.previouslyFocusedView;
//    CustomTVCellControl *nextFocusedCell=(CustomTVCellControl *)context.nextFocusedView;
    
//    NSLog(@"TABLEviewCNTRLR prevFoc:sect%d item %d   nextFoc(GO FOCUS):sect%d  item %d",previouslyFocusedCell.dispAsSection,previouslyFocusedCell.dispAsRow, nextFocusedCell.dispAsSection, nextFocusedCell.dispAsRow);
    
    if (context.nextFocusedView != nil) {
        
        
 //       _customCellInFocus=nextFocusedCell;
 //       _customInFocusIndexPath=nil;  //how to get?
    }
}
 */
/////////////////////////////////////////////////////////////////////////
#pragma mark - GestureRecognizer
/////////////////////////////////////////////////////////////////////////
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"COLLECTIONviewCNTRLR GestureAsking permission");
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    //NSLog(@"COLLECTIONviewCNTRLR Gesturerecv touch");
    //NSLog(@"%@", NSStringFromCGPoint([touch locationInView:self.view]));
    return YES;
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"COLLECTIONviewCNTRLR handleLongPress");
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
}
-(void)didSwipeRight: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Right");
    NSLog(@"");
}

-(void)didSwipeLeft: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Left");
    NSLog(@"");
}
-(void)didSwipeUp: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Up");
    NSLog(@"");
}
-(void)didSwipeDown: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Down");
    NSLog(@"");
}



@end
