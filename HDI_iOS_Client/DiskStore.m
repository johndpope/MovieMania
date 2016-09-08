//
//  DiskStore.m
//
//  Created by Myra Hambleton on 2/7/13.
//  Copyright (c) 2013 Hammond Development International. All rights reserved.
//

#import "DiskStore.h"


@implementation DiskStore

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Init
//////////////////////////////////////////////////////////////////////////////////////

+(DiskStore *)sharedDiskStore
{
    static DiskStore *sharedDiskStore;
    if (sharedDiskStore == nil) {
        sharedDiskStore = [[super allocWithZone:nil] init];
        
        
        [sharedDiskStore initDefaultValues];
        
    }
    
    return sharedDiskStore;
}

-(void) initDefaultValues
{
   
    
    //[self testMe_makeArchThenUnArch:archDirpathCreated];
    
    

    
}


-(void) testMe_makeArchThenUnArch:(NSString *)useDirectoryPath
{

    NSString *diskArchiveName=@"testImgDict.dat";
    //test make one
    NSMutableDictionary *testImgDict=[[NSMutableDictionary alloc]init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buffy100x100" ofType:@"png"];
    UIImage * defImage = [UIImage imageWithContentsOfFile:filePath];
    [testImgDict setObject:defImage forKey:@"defMovie"];
    [testImgDict setObject: defImage forKey:@"defMovie2"];
    
       NSMutableDictionary *gotFromDisk;
    //Do I Exist already?
    gotFromDisk=[self unArchiveAStoreDictionaryNamed:diskArchiveName];
    
    
    //STOREME
    [self archiveAStoreDictionary:testImgDict withName:diskArchiveName];//[NSKeyedArchiver archiveRootObject: testImgDict toFile: archpath];

    
    
    //RETRIEVEME
 
    gotFromDisk =[self unArchiveAStoreDictionaryNamed:diskArchiveName];
    
    UIImage *fdiskImg=[gotFromDisk objectForKey:@"defMovie"];
    [mUtils putImageToDebugDir:fdiskImg withFileName:@"someDefImage.png"];

}

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Archive
//////////////////////////////////////////////////////////////////////////////////////

-(void) archiveAStoreDictionary:(NSMutableDictionary *)thisDict withName:(NSString *)thisFileName
{
    if (!DISK_STORAGE_ENABLED) {
        NSLog(@"****** DISK STORAGE DISABLED");
        return;
    }
    NSString * archDirpathCreated=[mUtils createLocalDirectory:DISK_DOCSTORE];   //create if doesn't exist
    NSString * archFilepath=[archDirpathCreated stringByAppendingPathComponent:thisFileName];
    
    if (!archFilepath)
        return;  // Myra this hits in tvOS
    
    [NSKeyedArchiver archiveRootObject: thisDict toFile: archFilepath];
}





///////////////////////////////////////////////////////////////////////////////////////
#pragma mark  Unarchive
//////////////////////////////////////////////////////////////////////////////////////
-(NSMutableDictionary *) unArchiveAStoreDictionaryNamed:(NSString *)dictName
{
    if (!DISK_STORAGE_ENABLED) {
        NSLog(@"****** DISK STORAGE DISABLED");
        return nil;
    }
    
    //build path for all storageFiles:
    NSString *storeDocDir=[mUtils myDocumentsDirectoryPlus:DISK_DOCSTORE];
    
    
    NSString * archpath=[storeDocDir stringByAppendingPathComponent:dictName];
    
    if (![mUtils fileExistsAtDocDirPath:archpath]) {
        return nil;
    }
    
    
    
    NSMutableDictionary *gotFromDisk;
    gotFromDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:archpath];
    return gotFromDisk;
    
}




@end
