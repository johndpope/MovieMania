//
//  ViewController.m
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "CollectionViewHolder.h"
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

@implementation CollectionViewHolder
{
    HDButtonView *myButtonView;
    //    NSMutableArray *myButtons;
//    UIScrollView* buttonContainerView;
//    CGSize dateBtnSize;
    CGFloat height;
    int location;
//    UICollectionView *collectionView;
}

@synthesize collectionView;
@synthesize myButtons;

#pragma mark - Lifecycle

- (id)initWithButtons:(NSMutableArray*)buttons viewFrame:(CGRect)thisFrame
{
    
    self = [super initWithFrame:thisFrame];
    if (self) {
        self.myButtons=buttons;
        
  //      self.view = [[UIView alloc] initWithFrame:thisFrame];
  //      NSLog(@"collectionViewFrame = (%f, %f)", self.view.frame.size.width, self.view.frame.size.height);
       
        [self setUpCollectionView:thisFrame];
        return self;
        
    }
    return nil;
    

}

//- (void)viewDidLoad {
//    [super viewDidLoad];
-(void)setUpCollectionView:(CGRect)cvFrame
{
    height = (CGRectGetHeight(self.frame)-(2*COLLECTION_VIEW_PADDING))/2;
    ActionRequest *aBtn = [myButtons objectAtIndex:0];

 //       dateBtnSize = CGSizeMake(height * (9.0/16.0) * 0.8, height * 0.8);

        location = BUTTONS_NORMAL_CELL;
//        myButtons = [self buildDatesButtons:nil forNumberOfDays:(int)_movies.count inSection:0 withButtonSize:dateBtnSize nextTVC:0 inLocation:location];
//        buttonContainerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, dateBtnSize.width, dateBtnSize.height)];
//        myButtonView = [[HDButtonView alloc] initWithContainer:buttonContainerView buttonSequence:myButtons rowNumbr:0 withTVC:0];
    //custom flow layout http://stackoverflow.com/questions/20626744/uicollectionview-current-index-path-for-page-control
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.estimatedItemSize = CGSizeMake(50, 100);
    layout.estimatedItemSize=CGSizeMake(aBtn.buttonSize.width, aBtn.buttonSize.height);
    
    
    
    NSLog(@"collectionViewFrame = (%f, %f)", self.frame.size.width, self.frame.size.height);
    
//    collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
//    collectionView=self;
    NSLog(@"layout minimum line spacing %f",layout.minimumLineSpacing);
    layout.minimumLineSpacing = 10000.0f;
    
    NSLog(@"layout minimum interitem spacing %f",layout.minimumInteritemSpacing);
    layout.minimumInteritemSpacing=0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:cvFrame collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    
    
    [collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"movieCell"];
    
    [collectionView setBackgroundColor:[UIColor orangeColor]];
    
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
    
    [collectionView reloadData];
    
    [self addSubview:collectionView];
//    [collectionView reloadData];
}


#pragma mark - UICollectionView

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    CGFloat height = (CGRectGetHeight(self.view.frame)-(2*COLLECTION_VIEW_PADDING))/2;
    
 //   return CGSizeMake(height * (9.0/16.0), height);
 // return dateBtnSize;
     ActionRequest *aBtn = [myButtons objectAtIndex:0];
    return aBtn.buttonSize;
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
    if (!cell)
    {
        cell = [[MovieCollectionViewCell alloc] init];
    }

    
    cell.indexPath = indexPath;
    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);
//    Movie *movie = [self.movies objectAtIndex:indexPath.row];
//    [cell updateCellForMovie:movie];
    ActionRequest *actionReq = [myButtons objectAtIndex:indexPath.row];
    UIButton *aButton = actionReq.uiButton;
    cell.myButton=aButton;
 //   cell.titleLabel.text
//     = [NSString stringWithFormat:@"Movie %li",(long)indexPath.row];
    
//    cell.posterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,actionReq.buttonSize.width,actionReq.buttonSize.height)];
//    UIImageView *posterImageView = [[UIImageView alloc] initWithImage:actionReq.buttonImage];
//    [cell.posterView addSubview:posterImageView];
    
//    aButton.center = cell.posterView.center;
    CGSize cellSize = cell.contentView.bounds.size;
    [cell.contentView addSubview:aButton];
    aButton.center=cell.contentView.center;
//    [cell addSubview:aButton];
    
    
    if (cell.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMovie:)];
        tap.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeSelect]];
        [cell addGestureRecognizer:tap];
    }
    
    return cell;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
//    self.collectionView.dataSource = dataSourceDelegate;
//    self.collectionView.delegate = dataSourceDelegate;
//    self.collectionView.indexPath = indexPath;
//    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView reloadData];
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

@end
