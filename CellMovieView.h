//
//  CellMovieView.h
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 6/17/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellTypesAll.h"
#import "TableProtoDefines.h"
#import "DispTText.h"
//#import "HDButtonView.h"
#import "TableViewController.h"
//#import "ActionRequest.h"
#import "YTPlayerView.h"
#import <AVKit/AVKit.h>
@class HDMovieClipPlayer;
@class ActionRequest;
@interface CellMovieView : CellTypesAll <YTPlayerViewDelegate>
@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) CGSize movieViewSize;
@property (nonatomic, readwrite) HDMovieClipPlayer *movieClipPlayer;
@property (nonatomic, readwrite) ActionRequest *movieActionReq;
@property (nonatomic, readwrite) BOOL inAVPlayerVC;
@property (nonatomic, readwrite) YTPlayerView *ytPlayerView;

//+ (id )initCellDefaults;
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellSize:(CGSize)cellSize forActionRequest:(ActionRequest*)actionReq inAVPlayerVC:(BOOL)inAVPlayerVC;
@end
