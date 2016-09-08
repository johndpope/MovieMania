//
//  HDMovieClipPlayer.h
//  MusicMania
//
//  Created by Dan Hammond on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@class AVPlayer;
@class AVPlayerLayer;
@interface HDMovieClipPlayer : NSObject
@property (nonatomic, readwrite)    BOOL            movieClipIsPlaying;
//@property (nonatomic, readwrite)    int             movieViewLocation;
@property (nonatomic, readwrite)    BOOL            loopUntilStopped;
//@property (nonatomic, readwrite)    CGRect          movieHome;
@property (nonatomic, readwrite)    CGPoint         movieCenterPoint;
@property (nonatomic, readwrite)    BOOL            pauseSegmentForThisClip;
@property (nonatomic, strong)       AVPlayer        *moviePlayerController;
@property (nonatomic, readwrite)    float           clipAudioVolume;
@property (nonatomic, strong)       NSString        *myMovieName;
//@property (nonatomic, strong)       CALayer         *boxFrameLayer;
@property (nonatomic, strong)       UIView          *playBox;
//@property (nonatomic, strong)      UILabel          *playBoxLabel;
//@property (nonatomic, strong)       MMSegmentObject  *menuClipSegment;
@property (nonatomic, strong)       AVPlayerLayer   *playerLayer;
@property (nonatomic, strong)       NSString        *visualDirectoryPath;

enum
{
    FULLMOVIEVIEW = 0,
    CENTERCLIPVIEW,
    ENDOFVIEWS,
};
//-(id)initWithMMA:(MMAction *)movieClipMMA;

//+(void)removeAllMovieClipPlayers;
-(void)playMovie:(NSString *)moviePath viewToPlayIn:(UIView *)viewToPlayIn addMovieView:(BOOL)addMovieView;

-(void)removeMovieClip;
-(void)pause;
-(void)play;
//-(void)endClipPlayback;
//-(void)removeMovieClip:(HDMovieClipPlayer *)clipPlayer;
@end
