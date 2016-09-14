//
//  CellContentDef.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellContentDef.h"

@implementation CellContentDef

@synthesize ccCellTypePtr,ccTableViewCellPtr;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    [self.ccCellTypePtr killYourself];
    self.ccTableViewCellPtr = nil;
    
}


-(id) init
{
    self = [super init];
    if (self) {
        
        //[self makeUseDefaults:self];
    }
    return self;
}


+ (CellContentDef *)initCellContentDefWithThisCell:(CellTypesAll*)cellTypeDefPtr 
{
    CellContentDef * nCellContentDef = [[CellContentDef alloc]init];  //this sets defaults
    
    nCellContentDef.ccCellTypePtr=cellTypeDefPtr;
    nCellContentDef.ccTableViewCellPtr=nil;

    
    return nCellContentDef;
}

-(void) makeUseDefaults:(CellContentDef *)nCellContentDef
{
    nCellContentDef.ccTableViewCellPtr=nil;
    nCellContentDef.ccCellTypePtr=nil;


}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
