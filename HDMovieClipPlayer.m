//
//  HDMovieClipPlayer.m
//  MusicMania
//
//  Created by Dan Hammond on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDMovieClipPlayer.h"
#import "GlobalTableProto.h"


@implementation HDMovieClipPlayer
{
    AVPlayerItem                *visualItem;
    AVAsset                     *playerAsset;

   
    CGFloat                     frameWidth;
    int                         loopCount;
    
    
}
@synthesize movieClipIsPlaying, loopUntilStopped;
@synthesize movieCenterPoint;
@synthesize pauseSegmentForThisClip;
@synthesize moviePlayerController;
@synthesize clipAudioVolume;
@synthesize myMovieName;
//@synthesize boxFrameLayer;
@synthesize playBox;//, playBoxLabel;
//@synthesize menuClipSegment;
@synthesize playerLayer;
@synthesize visualDirectoryPath;
/*
+(void)removeAllMovieClipPlayers
{
    GlobalMemory *gm = [GlobalMemory sharedGlobalMemory];
    HDMovieClipPlayer *clipToDelete;
    for (int i= gm.allMovieClipPlayers.count-1; i >= 0; i --){
        clipToDelete = [gm.allMovieClipPlayers objectAtIndex:i];
        [clipToDelete removeMovieClip];
        clipToDelete = nil;
        
    }
      
}

*/

-(id)init
{
    self = [super init];
    if (self) {
       
        clipAudioVolume = 1.0;
        loopCount = 0;
        
    }
    return self;
}

-(void)playMovie:(NSString *)movieClipToPlayPath viewToPlayIn:(UIView *)viewToPlayIn addMovieView:(BOOL)addMovieView
{
    BOOL streamingTest = YES;
    if(!movieClipToPlayPath)
        return;
   
    if (!viewToPlayIn)
        return;
    myMovieName = [NSString stringWithString:movieClipToPlayPath];
   
	movieClipIsPlaying = YES;
    NSURL    *fileURL;
    if (!streamingTest){
    NSString *fullVisualPath =  movieClipToPlayPath;//[[NSBundle mainBundle] pathForResource:@"TotalRecall" ofType:@"m4v"];
//    NSString *fullVisualPath = [systemVisualFilePath stringByAppendingPathComponent:movieClipToPlay];
    
    fileURL    =   [NSURL fileURLWithPath:fullVisualPath];
    
    NSLog(@"Visual filePath = %@",fullVisualPath);
    NSLog(@"Testing for existence of %@", [fullVisualPath lastPathComponent]);
    }else{
        fileURL = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
                      
                      // You may find a test stream at <http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8>.
    }
//    NSFileManager* NSFm= [NSFileManager defaultManager];
    visualItem = [[AVPlayerItem alloc] initWithURL:fileURL];
    playerAsset = [AVAsset assetWithURL:fileURL];
    NSLog(@"AVPlayerItem *visualItem = %@",visualItem);
    //    moviePlayerController = [[AVPlayer alloc] initWithURL:fileURL];
    moviePlayerController = [[AVPlayer alloc] initWithPlayerItem:visualItem];
    NSLog(@"AVPlayer currentItem = %@",[moviePlayerController currentItem]);
    [self adjustAudioVolume];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:moviePlayerController];
    playBox = [[UIView alloc] init];
    playBox.frame = viewToPlayIn.frame;
        playBox.frame = viewToPlayIn.frame;
    //  playBox.layer.cornerRadius = 20;
//    if (movieCenterPoint.x || movieCenterPoint.y)
        playBox.center = movieCenterPoint;
 //   else {
 //       playBox.center = mvc.movieView.center;
 //       movieCenterPoint = mvc.movieView.center;
//    }
    NSLog(@"playBox.frame.origin.x = %f",playBox.frame.origin.x);
    NSLog(@"playBox.frame.origin.y = %f",playBox.frame.origin.y);
    NSLog(@"playBox.frame.size.width = %f",playBox.frame.size.width);
    NSLog(@"playBox.frame.size.height = %f",playBox.frame.size.height);
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlaybackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:[moviePlayerController currentItem]];
       //    NSString *fillMode = @"AVLayerVideoGravityResizeAspectFill";
    //    NSString *fillMode = @"AVLayerVideoGravityResizeAspect";
    NSString *fillMode = @"AVLayerVideoGravityResize";
    playerLayer.videoGravity = fillMode;
    
    
    playerLayer.frame = playBox.frame;
    NSLog(@"playerLayer bounds.width,bounds.height = %4.2f, %4.2f",playerLayer.bounds.size.width,playerLayer.bounds.size.height);
    //    playerLayer.videoGravity =fillMode;
    
