//
//  CustomTVCell.m = custom  table view cell
//

#import "CustomTVCell.h"
#import "GlobalTableProto.h"


#import "TableDef.h"
@implementation CustomTVCell



@synthesize dispAsRow,dispAsSection,initialized;
//@synthesize cellDataHptr;
@synthesize focusThisCellvar;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Init Methods
/////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        initialized=NO;
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Helper Methods
/////////////////////////////////////////
-(CustomTVCell*)mkSelfForSection:(int)thisSection andRow:(int)thisRow onTableDef:(id)tableDefPtr
{
    CustomTVCell *nCell=self;
    self.dispAsRow=thisRow;
    self.dispAsSection=thisSection;
    initialized=YES;
    TableDef * tdfptr=(TableDef *)tableDefPtr;
    
    //3.  DETERMINE If I can have focus as a cell, OR if I have buttons that manage their own focus
    self.focusThisCellvar=[tdfptr cellCanOwnFocusThisRow:thisRow andSection:thisSection];
    
    return nCell;
}
/*-(CustomTVCellControl*)mkSelfContainDisplayForSection:(int)thisSection andRow:(int)thisRow onTableDef:(TableDef *)tableDefPtr
{
    //self has been provided by deQueue operation.  Make sure the contents of self contain
    //whatever should be displayed by thisSectionm and thisRow
    CustomTVCellControl *nCell=self;
    self.dispAsRow=thisRow;
    self.dispAsSection=thisSection;
    //NSLog(@"mkSelfContain:section %d row %d",thisSection,thisRow);
    
    
   
    
    //1.  ***** Do I have any data associated with me?
    if (!nCell.cellDataHptr) {
        //find myself, i'm new to this cellDisplay-er
        //nCell.cellDataHptr=
        nCell.cellDataHptr =[CellDataHolder initForSection:thisSection andIndex:thisRow hasFrame:self.frame];
    }
    else{
        //Am I already the right cell?  DeQueue could have gotten me already. assume I am a used cell so delete my stuff and replace with correct stuff
        
             //remove subviews in my contentView, because it is for another cell
            [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            //put correct data pointer in cell
            nCell.cellDataHptr =[CellDataHolder initForSection:thisSection andIndex:thisRow hasFrame:self.frame];
        
    }
    
    
    [nCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    //2.  **** assign graphic parts to contentview
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    UIView *vtoAdd=[tableDefPtr cellUIViewForRow:thisRow andSection:thisSection ];
    
    [self.contentView addSubview:vtoAdd];
    
    
    */
    
    /*   TESTER CODE
    
    
    if (nCell.cellDataHptr.myButton) {   //showBUTTON
        nCell.cellDataHptr.myButton.center = self.contentView.center;
        [self.contentView addSubview:nCell.cellDataHptr.myButton];
    }
    
    if (nCell.cellDataHptr.myLabel) { //showit LABEL
        [self.contentView addSubview:nCell.cellDataHptr.myLabel];
    }
    //SET BACKGROUND COLOR of CELL
    self.contentView.backgroundColor=nCell.cellDataHptr.myContainerBackgroundColorDESELECTED;

    
    //Register for control of user action: BUTTON PRESS
    if (nCell.cellDataHptr.myButton) {
        [nCell.cellDataHptr.myButton addTarget:self action:@selector(cellButtonTouched:)  forControlEvents:UIControlEventTouchUpInside];
    }
    
    //IF REGISTER CELL TOUCH AS TAP will NOT GET CELL SELECTED MESSAGE in CONTROLLER
    //Register for control of user action: TAP
   // if (self.gestureRecognizers.count == 0) {
   //     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
   //     // tap.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeSelect]];
   //     tap.delaysTouchesBegan=YES;
   //     tap.numberOfTapsRequired=1;
   //     [self addGestureRecognizer:tap];
   // }
   // else{
   //     NSLog(@"");
   // }
*/
 /*
    return nCell;
    
}

*/


// Customize the animation while tap the UICollectionViewCell with custom animation duration.
- (void)selectedCellAnimation {
    NSLog(@"");
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        CALayer *layer = self.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 25.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        layer.transform = rotationAndPerspectiveTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            CALayer *layer = self.layer;
            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
            rotationAndPerspectiveTransform.m24 = 0;
            rotationAndPerspectiveTransform =CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
            layer.transform = rotationAndPerspectiveTransform;
        } completion:nil];
    }];
}



-(void) customCellInFocus:(BOOL)selected
{
    NSLog(@"CUSTOMTVCELL   customCellInFocus");
    
    /*
    if (selected) {
        self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorSELECTED;
       self.transform=CGAffineTransformMakeScale(1.5, 1.5);
        [self selectedCellAnimation];
    }
    else{
        
        self.transform=CGAffineTransformMakeScale(1.0, 1.0);
        self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorDESELECTED;
    }
     */
    
}

