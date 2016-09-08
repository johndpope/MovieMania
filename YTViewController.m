//
//  YTViewController.m
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 7/1/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "YTViewController.h"

@interface YTViewController ()

@end

@implementation YTViewController
{
    YTPlayerView  *ytPlayerView;
}
@synthesize ytVidioID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
#if !TARGET_OS_TV
    // tvOS-specific code
        CGSize fullScreenSize = [UIScreen mainScreen].bounds.size;
    ytPlayerView = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, fullScreenSize.width, fullScreenSize.height)];
    //[self.ytPlayerView loadWithVideoId:@"9l3DDSXkEQ0" playerVars:playerVars];
    //        [ytPlayerView loadWithVideoId:@"M7lc1UVf-VE"];
    [ytPlayerView loadWithVideoId:ytVidioID];  //@"9l3DDSXkEQ0"];
    ytPlayerView.backgroundColor =  [UIColor greenColor];
    ytPlayerView.delegate = self;
    [self.view addSubview:ytPlayerView];
#endif
}


-(void)viewWillDisappear:(BOOL)animated
{
    return;
}
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
        [self dismissViewControllerAnimated:NO completion:^(){}];
        
        
    }
    
}

@end
