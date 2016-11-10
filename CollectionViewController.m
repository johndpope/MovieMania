//
//  ViewController.m
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "CollectionViewController.h"
#import "MovieCollectionViewCell.h"
//#import "Movie.h"
//#import "RestHandler.h"
//#import "MovieViewController.h"
#import "ActionRequest.h"
#import "TableProtoDefines.h"
#import "HDButtonView.h"

#define COLLECTION_VIEW_PADDING 60

//@interface ViewController () <UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//@property (strong, nonatomic) NSMutableArray *movies;

//@end

@implementation CollectionViewController
{
    HDButtonView *myButtonView;
    //    NSMutableArray *myButtons;
    UIScrollView* buttonContainerView;
    CGSize dateBtnSize;
    CGFloat height;
    int location;
//    UICollectionView *collectionView;
}

@synthesize collectionView;
@synthesize myButtons;

#pragma mark - Lifecycle

- (id)initWithButtons:(NSMutableArray*)myButtons viewFrame:(CGRect)thisFrame
{
    
    self = [super init];
    if (self) {
        
        self.view.frame = thisFrame;
        
        return self;
        
    }
    return nil;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    height = (CGRectGetHeight(self.view.frame)-(2*COLLECTION_VIEW_PADDING))/2;
//    self.movies = [NSMutableArray new];
    
//        [self fetchMovies];

//        _movies = [[RestHandler sharedInstance] fetchMovies];
        dateBtnSize = CGSizeMake(height * (9.0/16.0) * 0.8, height * 0.8);
 //       dateBtnSize = CGSizeMake(60,40);
        location = BUTTONS_NORMAL_CELL;
//        myButtons = [self buildDatesButtons:nil forNumberOfDays:(int)_movies.count inSection:0 withButtonSize:dateBtnSize nextTVC:0 inLocation:location];
        buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, dateBtnSize.width, dateBtnSize.height)];
//        myButtonView = [[HDButtonView alloc] initWithContainer:buttonContainerView buttonSequence:myButtons rowNumbr:0 withTVC:0];
    //custom flow layout http://stackoverflow.com/questions/20626744/uicollectionview-current-index-path-for-page-control
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.estimatedItemSize = CGSizeMake(1, 1);
    
    
    
    
    
    collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    NSLog(@"layout minimum line spacing %f",layout.minimumLineSpacing);
    layout.minimumLineSpacing = 10000.0f;
    
    NSLog(@"layout minimum interitem spacing %f",layout.minimumInteritemSpacing);
    layout.minimumInteritemSpacing=0;
    
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    
    
    [collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"movieCell"];
    
    [collectionView setBackgroundColor:[UIColor redColor]];
    
    // [_collectionView setBounces:TRUE];
    // [_collectionView setAlwaysBounceVertical:TRUE];
    
    [collectionView setScrollEnabled:TRUE];
    [collectionView setUserInteractionEnabled:TRUE];
    collectionView.allowsMultipleSelection = NO;//YES; //?
    collectionView.allowsSelection = YES; //this is set by default
    
    collectionView.contentInset=UIEdgeInsetsZero; //???
    //_collectionView.contentInset = UIEdgeInsetsMake(0, (self.view.frame.size.width-pageSize)/2, 0, (self.view.frame.size.width-pageSize)/2);
    
    
    
    
    
#if TARGET_OS_TV
    // tvOS-specific code
    
    
#else
    // IOS
    collectionView.pagingEnabled=YES;
    
#endif
    
    
    
    [self.view addSubview:collectionView];

    
}

#pragma mark - Data
/*
- (void)fetchMovies {
    [[RestHandler sharedInstance] fetchMovies:^(NSArray *movies) {
       
        self.movies = [NSMutableArray arrayWithArray:movies];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
}
*/
#pragma mark - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
 //   CGFloat height = (CGRectGetHeight(self.view.frame)-(2*COLLECTION_VIEW_PADDING))/2;
    
    return CGSizeMake(height * (9.0/16.0), height);
 // return dateBtnSize;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.myButtons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell"
                                                                           forIndexPath:indexPath];
    cell.indexPath = indexPath;
    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);
//    Movie *movie = [self.movies objectAtIndex:indexPath.row];
//    [cell updateCellForMovie:movie];
    ActionRequest *actionReq = [myButtons objectAtIndex:indexPath.row];
    UIButton *aButton = actionReq.uiButton;
    cell.myButton=aButton;
    cell.titleLabel.text
     = [NSString stringWithFormat:@"Movie %li",(long)indexPath.row];
    [cell.posterImageView addSubview:aButton];
    
    aButton.center = cell.posterImageView.center;
    [cell.contentView addSubview:aButton];
    
    
    
    
    if (cell.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMovie:)];
        tap.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeSelect]];
        [cell addGestureRecognizer:tap];
    }
    
    return cell;
}