-(void)cellButtonTouched:(UIButton*)button
{
    NSLog(@"CUSTOMTVCELL   cellButtonTouched:");
    //NSLog(@"CELLTVCONTROL   cellButtonTouched:%p) Hit AL:%@  cell says section:%d row:%d ",self,button.accessibilityLabel,dispAsSection,dispAsRow);
    //SELF CONTAINS POINTER TO DATA
    
}

- (void)cellTapped:(UITapGestureRecognizer *)gesture
{
    NSLog(@"CUSTOMTVCELL   cellTapped");

   // NSLog(@"CELLTVCONTROL   cellTapped: %p  cell section:%d row:%d ",self,dispAsSection,dispAsRow);
      //SELF CONTAINS POINTER TO DATA
    
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Focus
/////////////////////////////////////////////////////////////////////////

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
 /* this gets called twice for every tv arrow movement.  
    collectionViewController only gets called once  */
    
   
    
    
    NSString *classPREV;
    NSString *classNEXT;
    classPREV=NSStringFromClass([context.previouslyFocusedView class]);
    classNEXT=NSStringFromClass([context.nextFocusedView class]);
    
    NSLog(@"***CUSTOMTVCELL   didUpdateFocusInContext:  sec %d row %d prevFoc %@   nextFoc(GO FOCUS)  %@",self.dispAsSection, self.dispAsRow,classPREV, classNEXT);

    
    /*
    CustomTVCellControl *nextInFocus_cellControlPtr= (CustomTVCellControl *)context.nextFocusedView;
    CustomTVCellControl *prevInFocus_cellControlPtr= (CustomTVCellControl *)context.previouslyFocusedView;
    
    if (self == nextInFocus_cellControlPtr) {
        NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator: (NEXT)   section:%d  row:%d",dispAsSection,dispAsRow);
        
        [self customCellInFocus:YES];
      //  self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorSELECTED;
      //  self.transform= CGAffineTransformMakeScale(1.1, 1.1);
        // self.highlighted=YES;   no
        // [self setSelected:YES];  no
    }
    if (self == prevInFocus_cellControlPtr) {
        NSLog(@"CELLTVCONTROL didUpdateFocusInContext:withAnimationCoordinator: (PREV)   section:%d  row:%d",dispAsSection,dispAsRow);
        // self.highlighted=NO;   these mess up in simulator
        //[self setSelected:NO];   these mess up in simulator  can get multiple highlighted
        [self customCellInFocus:NO];
        //self.contentView.backgroundColor=self.cellDataHptr.myContainerBackgroundColorDESELECTED;
        //self.transform= CGAffineTransformMakeScale(1.0, 1.0);
        
        
    }
    NSLog(@"");
    NSLog(@"");
    
    */
    
   /* [coordinator addCoordinatedAnimations:^{
        if (self.focused) {
            self.label.alpha = 1;
        } else {
            self.label.alpha = 0;
        }
    } completion:nil];
    */
    
    /*
    if (context.previouslyFocusedView != nil) {
        
        NSLog(@"CELL PREV   didUpdateFocusInContext:withAnimationCoordinator:");
        
        [coordinator addCoordinatedAnimations:^{
            context.previouslyFocusedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }
    
    if (context.nextFocusedView != nil) {
        
        NSLog(@"CELL NEXT   didUpdateFocusInContext:withAnimationCoordinator:");
        [coordinator addCoordinatedAnimations:^{
            context.nextFocusedView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:nil];
        
        
    }
    */

    
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollView
/////////////////////////////////////////////////////////////////////////

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"CUSTOMTVCELL scrollViewDidEndDecelerating");
  // _lastScrollContentOffset = scrollView.contentOffset;
  //  _lastScrollDirection=SCROLL_NONE;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // NSLog(@"detecting scroll- want to make sure this cell is visible %d in section %d",_rowCellToVisuallySetAtScrollStop, _sectionCellToVisuallySetAtScrollStop);
    NSLog(@"CUSTOMTVCELL scrollViewDidEndDecelerating");
    
    //what direction did we scroll?
  /*  if (_lastScrollContentOffset.x < (int)scrollView.contentOffset.x) {
        NSLog(@"TABLEviewCNTRLR Scrolled Right");
        _lastScrollDirection=SCROLL_RIGHT;
    }
    else if (_lastScrollContentOffset.x > (int)scrollView.contentOffset.x) {
        NSLog(@"TABLEviewCNTRLR Scrolled Left");
        _lastScrollDirection=SCROLL_LEFT;
    }
    
    else if (_lastScrollContentOffset.y < scrollView.contentOffset.y) {
        NSLog(@"TABLEviewCNTRLR Scrolled Down");
        _lastScrollDirection=SCROLL_DOWN;
    }
    
    else if (_lastScrollContentOffset.y > scrollView.contentOffset.y) {
        NSLog(@"TABLEviewCNTRLR Scrolled Up");
        _lastScrollDirection=SCROLL_UP;
    }
    
    //scroll direction is correct, but cells can be partially contained on screen.  Left most cell is the easiest to get right,
    // because if left side is off screen, CGRECT for cell will have negative X value
    
    [self assignLeftMostCellAsInFocus];
    */
    

    
    
}

@end
