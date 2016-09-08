//
//  YTViewController.h
//  HDI_iOS_Client
//
//  Created by Dan Hammond on 7/1/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface YTViewController : UIViewController <YTPlayerViewDelegate>
@property (nonatomic, readwrite) NSString *ytVidioID;
@end
