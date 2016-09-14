//
//  CustomCellUIView.m
//  MusicMania
//
//  
//
//


#import "CustomCellUIView.h"


@implementation CustomCellUIView
{
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollView
/////////////////////////////////////////////////////////////////////////

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"CustomCellUIView  scrollViewDidEndDecelerating");

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"CustomCellUIView  scrollViewDidEndDecelerating");
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"CustomCellUIView scrollViewDidEndScroll");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"CustomCellUIView scrollViewDidEndDragging");
    
}
/////////////////////////////////////////////////////////////////////////
#pragma mark - GestureRecognizer
/////////////////////////////////////////////////////////////////////////

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    NSString *classPREV;
    NSString *classNEXT;
    classPREV=NSStringFromClass([context.previouslyFocusedView class]);
    classNEXT=NSStringFromClass([context.nextFocusedView class]);
    
    NSLog(@"CustomCellUIView   didUpdateFocusInContext:  prevFoc %@   nextFoc(GO FOCUS)  %@",classPREV, classNEXT);

    return;
   
  

}

- (void)tapGestureReceived:(UITapGestureRecognizer *)gesture {

    NSLog(@"CustomCellUIView tapGestureReceived");
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"CustomCellUIView GestureAsking permission");
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    NSLog(@"CustomCellUIView Gesturerecv touch");
    
      return YES;
}

-(void)didSwipeRight: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Right");
    
}

-(void)didSwipeLeft: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Left");
    
}
-(void)didSwipeUp: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Up");
    
}
-(void)didSwipeDown: (UISwipeGestureRecognizer*) recognizer {
    NSLog(@"COLLECTIONviewCNTRLR Swiped Down");
    
}


@end
