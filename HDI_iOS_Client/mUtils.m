//
//  mUtils.m
//  mtst-sharing
//
//  Created by Myra Hambleton on 2/7/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//

#import "mUtils.h"


@implementation mUtils

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Doc Dir Helpers
//////////////////////////////////////////////////////////////////////////////////////
+(void) logMyDocumentsDirectory
{
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    //get one an donly document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSLog(@"Doc dir is:   %@",documentDirectory);
}
//
//   [mFiles myDocumentsDirectoryPlus:nil ];  returns document directory as a string
//   [mFiles myDocumentsDirectoryPlus:aFileName ];   returns  \documentsDirectory\aFileName  as a string
//

+(BOOL) fileExistsAtDocDirPath:(NSString *)thisValidPath
{
    //send entire path
    
    
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:thisValidPath];

    
    return fileExists;
    
    
    
}


+(NSString *) myDocumentsDirectoryPlus:(NSString *)additionalPath
{
    
    NSString *localPath;
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    //get one an donly document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    localPath=[documentDirectory stringByAppendingPathComponent:additionalPath];
    
    return localPath;
}


// returns nil if error or actual path of directory created off of \documents
+(NSString *) createLocalDirectory: (NSString *) dirName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dirPath = [documentsDirectory stringByAppendingPathComponent:dirName];
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create dir
    if (error)
        return nil;
    
    //when no error
    NSURL *guidesURL = [NSURL fileURLWithPath:dirPath];
    [guidesURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:NULL];
    

    return dirPath;
}//createLocalDirectory:



+(BOOL) deleteLocalDirectory: (NSString *) dirName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dirPath = [documentsDirectory stringByAppendingPathComponent:dirName];
    
    
    return [[NSFileManager defaultManager] removeItemAtPath:dirPath error:nil];
    
}//deleteLocalDirectory:

+(void) markDirectoriesNoBackup
{
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSURL *pathURL= [NSURL fileURLWithPath:documentsDirectory];
    
    [self addSkipBackupAttributeToItemAtURL:pathURL];
}
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL

{
   
    
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}



+(NSString *) createLocalDirectory: (NSString *) newDir startingFromDirectory: (NSString *) basePath
{
    
    NSString *dirPath = [basePath stringByAppendingPathComponent:newDir];
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create dir
    if (error)
        return nil;
    
    //when no error
    NSURL *guidesURL = [NSURL fileURLWithPath:dirPath];
    [guidesURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:NULL];
   

    return dirPath;
    
    
    
    
}//createLocalDirectory:startingFromDirectory:





//go to \Documents\Characters  return array of all files with extension .dat
// this is basically array of <theme name>.dat
+(NSMutableArray * ) createArrayOfDatFileNamesFromCharDir
{
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSString *extension = @"dat";
    NSString * localPath=[mUtils myDocumentsDirectoryPlus:@"Characters"];
    
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath: localPath error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            [matches addObject:item];
        }
    }
    return matches;
}//createArrayOfDatFileNamesFromCharDir


//go to \Documents\Characters  return array of FULL PATH of all files with extension .dat
// this is basically array of <...>\Documents\Characters\<theme name>.dat
// in preparation for reading them
+(NSMutableArray * ) createArrayOfFullPathThemeFiles
{
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSString *extension = @"dat";
    NSString * localPath=[mUtils myDocumentsDirectoryPlus:@"Characters"];
    
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath: localPath error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            NSString *fullPathItem= [localPath stringByAppendingPathComponent:item];
            [matches addObject:fullPathItem];
        }
    }
    return matches;
}//createArrayOfFullPathThemeFiles
//go to \Documents\Characters  return array of FULL PATH of all files with extension .dat
// this is basically array of <...>\Documents\Characters\<theme name>.dat
// in preparation for reading them
+(NSMutableArray * ) createArrayOfFullPathDatFiles
{
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSString *extension = @"dat";
    NSString * localPath=[mUtils myDocumentsDirectoryPlus:@"Characters"];
    
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath: localPath error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            NSString *fullPathItem= [localPath stringByAppendingPathComponent:item];
            [matches addObject:fullPathItem];
        }
    }
    return matches;
}//createArrayOfFullPathDatFiles


//returns all files with sent extension in an array
-(NSArray *)findFiles:(NSString *)extension{
    
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:nil];
    
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            [matches addObject:item];
        }
    }
    return matches;
}


+ (void)removeOvalFilesAtFullPath:(NSString*) fullDocDirPath
{
    NSError *error;
    
    // get the documents folder of your sandbox
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSArray *dirFiles;
    if ((dirFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullDocDirPath error:&error]) == nil) {
        // handle the error
    };
    
    // find the files with the preface needed
    
    
    NSArray *ovalFiles = [dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self BEGINSWITH 'Oval'"]];
    
    
    
    // loop on arrays and delete every file corresponds to specific filename
    for (NSString *fileName in ovalFiles) {
        if (![[NSFileManager defaultManager] removeItemAtPath:[fullDocDirPath stringByAppendingPathComponent:fileName] error:&error]) {
            // handle the error
        }
    }
    return;
    
}