//    if (viewToPlayIn){
        CGRect thisPlayBox = CGRectMake(0,0,viewToPlayIn.bounds.size.width, viewToPlayIn.bounds.size.height);
        playerLayer.frame = thisPlayBox;
        //        [viewToPlayIn.layer addSublayer:playerLayer];
        //        [moviePlayerController play];
    if (!addMovieView)
        return;
    [viewToPlayIn.layer addSublayer:playerLayer];
  //      [[MMSegmentPlayer sharedSegmentPlayer].moviePlayView.layer addSublayer:playerLayer];
  //  [[GlobalTableProto sharedGlobalTableProto]liveRuntimePtr.activ addSubview:[MMSegmentPlayer sharedSegmentPlayer].moviePlayView];
    [moviePlayerController play];


}
-(void)pause
{
    [moviePlayerController pause];
}
-(void)play
{
    [moviePlayerController play];
}
/*
 -(void)removeMovieClip;
 {
 loopUntilStopped = NO;
 [self endClipPlayback];
 }
 */
- (void)moviePlaybackFinished:(NSNotification *)notification
{
    float currentPlaybackTime;
    CMTime curCMTime = moviePlayerController.currentTime;
    currentPlaybackTime = CMTimeGetSeconds(curCMTime);
    AVPlayerItem *notificationItem;// = [[AVPlayerItem alloc] init];
    notificationItem = [notification object];
    NSLog(@"moviePlaybackFinished:[notificaion object] = [avplayer currentItem] %@", notificationItem);
    NSLog(@"[moviePlayerController currentItem] = %@",[moviePlayerController currentItem]);
    NSLog(@"MMMMMMMMMMM  movieClipPlayer currentPlaybackTimer = %4.2f loopCount = %i",currentPlaybackTime, loopCount);
    
    if (![notificationItem isEqual:[moviePlayerController currentItem]])
        return;
    if (loopUntilStopped == YES){
            //        [moviePlayerController seekToTime:CMTimeMake(0,1000)];
//        [moviePlayerController seekToTime:kCMTimeZero];
        [self seekToNewTime:0];
        CMTime curCMTime = moviePlayerController.currentTime;
        currentPlaybackTime = CMTimeGetSeconds(curCMTime);
        
        
//        DDLogDan(@" currentPlaybackTime after seekZero = %4.2f, moviePlayerController status = %i",currentPlaybackTime, moviePlayerController.status);
//        [moviePlayerController play];
        loopCount ++;
            return;
        }
    if (pauseSegmentForThisClip){
 //       [self seekToNewTime:1.0];
        [moviePlayerController seekToTime:kCMTimeZero];
        [moviePlayerController pause];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"PausedMovieClipFinished" object: self];
        return;
       // [self removeMovieClip];
        
    }
}
//-(void)endClipPlayback
-(void)removeMovieClip

{
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    //    if (pauseSegmentForThisClip)
    //        [[NSNotificationCenter defaultCenter] postNotificationName: @"PausedMovieClipFinished" object: self];
//    [playBoxLabel removeFromSuperview];
//    [boxFrameLayer removeFromSuperlayer];//Myra remove frame around movie
    [moviePlayerController pause];
    movieClipIsPlaying = NO;
    [playerLayer removeFromSuperlayer];
 //   [gm.allMovieClipPlayers removeObject:self];
    moviePlayerController = nil;
    
    
    
}
-(void)seekToNewTime:(float)newPlaybackTime
{
    
    CMTime newTime = CMTimeMakeWithSeconds(newPlaybackTime,1000.0);
    CMTime tolBefore = CMTimeMakeWithSeconds(0.10,1000);
    CMTime tolAfter  = CMTimeMakeWithSeconds(0.10,1000);
    [moviePlayerController seekToTime:newTime
         toleranceBefore:tolBefore
          toleranceAfter:tolAfter
       completionHandler:^(BOOL finished){
           if (finished){
               
               CMTime curCMTime = moviePlayerController.currentTime;
               float currentPlaybackTime = CMTimeGetSeconds(curCMTime);
               NSLog(@" currentPlaybackTime after seekZero success = %4.2f, moviePlayerController status = %li",currentPlaybackTime, (long)moviePlayerController.status);
               [moviePlayerController play];
           }
           else{
               CMTime curCMTime = moviePlayerController.currentTime;
               float currentPlaybackTime = CMTimeGetSeconds(curCMTime);
               NSLog(@" currentPlaybackTime after seekZero failure = %4.2f, moviePlayerController status = %li",currentPlaybackTime, (long)moviePlayerController.status);
               [moviePlayerController pause];
           }
                   }];
    
//    [moviePlayerController seekToTime:newTime toleranceBefore:tolBefore toleranceAfter:tolAfter];
}


