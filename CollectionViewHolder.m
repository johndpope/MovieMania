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
//#import "HDButtonView.h"
#import "GlobalTableProto.h"
#import "Runtime.h"

#define COLLECTION_VIEW_PADDING 60

//@interface ViewController () <UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//@property (strong, nonatomic) NSMutableArray *movies;

//@end

@implementation CollectionViewHolder
{
//    HDButtonView *myButtonView;
 
    int location;
    ActionRequest *currentButtonInCenter;
    ActionRequest *selectedButton;
    NSMutableArray *buttonSequence;
    CGPoint _lastContentOffset;
    int _originalMaxButtonsVisible;
    BOOL containerScrolls;
    BOOL buttonWasPressed;
    float   buttonWidth;
    float   buttonHeight;
    float   buttonViewWidth;
    float   buttonSpacing;
    float   buttonViewHeight;
    UITableViewController *tvc;
    int     numberOfButtonsToMake;
    float buttonViewXOffset;

    UIColor *textColor;
    UIColor *backColor;
}

@synthesize collectionView;
@synthesize buttonSequence;// myButtons;
@synthesize tvfocusAction;
@synthesize containerView;
@synthesize rowNumber;
#pragma mark - Lifecycle

- (id)initWithButtons:(NSMutableArray*)buttons viewFrame:(CGRect)thisFrame forContainer:(UIScrollView*)container viewScrolls:(BOOL)viewScrolls
{
    
    self = [super initWithFrame:thisFrame];
    if (self) {
//        self.myButtons=buttons;
        self.buttonSequence=buttons;
        self.containerView=container;
        containerScrolls=viewScrolls;
  //      self.view = [[UIView alloc] initWithFrame:thisFrame];
  //      NSLog(@"collectionViewFrame = (%f, %f)", self.view.frame.size.width, self.view.frame.size.height);
       
        [self setUpCollectionView:thisFrame];
        self.backgroundColor=[UIColor redColor];
        return self;
        
    }
    return nil;
    

}
- (id)initWithContainer:(UIScrollView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr withTVC:(TableViewController *)tvcPtr// leftJustifyPartial:(BOOL)
{
    
    tvc = tvcPtr;
    //    [self addTestButtonsToArray:btnSequence];
    self.containerView = container;
    
    self.buttonSequence = btnSequence;
    self.rowNumber = rowNmbr;
    textColor = [GlobalTableProto sharedGlobalTableProto].viewTextColor;
    backColor =  [GlobalTableProto sharedGlobalTableProto].viewBackColor;

    ActionRequest *firstButton = [buttonSequence objectAtIndex:0];

    buttonViewWidth =  containerView.bounds.size.width;
    buttonViewHeight = containerView.bounds.size.height;
    //   buttonViewHeight = 100;
    buttonWidth = firstButton.buttonSize.width;// buttonViewHeight;
    buttonHeight = firstButton.buttonSize.height;
/*
    isColumn = NO;
    if (buttonViewHeight > buttonViewWidth)
        isColumn = YES;
    if (isColumn)
        buttonWidth = buttonViewWidth;
*/
    //   buttonSpacing = buttonWidth/2;
    buttonSpacing = buttonWidth/10;
    
    //    if (kAutoScroll){
    containerScrolls = NO;
    
    if (buttonViewWidth < (buttonSequence.count * (buttonWidth + buttonSpacing))){
        containerScrolls = YES;
        
    }else{
        buttonSpacing = buttonWidth/4;
    }
    numberOfButtonsToMake =(int) buttonSequence.count;
    
    buttonViewXOffset = buttonViewWidth/2 - numberOfButtonsToMake * (buttonWidth/2 + buttonSpacing/2) + buttonSpacing/2;
/*
    if (isColumn)
        buttonViewXOffset = buttonViewHeight/2 - numberOfButtonsToMake * (buttonWidth/2 + buttonSpacing/2) + buttonSpacing/2;
*/
    if (containerScrolls){
        //       buttonViewWidth = (buttonSequence.count+ 2) * (buttonWidth + buttonSpacing);
        buttonViewXOffset=0;
        if(firstButton.reloadOnly) {
            buttonViewXOffset =  containerView.bounds.size.width/2 - buttonWidth/2;
        }
#if TARGET_OS_TV
        buttonViewXOffset =  containerView.bounds.size.width/2 - buttonWidth/2;
#endif
        buttonViewWidth = (buttonSequence.count) * (buttonWidth + buttonSpacing) + buttonViewXOffset;
        self.containerView.delegate = self;
        self.containerView.decelerationRate=UIScrollViewDecelerationRateFast;
    }
    CGRect frame = CGRectMake( 0,0,buttonViewWidth , container.bounds.size.height);
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
//        _originalFrame=containerView.frame;
        _originalMaxButtonsVisible=containerView.frame.size.width / buttonWidth;
//        _originalButtonWidth=buttonWidth;
/*
        UIImage *yellowBoxImage =  [UIImage imageNamed:@"select1.png"];
        selectedBtnBox = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,firstButton.buttonSize.width ,firstButton.buttonSize.height)];
        [selectedBtnBox setImage:yellowBoxImage];
        selectedBtnBox.backgroundColor = [UIColor clearColor];
        
*/
     //   [self addButtonsToView];//:containerScrolls ];//] buttonSequence:btnSequence];
        
        [self setUpCollectionView:frame];
        
        
        
        
        
    }
    return self;
    
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
-(void)setUpCollectionView:(CGRect)cvFrame
{
 //   buttonSequence=myButtons;
    
//    height = (CGRectGetHeight(self.frame)-(2*COLLECTION_VIEW_PADDING))/2;
    ActionRequest *aBtn;    for (ActionRequest *aBtn in buttonSequence){
        [HDButtonView makeUIButton:aBtn inButtonSequence:buttonSequence];
//
//    for (aBtn in buttonSequence){
        [aBtn.uiButton addTarget: self action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpInside];
        [aBtn.uiButton addTarget: self action:@selector(touchUpOnButton:)  forControlEvents:UIControlEventTouchUpOutside];
    }
    
    aBtn = [buttonSequence objectAtIndex:0];
    location = BUTTONS_NORMAL_CELL;
    //custom flow layout http://stackoverflow.com/questions/20626744/uicollectionview-current-index-path-for-page-control
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.estimatedItemSize=CGSizeMake(aBtn.buttonSize.width, aBtn.buttonSize.height);
    
    
    
    NSLog(@"collectionViewFrame = (%f, %f)", self.frame.size.width, self.frame.size.height);
    
    NSLog(@"layout minimum line spacing %f",layout.minimumLineSpacing);
//    layout.minimumLineSpacing = 10000.0f;
    
    NSLog(@"layout minimum interitem spacing %f",layout.minimumInteritemSpacing);
    buttonSpacing=aBtn.buttonSize.width/10;
    layout.minimumInteritemSpacing=buttonSpacing;
    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

    self.collectionView = [[UICollectionView alloc] initWithFrame:cvFrame collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    
    
    [collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"movieCell"];
    
    [collectionView setBackgroundColor:[UIColor blueColor]];
    
    // [_collectionView setBounces:TRUE];
    // [_collectionView setAlwaysBounceVertical:TRUE];
    
    [collectionView setScrollEnabled:TRUE];
    [collectionView setUserInteractionEnabled:TRUE];
    collectionView.allowsMultipleSelection = NO;//YES; //?
    collectionView.allowsSelection = YES; //this is set by default
    
    collectionView.contentInset=UIEdgeInsetsZero; //???
    //_collectionView.contentInset = UIEdgeInsetsMake(0, (self.view.frame.size.width-pageSize)/2, 0, (self.view.frame.size.width-pageSize)/2);
    
    
        collectionView.decelerationRate=UIScrollViewDecelerationRateNormal;
    
    
#if TARGET_OS_TV
    // tvOS-specific code
    
    
#else
    // IOS
    collectionView.pagingEnabled=YES;
    
#endif
    if (aBtn.reloadOnly){
        NSLog(@"CollectionViewHolder addButtonsToView   INIT button in center buttonsCount %ld ",[buttonSequence count]);
        [self initButtonInCenterToRow0Btn0];
    }
    [collectionView reloadData];
    
    [self addSubview:collectionView];
//    [collectionView reloadData];
}


#pragma mark - UICollectionView

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    CGFloat height = (CGRectGetHeight(self.view.frame)-(2*COLLECTION_VIEW_PADDING))/2;
    
 //   return CGSizeMake(height * (9.0/16.0), height);
 // return dateBtnSize;
     ActionRequest *aBtn = [buttonSequence objectAtIndex:0];
    return aBtn.buttonSize;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.buttonSequence.count;
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
    ActionRequest *actionReq = [buttonSequence objectAtIndex:indexPath.row];
    actionReq.buttonIndexPath=indexPath;
    UIButton *aButton = actionReq.uiButton;
    
    cell.myButton=aButton;
 //   cell.titleLabel.text
//     = [NSString stringWithFormat:@"Movie %li",(long)indexPath.row];
    
//    cell.posterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,actionReq.buttonSize.width,actionReq.buttonSize.height)];
//    UIImageView *posterImageView = [[UIImageView alloc] initWithImage:actionReq.buttonImage];
//    [cell.posterView addSubview:posterImageView];
    
//    aButton.center = cell.posterView.center;

    NSLog(@"cell.contentView.subview.count = %ld", cell.contentView.subviews.count);
    for (UIView *subView in cell.contentView.subviews){
        [subView removeFromSuperview];
    }
 //   CGSize cellSize = cell.contentView.bounds.size;
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
/*
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
//    self.collectionView.dataSource = dataSourceDelegate;
//    self.collectionView.delegate = dataSourceDelegate;
//    self.collectionView.indexPath = indexPath;
//    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView reloadData];
}

*/

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
/*
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
 */
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  Scroll View processing
////////////////////////////////////////////////////////////////////////////////////////
-(void)touchUpOnButton:(id)sender   //touchUpInside, touchUpOutside
{
    UIButton * uiButtonPressed = sender;
    NSLog(@"CollectionViewHolder touch up on Button Number %li",(long)uiButtonPressed.tag);
    
    [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
    
    
    NSNumber *touchedButton = [NSNumber numberWithInteger:uiButtonPressed.tag];
    NSString *tagString = [touchedButton stringValue];
    ActionRequest *pressedAction = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:tagString];
    
    if (pressedAction.reloadOnly){
        
        buttonWasPressed=YES;
        NSLog(@"buttonWasPressed = YES");
        [self moveToButtonInCenter:pressedAction.buttonIndex];
    }
    NSLog(@"myra disabled postNotification ConstUserTouchInput from CollectionViewHolder touchUpOnButton");
    // [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];   //this causes reload of table (do through another way)
}




- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    return;
    //  [selectedBtnBox removeFromSuperview];
    
    NSLog(@"CollectionViewHolder scrollViewDidScroll %f", scrollView.contentOffset.x);
    if (ABS(_lastContentOffset.x - scrollView.contentOffset.x) < ABS(_lastContentOffset.y - scrollView.contentOffset.y)) {
        NSLog(@"     Scrolled Vertically");
    } else {
        NSLog(@"     Scrolled Horizontally");
    }
    CGPoint newOffset = CGPointMake(_lastContentOffset.x, _lastContentOffset.y);
    
    if (newOffset.x > scrollView.contentOffset.x) {
        NSLog(@"     Scrolling direction is left");
    }else{
        NSLog(@"     Scrolling direction is right");
    }
    /* if (scrollView.contentOffset.x <= -1) {
     [scrollView setScrollEnabled:NO];
     [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
     [scrollView setScrollEnabled:YES];
     }
     */
    
    
    
}
-(void) logCBCtag
{
    NSNumber *aButtontag ;
    aButtontag = [NSNumber numberWithInteger:currentButtonInCenter.buttonTag];
    NSLog(@"      current button in center has tag %@ %@",aButtontag,currentButtonInCenter.buttonName);
}

-(void) leftJustifyScrollViewSelection:(UIScrollView *)scrollView
{
    //ONLY CALLED BY TVOS
    
    CGPoint currentOffset=scrollView.contentOffset;
    
    
    
    
    
    CGPoint newOffset = CGPointMake((currentButtonInCenter.buttonIndex)*(currentButtonInCenter.uiButton.bounds.size.width+buttonSpacing),0);
    NSLog(@"** CollectionViewHolderleftJustifyScrollViewSelection old:%@   new:%@",NSStringFromCGPoint(currentOffset),NSStringFromCGPoint(newOffset));
    
    int buttonsToMyRight=((int)[currentButtonInCenter.buttonArrayPtr count])-(int)currentButtonInCenter.buttonIndex;
    if (_originalMaxButtonsVisible > buttonsToMyRight) {
        NSLog(@"        ****************THIS DOES POP spaceCanShow %d  right %d",_originalMaxButtonsVisible,buttonsToMyRight);
        //NO   self.bounds=CGRectMake(0, 0, _originalButtonWidth*buttonsToMyRight, _originalFrame.size.height);
        NSLog(@"");
        
    }
    else{
        //NO self.bounds=_originalFrame;
    }
     if (containerScrolls){

         [self.collectionView scrollToItemAtIndexPath:currentButtonInCenter.buttonIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
     }
    
}

-(void) centerJustifyScrollViewSelection:(UIScrollView *)scrollView
{
    //ONLY CALLED BY TVOS
    
    CGPoint currentOffset=scrollView.contentOffset;
    
    
    int currentCenterBtnNumber =(int)currentButtonInCenter.buttonIndex;
    float aSabOffset = currentCenterBtnNumber*(currentButtonInCenter.buttonSize.width+buttonSpacing)+(currentButtonInCenter.buttonSize.width/2);
    
    
 //   CGPoint newOffset = CGPointMake((currentCenterBtnNumber)*(currentButtonInCenter.uiButton.bounds.size.width+buttonSpacing),0);
    
    CGPoint newOffset = CGPointMake(aSabOffset/2,0);
    //CGPointMake((currentButtonInCenter.buttonIndex)*(currentButtonInCenter.uiButton.bounds.size.width+buttonSpacing)/2,0);
    NSLog(@"** CollectionViewHolder centerJustifyScrollViewSelection index %d old:%@   new:%@",currentCenterBtnNumber,NSStringFromCGPoint(currentOffset),NSStringFromCGPoint(newOffset));
    
    int buttonsToMyRight=((int)[currentButtonInCenter.buttonArrayPtr count])-(int)currentButtonInCenter.buttonIndex;
    if (_originalMaxButtonsVisible > buttonsToMyRight) {
        NSLog(@"        ****************THIS DOES POP spaceCanShow %d  right %d",_originalMaxButtonsVisible,buttonsToMyRight);
        //NO   self.bounds=CGRectMake(0, 0, _originalButtonWidth*buttonsToMyRight, _originalFrame.size.height);
        NSLog(@"");
        
    }
    else{
        //NO self.bounds=_originalFrame;
    }
  
    
    if (containerScrolls){
        [self.collectionView scrollToItemAtIndexPath:currentButtonInCenter.buttonIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
  
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    return;
    
    //what is currentbuttonincenter?
#if TARGET_OS_TV
    NSLog(@"MYRACHANGED CollectionViewHolder scrollViewDidEndDragging decelerate:%d  ",decelerate);
    
    
    
    
    CGPoint newOffset = CGPointMake(_lastContentOffset.x, _lastContentOffset.y);
    
    if (newOffset.x > scrollView.contentOffset.x) {
        NSLog(@"     Scrolling direction is left");
    }else{
        NSLog(@"     Scrolling direction is right");
    }
    
    
    [self centerJustifyScrollViewSelection:scrollView];
    return;
#endif
    
    
    
    
    
    
    
    
    if (!decelerate){
//        [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
        CGPoint offset = scrollView.contentOffset;
        CGPoint offsetsv = scrollView.contentOffset;
//        CGPoint offset = collectionView.contentOffset;
//        CGPoint offsetsv = collectionView.contentOffset;
        
        NSLog(@"------ controlContainerLine1.contentOffset = (%4.2f, %4.2f)", offset.x,offset.y);
        NSLog(@"------ scrollView.contentOffset = (%4.2f, %4.2f)", offsetsv.x,offsetsv.y);
/*
        if (buttonWasPressed){
            buttonWasPressed=NO;
            NSLog(@"buttonWasPressed = NO 1");
            return;
        }
*/
        [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
        [self updateButtonInCenter:offset];
        if (currentButtonInCenter.reloadOnly){
            NSNumber *touchedButton = [NSNumber numberWithInteger:currentButtonInCenter.uiButton.tag];
            NSLog(@"------ scrollviewDidEndDragging postNotification    touchedButton");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton]; //old
            
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"MYRACHANGED CollectionViewHolder scrollViewDidEndDecelerating");
#if TARGET_OS_TV
    
    CGPoint newOffset = CGPointMake(_lastContentOffset.x, _lastContentOffset.y);
    
    if (newOffset.x > scrollView.contentOffset.x) {
        NSLog(@"     Scrolling direction is left");
    }else{
        NSLog(@"     Scrolling direction is right");
    }
    
    
    [self centerJustifyScrollViewSelection:scrollView];
    return;
#endif
    

//    return;
    
    
//    [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
    
    CGPoint offset = scrollView.contentOffset;
    CGPoint offsetsv = scrollView.contentOffset;
//    CGPoint offset = collectionView.contentOffset;
//    CGPoint offsetsv = collectionView.contentOffset;
    NSLog(@"----- scrollView.contentOffset = (%4.2f, %4.2f)", offset.x,offset.y);
    NSLog(@"----- scrollView.contentOffset = (%4.2f, %4.2f)", offsetsv.x,offsetsv.y);
/*
    if (buttonWasPressed){
        buttonWasPressed=NO;
        NSLog(@"buttonWasPressed = NO 2");
        return;
}*/
    [self removeSelectedButtonBoxFromAllRows:currentButtonInCenter];
    [self updateButtonInCenter:offset];// forScrollView:scrollView];
    if (currentButtonInCenter.reloadOnly){
        NSNumber *touchedButton = [NSNumber numberWithInteger:currentButtonInCenter.uiButton.tag];
        
        
        
        NSLog(@"------ scrollviewDidEndDecelerting postNotification    touchedButton");
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];  //old
        
        
        
    }
    
}

-(void)updateButtonInCenter:(CGPoint)offset
{
    NSLog(@"CollectionViewHolder updateButtonInCenter");
    
    
    
    CGPoint adjustedOffSet;// = CGPointMake(offset.x+containerView.bounds.size.width/2,containerView.bounds.size.height/2);
    int sel = 0;
    float closestDistance = 9999;
    float aSabOffset;
    CGPoint aSabCenter;
    for (int i = 0; i < buttonSequence.count; i++){
        ActionRequest *aSab = [buttonSequence objectAtIndex:i];
        adjustedOffSet = CGPointMake(offset.x+aSab.uiButton.bounds.size.width/2, offset.y);
        aSabOffset = i*(aSab.buttonSize.width+buttonSpacing)+(aSab.buttonSize.width/2);
        aSabCenter = CGPointMake(aSabOffset, offset.y);
        int testDistance = [self distanceBetweenTwoPoints:adjustedOffSet buttonPos:aSabCenter];// aSab.uiButton.center];
        if ( testDistance < closestDistance){
            closestDistance= testDistance;
            sel = i;//+1;
        }
    }
    
    [self moveToButtonInCenter:sel];// forScrollView:scrollView];// withCurrentSA:currentSpriteAction];
}
-(void)moveToButtonInCenter:(NSInteger)currentCenterBtnNumber //forScrollView:(UIScrollView*)scrollView
{
    NSLog(@"CollectionViewHolder moveToButtonInCenter");
    
    
    
    ActionRequest *aBtn;
    
    for (int i = 0; i < buttonSequence.count; i++){
        aBtn= [buttonSequence objectAtIndex:i];
        aBtn.buttonIsOn = NO;
        if (aBtn.buttonIndex == currentCenterBtnNumber){
            currentButtonInCenter = [buttonSequence objectAtIndex:currentCenterBtnNumber];
            currentButtonInCenter.buttonIsOn = YES;
            if (currentButtonInCenter.reloadOnly){
                //[currentButtonInCenter.uiButton addSubview:selectedBtnBox];
                currentButtonInCenter.uiButton.layer.borderColor=TK_FOCUSBORDER_COLOR.CGColor;
                currentButtonInCenter.uiButton.layer.borderWidth=TK_FOCUSBORDER_SIZE;
                NSLog(@"-----MoveToButtonInCenter buttonIndex = %d, title = %@",i,currentButtonInCenter.buttonName);
                
                
            }
            else {
                currentButtonInCenter.uiButton.layer.borderColor=[UIColor clearColor].CGColor;
            }
        }
        
        
    }
    CGPoint scrollViewOffset = CGPointMake((currentCenterBtnNumber)*(currentButtonInCenter.uiButton.bounds.size.width+buttonSpacing),0);
    
    NSLog(@"moveToButtonInCenter = (%4.2f,%4.2f)",scrollViewOffset.x, scrollViewOffset.y);

    [UIView animateWithDuration:0.1f animations:^{
        
        containerView.contentOffset = scrollViewOffset;
//        collectionView.contentOffset=scrollViewOffset;
    }
                     completion:nil];

//    [self.collectionView scrollToItemAtIndexPath:currentButtonInCenter.buttonIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
-(float)distanceBetweenTwoPoints:(CGPoint)currentPosition buttonPos:(CGPoint)buttonPos
{
    float distance = sqrt(pow((currentPosition.x - buttonPos.x), 2.0) + pow((currentPosition.y - buttonPos.y), 2.0));
    //   DDLogDan(@"Distance Between Sprite Touches = %3.2f", distance);
    return distance;
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - FOCUS
/////////////////////////////////////////////////////////////////////////
-(void)checkUserFocusMovie
{
    NSLog(@"CollectionViewHolder checkUserFocusMovie");
    
    
    
    if(tvfocusAction){
        
        if (tvfocusAction != currentButtonInCenter) {
            
            currentButtonInCenter=tvfocusAction;   //no color changes
            int indexIt=(int)currentButtonInCenter.uiButton.tag;   //no color changes
            
            
            [self logCBCtag];
            NSLog(@"      doing userFocusNotify for runtime");//only to be picked up by runtime.m
            
            
            NSDictionary* dict = [NSDictionary dictionaryWithObject:
                                  [NSNumber numberWithInt:indexIt]
                                                             forKey:@"index"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserFocusMovie
                                                                object:self
                                                              userInfo:dict];
            
            
            
            //   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //      [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserFocusMovie
            //                                                          object:self
            //                                                       userInfo:dict];
            //  });
            
            
        }
        else{
            [self logCBCtag];
        }
    }
    
    
}
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    NSLog(@"CollectionViewHolder didUpdateFocusInContext:");
    
    //HDButtonView holds all the UIButtons defined in the cell.
    //context.previouslyFocusedView is a UIButton (Maybe)
    //context.nextFocusedView is a UIButton(Maybe)
    
    
    
    if(context.nextFocusedView == context.previouslyFocusedView){
        return;
    }
    
    
    if ([context.previouslyFocusedView isKindOfClass: [UICollectionViewCell class]]){
        
        MovieCollectionViewCell *cell = (MovieCollectionViewCell*)context.previouslyFocusedView;
        UIButton *btn = cell.myButton;
        NSString *prevTag = [NSString stringWithFormat:@"%li",btn.tag];
        ActionRequest *prevButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:prevTag];
        NSLog(@"      prevButton %@",prevButton.buttonName);
        
//        context.previouslyFocusedView.layer.borderColor=[UIColor clearColor].CGColor;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
                //  [coordinator addCoordinatedAnimations:^{
        //      context.previouslyFocusedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        //  } completion:nil];
        
        
        
        
    }
    
    if ([context.nextFocusedView isKindOfClass:[UICollectionViewCell class]]){
        
        
        
        MovieCollectionViewCell *cell = (MovieCollectionViewCell*)context.nextFocusedView;
        UIButton *btn = cell.myButton;
        NSString *nextTag = [NSString stringWithFormat:@"%li",btn.tag];
        ActionRequest *nextButton = [[GlobalTableProto sharedGlobalTableProto].allButtonsDictionary objectForKey:nextTag];
        NSLog(@"      nextButton %@",nextButton.buttonName);
        
        tvfocusAction=nextButton;
        nextButton.uiButton.layer.borderWidth=TK_FOCUSBORDER_SIZE;
        nextButton.uiButton.layer.borderColor=TK_FOCUSBORDER_COLOR.CGColor;
        
        
        
        if( (currentButtonInCenter != nextButton)&& (nextButton.reloadOnly)){
            
            tvfocusAction=nextButton;
            [self checkUserFocusMovie];
        }
        else{
            [self logCBCtag];
            NSLog(@"     disable focusMovie notification");
        }
        
        
        
    }
    
    
    
    
    
    
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - GestureRecognizer
/////////////////////////////////////////////////////////////////////////


- (void)tapGestureReceived:(UITapGestureRecognizer *)gesture {
    
    NSLog(@"CollectionViewHolder tapGestureReceived");
    
    if (!selectedButton)
        return;
    NSNumber *touchedButton = [NSNumber numberWithInteger:selectedButton.buttonTag];
    
    //   NSNumber *touchedButton1 = [NSNumber numberWithInteger:uiButtonPressed.tag];
    //   NSString *tagString = [touchedButton stringValue];
    
    NSLog(@"        ------ postNotification    ");
    [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];  // testing tvOS let HDButtonView send this
    
    return;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"CollectionViewHolder GestureAsking permission");
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

/*
-(void)addButtonViewToContainer:(UIView *)container animated:(BOOL)animated
{
    CGPoint startingViewCenter = container.center;
    if (animated)
        startingViewCenter = CGPointMake(-container.bounds.size.width/2, container.bounds.size.height/2);
    [container addSubview:self];
    self.center = startingViewCenter;
    if (animated){
        [UIView animateWithDuration:0.5f animations:^{
            CGPoint scrollViewOffset = CGPointMake(container.center.x,self.center.y);
            self.center = scrollViewOffset;
        }
                         completion:nil];
    }
}
-(void)removeButtonViewFromContainer:(UIView *)container animated:(BOOL)animated
{
    
    if (animated) {
        [UIView animateWithDuration:1.0f animations:^{
            CGPoint scrollViewOffset = CGPointMake(-container.bounds.size.width/2,self.center.y);
            self.center = scrollViewOffset;
        }
                         completion:nil];
    }
    
    [self removeFromSuperview];
    
}
*/
-(void)primaryActionTriggered:(id)sender   //TVOS select button (or enter on focused button in simulator)
{
    //so this is for tv only.  assuming have to have focus on button before you can select it.... so already know what it is and its highlighted....
    
    UIButton * uiButtonPressed = sender;
    NSLog(@"CollectionViewHolder primaryActionTriggered: Button Number %li",(long)uiButtonPressed.tag);
    [self checkUserFocusMovie];
    
}



-(void)removeSelectedButtonBoxFromAllRows:(ActionRequest*)aQuery
{
    
    NSLog(@"CollectionViewHolder removeSelectedButtonBoxFromAllRows");
    if(!aQuery)
        return;
    
    
  //  aQuery.uiButton.layer.borderColor=[UIColor clearColor].CGColor;
  //  return;
    
    for (ActionRequest *aBtn in buttonSequence){
        aBtn.uiButton.layer.borderColor=[UIColor clearColor].CGColor;
    }
    
/*
    TableDef *currentTableDef = [GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.activeTableDataPtr;
    SectionDef *currentSection = [currentTableDef.tableSections objectAtIndex:aQuery.tableSection];
    NSMutableArray *currentSectionCells = currentSection.sCellsContentDefArr;
    CellButtonsScroll *aButtonsCell;
    CellContentDef *ccDefPtr;
    
    
    HDButtonView *aMMBtnView;
    for (ccDefPtr in currentSectionCells){
        if([ccDefPtr.ccCellTypePtr isKindOfClass:[CellButtonsScroll class]]){
            aButtonsCell = (CellButtonsScroll*) ccDefPtr.ccCellTypePtr;
            aMMBtnView = [aButtonsCell.buttonView objectAtIndex:0];  // had to put this in array to avoid forward refs
            [aMMBtnView.selectedBtnBox removeFromSuperview];
        }
    }
*/
}

-(void)initButtonInCenterToRow0Btn0
{
    
    NSLog(@"CollectionViewHolder initBUttonInCenterToRow0Btn0 ");
    tvfocusAction=nil; //important
    TableDef *currentTableDef = [GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.activeTableDataPtr;
    SectionDef *currentSection = [currentTableDef.tableSections objectAtIndex:0];//aQuery.tableSection];
    NSMutableArray *currentSectionCells = currentSection.sCellsContentDefArr;
    CellContentDef *ccDefPtr = [currentSectionCells objectAtIndex:0];
    
    CellButtonsScroll* firstButtonRow = (CellButtonsScroll*)ccDefPtr.ccCellTypePtr;
    ActionRequest *firstButton = [firstButtonRow.cellsButtonsArray objectAtIndex:0];
    currentButtonInCenter = firstButton;
    
    
    currentButtonInCenter.uiButton.layer.borderWidth=TK_FOCUSBORDER_SIZE;
    currentButtonInCenter.uiButton.layer.borderColor=TK_FOCUSBORDER_COLOR.CGColor;
    
    
/*
    
    for (int index=0; index < [firstButtonRow.cellsButtonsArray count]; index++) {
        ActionRequest *aButton = [firstButtonRow.cellsButtonsArray objectAtIndex:index];
        aButton.myButtonView=self;
    }
    
 */
    [self logCBCtag];
}

@end

