//
//  SpeechRec.m

//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "SpeechRec.h"
#import "GlobalTableProto.h"

@implementation SpeechRec
{

    BOOL _amIActive;
    SFSpeechRecognizer *_recognizer;
    SFSpeechRecognitionTask *_currentTask;
    AVAudioEngine *_audioEngine;
    SFSpeechAudioBufferRecognitionRequest *_request;
    AVAudioInputNode *_inputNode;
    
        NSMutableArray *_logArray;
    NSTimeInterval _mostRecentlyProcessedSegmentDuration;
    
    NSMutableArray *_transStructArray;
    int _speechConstrained;
    BOOL _userAuthorizedSpeech;
}






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    NSLog(@"************SpeechRec  kill Yourself");
    _recognizer=nil;
    _currentTask=nil;
    _audioEngine=nil;
    _request=nil;
    _inputNode=nil;
    [_logArray removeAllObjects];
    _logArray=nil;
    _mostRecentlyProcessedSegmentDuration=0;
    [_transStructArray removeAllObjects];
    _transStructArray=nil;
    _userAuthorizedSpeech=NO;
    _speechConstrained=SPCH_CONSTRAIN_NONE;
    _amIActive=NO;
    
}
-(id) init
{
    self = [super init];
    if (self) {
        
        [self setupSpeechStuff:SPCH_CONSTRAIN_NONE];
        if(!_userAuthorizedSpeech){
            return nil;
        }

    }
    return self;
}


-(id) initAndSetType:(int)speechConstraintType
{
    self = [super init];
    if (self) {
        
        [self checkAuthorization];
        
        if(!_userAuthorizedSpeech){
            return nil;
        }
        
        [self setupSpeechStuff:speechConstraintType];
        

            
    }
    return self;
}
-(void) checkAuthorization
{
    int userOkWithSpeech=[SFSpeechRecognizer authorizationStatus];
    switch (userOkWithSpeech) {
        case SFSpeechRecognizerAuthorizationStatusAuthorized:
            _userAuthorizedSpeech=YES;
            break;
        case SFSpeechRecognizerAuthorizationStatusNotDetermined:   //not presented yet, so present it
            [self presentUserWithSpeechAuthorization];   //NOT BLOCKING, sets status once returns
            
            sleep(1); //give time for user to accept/decline and set status?    ONLY happens once per DEVICE.  Then never asks again. (even if delete app)
            
            return;
            break;
        case SFSpeechRecognizerAuthorizationStatusDenied:
        case SFSpeechRecognizerAuthorizationStatusRestricted:
        default:
            _userAuthorizedSpeech=NO;
            return;
            
            break;
    }

}
-(void) setupSpeechStuff:(int)speechConstraintType
{
    
    
    _amIActive=YES;
    //AUTHORIZED FOR USE
    
    _speechConstrained=speechConstraintType;
    _transStructArray= [[NSMutableArray alloc]init];
    _logArray = [[NSMutableArray alloc] init];
    _recognizer= [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    [_recognizer setDelegate:self];
    // _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    //[_recognizer setDelegate:self];
    
    _audioEngine = [[AVAudioEngine alloc] init];
    
    
    
    return ;
}


-(void) presentUserWithSpeechAuthorization
{
    //this is only called one time - the first time the app is ever run on a device.  even deleteing the app won't make it call it again?
    NSLog(@"*****************************GET SPEECH PERMISSION");
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus authStatus) {
        switch (authStatus) {   //this is non-blocking.... so have set sleep and maybe will catch this, otherwise first use this class returns nil
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                //User gave access to speech recognition
                NSLog(@"Authorized");
                _userAuthorizedSpeech=YES;
                break;
                
            case SFSpeechRecognizerAuthorizationStatusDenied:
                //User denied access to speech recognition
                NSLog(@"SFSpeechRecognizerAuthorizationStatusDenied");
                _userAuthorizedSpeech=NO;
                break;
                
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                //Speech recognition restricted on this device
                NSLog(@"SFSpeechRecognizerAuthorizationStatusRestricted");
                _userAuthorizedSpeech=NO;
                break;
                
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                //Speech recognition not yet authorized
                NSLog(@"");
                _userAuthorizedSpeech=NO;
                break;
                
            default:
                NSLog(@"Default");
                _userAuthorizedSpeech=NO;
                break;
        }
        //[[NSNotificationCenter defaultCenter] postNotificationName:ConstUserAuthorizationSpeech object:self];
        

    }];
    
    
}
-(void) addNotificationsIWant
{
    
 /*   [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userRepliedAboutSpeech:)    //method
                                                 name:ConstUserAuthorizationSpeech          //const in TableProntoDefines.h
                                               object:nil];
    
  */
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark SETUP CONTROL - resource approval
/////////////////////////////////////////
/*- (void) userRepliedAboutSpeech:(NSNotification *) notification
{
    
    
   // ActionRequest *queryAction = [notification object];
    
    NSLog(@"notification that userRepliedAboutSpeech");
    NSLog(@"");
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark EXECUTION CONTROL
/////////////////////////////////////////
-(NSString *)lastRecognized
{
    SFTranscription *lastTransStructPtr;
    SFTranscriptionSegment *lastSegment;// transcription.segments.lastObject;
    
    NSString * translatedString=nil;// [transcription formattedString];
    int totalTranscribedSegments=(int)[_transStructArray count];
    if (totalTranscribedSegments) {
        lastTransStructPtr=[_transStructArray objectAtIndex:totalTranscribedSegments-1];//0 based
        
        lastSegment=lastTransStructPtr.segments.lastObject;
        NSLog(@"reco: %@, duration:%f confidentce:%f",lastSegment.substring, lastSegment.duration, lastSegment.confidence);
        NSLog(@"alternatives: %@", lastSegment.alternativeSubstrings);
        translatedString=lastSegment.substring ;
    }
    return translatedString;
    
    
 /*   -(void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription
    {
        NSString * translatedString = [transcription formattedString];
        
        SFTranscriptionSegment *lastSegment = transcription.segments.lastObject;
        if (lastSegment){
            //        if (lastSegment.duration > mostRecentlyProcessedSegmentDuration) {
            //            mostRecentlyProcessedSegmentDuration = lastSegment.duration;
            NSLog(@"%@, %@, %f",translatedString, lastSegment.substring, lastSegment.duration);
            [_logArray addObject:lastSegment.substring];
            [_transStructArray addObject: transcription];
    
    */
    
}

