//
//  mUtils.h
//  mtst-sharing
//
//  Created by Myra Hambleton on 2/7/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface mUtils : NSObject

+(void) logMyDocumentsDirectory;
+(NSString *) myDocumentsDirectoryPlus:(NSString *)additionalPath;
+(BOOL) fileExistsAtDocDirPath:(NSString *)thisValidPath;

+(NSString *) createLocalDirectory: (NSString *) newDir startingFromDirectory: (NSString *) basePath;
+(NSString *) createLocalDirectory: (NSString *) dirName;
+(void) markDirectoriesNoBackup;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+(NSMutableArray * ) createArrayOfDatFileNamesFromCharDir;
+(NSMutableArray * ) createArrayOfFullPathThemeFiles;
+(NSMutableArray * ) createArrayOfFullPathDatFiles;
+(NSString *)makeFirstSecondDateTimePostString :(NSString*) firstString withSecondString:(NSString*)secondString withPostString:(NSString *)postString;
+(NSString *)makeDateTimeString;

+(void) dumpADictionary: (NSDictionary *)someDictionary logString: (NSString *)someString;
+ (void)removeOvalFilesAtFullPath:(NSString*) fullDocDirPath;
+(int) fileOrDirExistsAtPath:(NSString *)fullPath;


+(void) putUIViewInFile:(NSString*)fname usingUIView:(UIView *)thisUIView;
+(void)putImageToDebugDir:(UIImage *)thisImage withFileName:(NSString *)fname;
+(BOOL) deleteLocalDirectory: (NSString *) dirName;


@end
