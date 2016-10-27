//
//  GlobalSpeech.m
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "GlobalSpeech.h"


@implementation GlobalSpeech
{

}

@synthesize mySpeechRec;

+(GlobalSpeech *)sharedGlobalSpeech
{
    static GlobalSpeech *sharedGlobalSpeech;
    if (sharedGlobalSpeech == nil) {
        sharedGlobalSpeech = [[super allocWithZone:nil] init];
        
        
        [sharedGlobalSpeech initDefaultValues];
        
    }
    
    return sharedGlobalSpeech;
}

-(void) initDefaultValues
{
   

    
    
    
    
}

@end