#pragma mark - GestureRecognizer
- (void)tappedMovie:(UITapGestureRecognizer *)gesture {
    
    if (gesture.view != nil) {
        
        
        
        //example  below
        TableDef *myTable;
//        myTable=[[GlobalTableProto sharedGlobalTableProto] mkTableDefTesterSplashScreen1:nil]; //has text only
//        [GlobalTableProto sharedGlobalTableProto].tableDefInUse=myTable;
        //example above
        
        
       
        MovieCollectionViewCell* aCell = (MovieCollectionViewCell *)gesture.view;   // I need aCell to get the indexPath only
        
 //     Delete from here
        UIButton *myButton = aCell.myButton;
        NSInteger myTag = myButton.tag;
        NSString *tagString = [NSString stringWithFormat:@"%li",myTag];
        ActionRequest * pressedBtn = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:tagString];
//        Movie *movie = [self.movies objectAtIndex:aCell.indexPath.row];
         NSLog(@"indexPath.section = %li, indexPath.row = %li",aCell.indexPath.section,aCell.indexPath.row);
 //     To here
        NSIndexPath *indexPath = aCell.indexPath;
        
        
//       NSInteger touchInput = BUTTONS_NORMAL_CELL * kLocationModulus + indexPath.section*kCellSectionModulus+ indexPath.row*kCellRowModulus;// + 99;


//      Dan warning !!!  Collection View Row is same as Table View button index.
        NSInteger touchInput = location * kLocationModulus + indexPath.section*kCellSectionModulus+ indexPath.row;//p indexPath.row*kCellRowModulus;
        
        
 //       touchInput = touchInput + 88;
        NSNumber *touchedButton = [NSNumber numberWithInteger:touchInput];
/*      Redundant code, already done when Buttons were made
        CellContentDef* ccontentDefPtr = [sectionPtr.sCellsContentDefArr objectAtIndex:indexPath.row];
        CellTypesAll *aCell = ccontentDefPtr.ccCellTypePtr;
        ActionRequest *cellButton = [[ActionRequest alloc]init];
        cellButton.tableSection = indexPath.section;
        cellButton.tableRow = indexPath.row;
        cellButton.buttonTag = touchInput;
        cellButton.nextTableView = aCell.nextTableView;
        cellButton.buttonIndex = 0;
        cellButton.buttonDate = aCell.cellDate;
        cellButton.productDict=aCell.productDict;
        cellButton.locDict=aCell.locDict;
        cellButton.buttonType=aCell.buttonType;
        [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary setObject:cellButton forKey:[NSString stringWithFormat:@"%li",cellButton.buttonTag]];
*/
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];

        
//        MovieViewController *movieVC = (id)[self.storyboard instantiateViewControllerWithIdentifier:@"Movie"];
//        movieVC.movie = movie;
//        [self presentViewController:movieVC animated:YES completion: nil];
    }
    
}

#pragma mark - Focus
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
    if (context.previouslyFocusedView != nil) {
        
        MovieCollectionViewCell *cell = (MovieCollectionViewCell *)context.previouslyFocusedView;
        cell.titleLabel.font = [UIFont systemFontOfSize:17];
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    
    if (context.nextFocusedView != nil) {
        
        MovieCollectionViewCell *cell = (MovieCollectionViewCell *)context.nextFocusedView;
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        cell.titleLabel.textColor = [UIColor redColor];
    }
}
-(NSMutableArray*)buildDatesButtons:(ActionRequest*)pressedBtn forNumberOfDays:(int)numberOfDays inSection:(int)section withButtonSize:(CGSize)btnSize nextTVC:(NSInteger)nextTVC inLocation:(int)location
{
//    NSMutableArray *dateButtons = [self buildBasicButtonArray:BUTTONS_SEC_HEADER inSection:section inRow:0 buttonsPerRow:numberOfDays withButtonSize:btnSize];
    
//    NSMutableArray *dateButtons = [self buildBasicButtonArray:BUTTONS_NORMAL_CELL inSection:section inRow:0 buttonsPerRow:numberOfDays withButtonSize:btnSize];
    
    NSMutableArray *dateButtons = [self buildBasicButtonArray:location inSection:section inRow:0 buttonsPerRow:numberOfDays withButtonSize:btnSize];
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
//        aDateBtn.nextTableView=nextTVC;
        aDateBtn.reloadOnly = NO;
        //        [self putLocationDictInParent:aDateBtn locDict:aLocDicTMS];
//        aDateBtn.locDict=pressedBtn.locDict;
//        aDateBtn.productDict=pressedBtn.productDict;
//        aDateBtn.retRecordsAsDPtrs = [NSMutableArray arrayWithArray:pressedBtn.retRecordsAsDPtrs];
        aDateBtn.buttonIndex = i;
        aDateBtn.buttonType=kButtonTypeDate;
    }
    
    return dateButtons;
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
@end