-(void)adjustAudioVolume
{
    NSArray *audioTracks = [playerAsset tracksWithMediaType:AVMediaTypeAudio];
    NSMutableArray *allAudioParams = [NSMutableArray array];
    for (AVAssetTrack *track in audioTracks) {
        AVMutableAudioMixInputParameters *audioInputParams =
        [AVMutableAudioMixInputParameters audioMixInputParameters];
        [audioInputParams setVolume:clipAudioVolume atTime:kCMTimeZero];
        [audioInputParams setTrackID:[track trackID]];
        [allAudioParams addObject:audioInputParams];
    }
    
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    [audioMix setInputParameters:allAudioParams];
    
    [visualItem setAudioMix:audioMix];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // Draw complete lines in black
    [[UIColor blueColor] set];
    CGPoint point1 = CGPointMake(playBox.frame.origin.x,playBox.frame.origin.y);
    CGPoint point2 = CGPointMake(playBox.frame.origin.x+playBox.frame.size.width,playBox.frame.origin.y);
    CGPoint point4 = CGPointMake(playBox.frame.origin.x,playBox.frame.origin.y+playBox.frame.size.height);
    CGPoint point3 = CGPointMake(playBox.frame.origin.x+playBox.frame.size.width,playBox.frame.origin.y+playBox.frame.size.height);
    NSLog(@"drawRect Points (%f,%f),(%f,%f),(%f,%f),(%f,%f),", point1.x,point1.y, point2.x, point2.y, point3.x,point3.y,point4.x,point4.y);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    CGContextStrokePath(context);
}

/*
-(void)addClipLabel:(NSString *)clipBoxName
{
    if (menuClipSegment){
        float labelWidth = playBox.bounds.size.width + frameWidth*2;
        float labelHeight = 10.0;
        float labelX = movieCenterPoint.x - playBox.bounds.size.width/2 - frameWidth;
        float labelY = movieCenterPoint.y + playBox.bounds.size.height/2 + frameWidth/2;
        playBoxLabel = [[UILabel alloc ] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
//        playBoxLabel.textAlignment =  UITextAlignmentCenter;
        playBoxLabel.textColor = [UIColor blackColor];
        playBoxLabel.backgroundColor = [UIColor clearColor];
        playBoxLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10.0)];
        [mvc.view addSubview:playBoxLabel];
        playBoxLabel.text = [NSString stringWithFormat: @"%@", clipBoxName];
        DDLogDan(@"addClipLabel:clipBoxName = %@",clipBoxName);
    }
}

-(void)addClipFrame
{
    //Myra build frame
    if (menuClipSegment){
        frameWidth=15.0f;
        if (!boxFrameLayer)
            boxFrameLayer = [CALayer layer];
        
        CGRect shapeRect = CGRectMake(playBox.frame.origin.x-frameWidth, playBox.frame.origin.y-frameWidth, playBox.frame.size.width+frameWidth, playBox.frame.size.height+frameWidth);
        [boxFrameLayer setBounds:shapeRect];
        [boxFrameLayer setPosition:CGPointMake(movieCenterPoint.x, movieCenterPoint.y)];  //have to set it to center not origin
        [boxFrameLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [boxFrameLayer setBorderColor:[[UIColor blackColor] CGColor]];
        [boxFrameLayer setBorderWidth:15.0f];
        [boxFrameLayer setOpacity:1.0];
        [boxFrameLayer setCornerRadius:0];//15.0];
        [mvc.view.layer addSublayer:boxFrameLayer];
        
    }
}
 */
@end