-(void)clearSpeechLogging
{
    NSLog(@"Log Array Contents - %@",_logArray);
    [_logArray removeAllObjects];
    [_transStructArray removeAllObjects];
}
-(void)finishRecAndRecognize
{
    [self clearSpeechLogging];
    [self stopRecording];
}
-(void)startRecAndRecognize
{
    //   [self clearLogs:nil];
    NSLog(@"startRecording");
    NSError * outError;
    //    mostRecentlyProcessedSegmentDuration = 0;
    
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setCategory:AVAudioSessionCategoryRecord error:&outError];
    //    [audioSession setMode:AVAudioSessionModeMeasurement error:&outError];
    //   [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation  error:&outError];
    
    _request = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    [_logArray removeAllObjects];
    [_transStructArray removeAllObjects];
    _inputNode = [_audioEngine inputNode];
    
    if (_request == nil) {
        NSLog(@"Unable to created a SFSpeechAudioBufferRecognitionRequest object");
    }
    
    if (_inputNode == nil) {
        
        NSLog(@"Unable to created a inputNode object");
    }
    
    _request.shouldReportPartialResults = true;
    _recognizer.defaultTaskHint=SFSpeechRecognitionTaskHintDictation;
    _currentTask = [_recognizer recognitionTaskWithRequest:_request delegate:self];
    
    /*
    [_recognizer recognitionTaskWithRequest:<#(nonnull SFSpeechRecognitionRequest *)#> delegate:<#(nonnull id<SFSpeechRecognitionTaskDelegate>)#>]
    
    [_recognizer recognitionTaskWithRequest:<#(nonnull SFSpeechRecognitionRequest *)#> resultHandler:<#^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error)resultHandler#>]
    
    */
    
    [_inputNode installTapOnBus:0 bufferSize:1024 format:[_inputNode outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when){
        //       NSLog(@"Block tap!");
        
        [_request appendAudioPCMBuffer:buffer];
        
    }];
    
    [_audioEngine prepare];
    [_audioEngine startAndReturnError:&outError];
    NSLog(@"Error %@", outError);
    /*
     _currentTask = [_recognizer recognitionTaskWithRequest:request resultHandler:(void (^)(SFSpeechRecognitionResult *result, NSError *error))resultHandler
     {
     return;
     }
     */
}
-(void)stopRecording
{
    //    [audioEngine stop];
    [_inputNode removeTapOnBus:0]; //otherwise trap -ERROR:    [0x1a8beac40] >avae> AVAudioNode.mm:565: CreateRecordingTap: required condition is false: _recordingTap == nil
    [_request endAudio];
    [_currentTask finish];
    //    [inputNode removeTapOnBus:0];
    //    _currentTask = nil;
    //    request = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark RECOGNITION CALLBACKS
/////////////////////////////////////////
-(void)speechRecognitionDidDetectSpeech:(SFSpeechRecognitionTask *)task
{
    NSLog(@"***Speech Detected");
    NSLog(@"");
}

-(void)speechRecognitionTaskWasCancelled:(SFSpeechRecognitionTask *)task
{
    
    if (_amIActive) {
        NSLog(@"SpeechRecognitionTaskWasCancelled");
    }
    else{
        NSLog(@"IGNORE  SpeechRecognitionTaskWasCancelled");
    }
    NSLog(@"");
}
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishSuccessfully:(BOOL)successfully
{
    
    if (_amIActive) {
        NSLog(@"SpeechRecognitionTaskDidFinishSuccessfully = %i",successfully);
    }
    else{
        NSLog(@"IGNORE  SpeechRecognitionTaskDidFinishSuccessfully = %i",successfully);
    }
    

    NSLog(@"");
}

-(void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)recognitionResult
{
    
    NSString * translatedString = [[[recognitionResult bestTranscription] formattedString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (_amIActive) {
         NSLog(@"*speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition, %@",translatedString);
        
        //    [self log:translatedString];
        
        if ([recognitionResult isFinal]) {
            [_audioEngine stop];
            [_inputNode removeTapOnBus:0];
            _currentTask = nil;
            _request = nil;
        }

    }
    else{
        NSLog(@"IGNORE  speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition, %@",translatedString);
    }

}



-(void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription
{
    NSString * translatedString = [transcription formattedString];
    
    SFTranscriptionSegment *lastSegment = transcription.segments.lastObject;
    if (lastSegment){
        //        if (lastSegment.duration > mostRecentlyProcessedSegmentDuration) {
        //            mostRecentlyProcessedSegmentDuration = lastSegment.duration;
        NSLog(@"*speechRecognition  %@, %@, %f",translatedString, lastSegment.substring, lastSegment.duration);
        [_logArray addObject:lastSegment.substring];
        [_transStructArray addObject: transcription];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstUserSpeechUtterance object:lastSegment.substring];
        //     [self.speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:translatedString]];
        //        }
    }
    else{
        NSLog(@"transcriptionString = %@",transcription);
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NOTIFICATIONS
/////////////////////////////////////////


@end
