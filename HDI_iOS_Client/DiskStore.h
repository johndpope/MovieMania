//
//  DiskStore.h
//
//  Created by Myra Hambleton on 2/7/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TableProtoDefines.h"
#import "mUtils.h"

@interface DiskStore : NSObject

+(DiskStore *)sharedDiskStore;
-(NSMutableDictionary *) unArchiveAStoreDictionaryNamed:(NSString *)dictName;
-(void) archiveAStoreDictionary:(NSMutableDictionary *)thisDict withName:(NSString *)thisFileName;
@end
