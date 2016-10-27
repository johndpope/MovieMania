//
//  SpeechRec.h
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#import <Speech/Speech.h>
#import "TableProtoDefines.h"

@interface SpeechRec : NSObject <SFSpeechRecognitionTaskDelegate,SFSpeechRecognizerDelegate>



-(id) initAndSetType:(int)speechConstraintType;
-(NSString *)lastRecognized;
-(void)startRecAndRecognize;
-(void)finishRecAndRecognize;  //calls clear and stop  ---

//private functions
//-(void)clearSpeechLogging;
//-(void)stopRecording;


-(void) killYourself;
@end
