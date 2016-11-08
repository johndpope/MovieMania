//
//  GlobalSpeech.h
//
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//
#import <Foundation/Foundation.h>


//#import <UIKit/UIKit.h>

//#import <AVFoundation/AVFoundation.h>
//#import <AVKit/AVKit.h>

#if TARGET_OS_TV
//#import "SpeechRecTV.h"
#else
#import "SpeechRec.h"
#endif


@interface GlobalSpeech : NSObject




#if TARGET_OS_TV
//@property (nonatomic, readwrite) SpeechRecTV *mySpeechRec;
#else
@property (nonatomic, readwrite) SpeechRec *mySpeechRec;
#endif



+(GlobalSpeech *)sharedGlobalSpeech;

@end