+(int) fileOrDirExistsAtPath:(NSString *)fullPath
{
    //return 0 if doesn't exist
    //return 1 if it is file
    //return 2 if it is directory
    
    int retval=0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    BOOL exists = [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
    if (exists) {
        /* file exists */
        retval=1;
        if (isDir) {
            /* file is a directory */
            retval=2;
        }
    }
    
    return retval;

}
///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Misc Helpers
//////////////////////////////////////////////////////////////////////////////////////

+(NSString *)makeDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"   ( EEEE MMMM d, YYYY  h:mm a, zzz) "];
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}
+(NSString *)makeFirstSecondDateTimePostString :(NSString*) firstString withSecondString:(NSString*)secondString withPostString:(NSString *)postString

{
    
    NSString        *dateString, *returnString, *spaceFirstString, *spaceSecondString;
    
    
    dateString = [self makeDateTimeString];
    if (!firstString)
        firstString = @"";
    if(!postString)
        postString=@"";
    if(!secondString)
        secondString=@"";
    
    spaceFirstString=[firstString stringByAppendingString:@""];
    spaceSecondString=[secondString stringByAppendingString:@""];
    
    
    returnString=[spaceFirstString stringByAppendingString:spaceSecondString];
    returnString=[returnString stringByAppendingString:dateString];
    returnString=[returnString stringByAppendingString:postString];
    
    return returnString;
}


+(void) dumpADictionary: (NSDictionary *)someDictionary logString: (NSString *)someString
{
    //  DDLogMyra(@"\n\n Dump of Dictionary %@:\n",someString);
    NSLog(@"\n\n Dump of Dictionary %@:\n",someString);
    for (id key in someDictionary) {
        
        //  DDLogMyra(@"key: %@, value: %@ \n", key, [someDictionary objectForKey:key]);
        NSLog(@"key: %@, value: %@ \n", key, [someDictionary objectForKey:key]);
        
    }
    
    
}//dumpADictionary:logString:



///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Image Helpers
//////////////////////////////////////////////////////////////////////////////////////


+(void)putImageToDebugDir:(UIImage *)thisImage withFileName:(NSString *)fname
{
    // SAVE TO DISK
    
    NSString *outputDirectoryPath=[mUtils myDocumentsDirectoryPlus:@"DEBUG"];
    
    
    
    
    NSString *filePathName = [outputDirectoryPath stringByAppendingPathComponent:fname];
    [UIImagePNGRepresentation (thisImage) writeToFile:filePathName atomically:YES]; // Save image.
}



+(void) putUIViewInFile:(NSString*)fname usingUIView:(UIView *)thisUIView //withImage:(UIImage *)thisImage
{
    
    
    
    CGRect rect = [thisUIView bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [thisUIView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self putImageToDebugDir:img withFileName:fname];
    
    //MARK STUFF IN THIS THING --- NEET CODE FROM OUR PAST MMFACE STUFF
    /*
     UIView *someView;
     someView = [[UIView alloc] initWithFrame:CGRectMake(0,0,thisImage.size.width,thisImage.size.height)];
     someView.backgroundColor = [UIColor clearColor];
     
     
     //put image in view
     UIImageView * imgHolder=[[UIImageView alloc] initWithImage:thisImage];
     [someView addSubview:imgHolder];
     
     UIView *dotMouthView;
     dotMouthView = [[UIView alloc] initWithFrame:CGRectMake(0,0,20,20)];
     dotMouthView.backgroundColor = [UIColor redColor];
     
     dotMouthView.center =theseParts.glMouthCenter;//.mouthCenter;
     dotMouthView.layer.cornerRadius = 5;
     [someView addSubview:dotMouthView];
     
     
     UIView *dotLeftEyeView;
     dotLeftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0,0,20,20)];
     dotLeftEyeView.backgroundColor = [UIColor blueColor];
     
     dotLeftEyeView.center =theseParts.glLeftEyeCenter;//.leftEyeCenter;
     dotLeftEyeView.layer.cornerRadius = 5;
     [someView addSubview:dotLeftEyeView];
     
     
     UIView *dotRightEyeView;
     dotRightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0,0,20,20)];
     dotRightEyeView.backgroundColor = [UIColor greenColor];
     
     dotRightEyeView.center =theseParts.glRightEyeCenter;//.rightEyeCenter;
     dotRightEyeView.layer.cornerRadius = 5;
     [someView addSubview:dotRightEyeView];
     
     
     
     //capture view to image
     
     CGRect rect = [someView bounds];
     
     UIGraphicsBeginImageContext(rect.size);
     CGContextRef context = UIGraphicsGetCurrentContext();
     [someView.layer renderInContext:context];
     UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     [self putImage:img withSegDirFileName:fname];
     */
    
}


@end
