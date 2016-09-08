//
//  CellMovieView.m
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 6/17/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellMovieView.h"
#import "ActionRequest.h"
#import "TableProtoDefines.h"
#import "HDMovieClipPlayer.h"

@implementation CellMovieView

@synthesize backgoundColor,movieViewSize,movieClipPlayer, movieActionReq;
@synthesize inAVPlayerVC;
@synthesize ytPlayerView;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    
    backgoundColor=nil;
    [self.movieClipPlayer removeMovieClip];
    self.movieClipPlayer = nil;
    
    
}
/*
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellMovieView *)nCell
{
    nCell.enableUserActivity=TRUE;
    nCell.cellclassType=CELLCLASS_BUTTONS_SCROLL;
    backgoundColor = [UIColor whiteColor];
    nCell.cellMaxHeight=self.movieViewSize.height;
    nCell.movieViewSize = self.movieViewSize;
 
}
 */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Exposed Initialization
/////////////////////////////////////////
//+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellSize:(CGSize)cellSize forActionRequest:(ActionRequest*)actionReq inAVPlayerVC:(BOOL)inAVPlayerVC;// withCellButtonArray:(NSMutableArray *)buttonArray //buttonScroll:(BOOL)buttonsScroll;
{
    CellMovieView* nCell=[[CellMovieView alloc]init];    //calls makeUseDefaults
    nCell.backgoundColor=  backColor;
    nCell.movieViewSize  = cellSize;
    nCell.movieActionReq = actionReq;
    nCell.inAVPlayerVC =  inAVPlayerVC;
    
    
    return nCell;
}
/*
+ (id )initCellDefaults
{
    CellMovieView* nCell=[[CellMovieView alloc]init];    //calls makeUseDefaults
    
    return nCell;
    
}
*/


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellBackColor
{
    return self.backgoundColor;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    //ASSIGN THIS IN putMeInTableViewCell:
//    return self.cellMaxHeight;//DAN THIS IS NEW>>>>IT MUST RETURN HEIGHT...
    return movieViewSize.height;
    
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(TableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //CALLED for individual Section's Cell content
    //will migrate to stackviews  (through cell's contentView)
/*
    if (inAVPlayerVC){

        NSURL *videoURL = [NSURL URLWithString:movieActionReq.trailerPath];
        AVPlayer *player = [AVPlayer playerWithURL:videoURL];
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        playerViewController.player = player;
//        tvcontrollerPtr.inMovieVC=1;
        [tvcontrollerPtr presentViewController:playerViewController animated:YES completion:nil];
        [player play];
    }else{
        
  */
     //   NSDictionary *playerVars = @{
     //                                @"playsinline" : @1,
     //                                };

        
        CGSize fullScreenSize = [UIScreen mainScreen].bounds.size;
        self.ytPlayerView = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, fullScreenSize.width, fullScreenSize.height)];
//        [self.ytPlayerView loadWithVideoId:@"9l3DDSXkEQ0" playerVars:playerVars];
//        [self.ytPlayerView loadWithVideoId:@"M7lc1UVf-VE"];
        
        [self.ytPlayerView loadWithVideoId:movieActionReq.trailerPath];  //@"9l3DDSXkEQ0"];
        self.ytPlayerView.backgroundColor = self.backgoundColor;// [UIColor greenColor];
//        [self.ytPlayerView playVideo];
#if !TARGET_OS_TV
        self.ytPlayerView.delegate = self;
#endif
    
    
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    
    
    
        [tvcellPtr addSubview:self.ytPlayerView];
    
    
        self.ytPlayerView.center = tvcontrollerPtr.view.center;
  /*
    UIView *movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.movieViewSize.width, self.movieViewSize.height)];
    movieClipPlayer = [[HDMovieClipPlayer alloc] init];
    [movieClipPlayer playMovie:movieActionReq.trailerPath viewToPlayIn:movieView addMovieView:YES];
    
    [tvcellPtr addSubview:movieView];
    movieView.center = tvcontrollerPtr.view.center;
   */
//    }
    
    //DAN - the height should be set by your container.... the max height 1 screens worth is provided by maxHeight just as a boundary
    // self.cellMaxHeight=buttonContainerView.frame.size.height ;    //put the height your cell uses here
    
    
    
    
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    
    //CALLED for Section Header, Footer   or Table Header, Footer
    //will migrate to stackviews
    
    
    
    self.cellMaxHeight = self.movieViewSize.height;
    NSLog(@"buttonView maxwidth %f",self.cellMaxHeight);
    
    CGSize fullScreenSize = [UIScreen mainScreen].bounds.size;
    UIView *movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fullScreenSize.width, fullScreenSize.height)];
    movieClipPlayer = [[HDMovieClipPlayer alloc] init];
    [movieClipPlayer playMovie:movieActionReq.trailerPath viewToPlayIn:movieView addMovieView:YES];
     movieView.center = tvcPtr.view.center;    
    return movieView;
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////
- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView
{
    NSLog(@"YoTubePlayerView didBecomeReady");
    [playerView playVideo];
}
- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    NSLog(@"YouTubePlayerView didChangeState = %ld",(long)state);
    if (state == 3){
        [playerView removeFromSuperview];
        playerView = nil;
        NSNumber* touchedButton = [NSNumber numberWithInteger:movieActionReq.buttonTag];
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserTouchInput object:touchedButton];

    }
        
}


@end

