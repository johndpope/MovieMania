//
//  CellTypesAll.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellTypesAll.h"

@implementation CellTypesAll


@synthesize cellclassType,cellMaxHeight;//,dataRecordKey, dataRecords;
@synthesize usedByHeaderOrFooter;
@synthesize nextTableView, enableUserActivity;
//@synthesize dataBaseDict;
//@synthesize dataBaseDictsPtrs;// aProductDict, aLocDict;
@synthesize productDict,locDict;
@synthesize reloadOnly;
@synthesize cellDate;
@synthesize buttonType;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////

-(id) init
{
    self = [super init];
    if (self) {
//         dataBaseDictsPtrs = [[NSMutableDictionary alloc] init];
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellTypesAll *)nCell
{
    
    nCell.cellclassType=CELLCLASS_UNKNOWN;
    nCell.cellMaxHeight=0;
    nCell.usedByHeaderOrFooter=FALSE;
    nCell.enableUserActivity = TRUE;
   
}

+ (id )initCellDefaults
{
    
    /*   loadView
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0];
    cell.textLabel.numberOfLines=2;
    cell.textLabel.lineBreakMode=UILineBreakModeMiddleTruncation;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    */
    CellTypesAll* nCell=[[CellTypesAll alloc]init];
    [nCell makeUseDefaults:nCell];
    return nCell;
}
+ (id)initCellInUIViewWithCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName andViewBackColor:(UIColor *)viewBackColor
{
    return nil;
}
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor
{
    return nil;
}
+ (id)initCellWithImageAndText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName withImage:(UIImage*)theImage withImageName:(NSString*)theImageName withImageBackColor:(UIColor *)imageBackColor
{
    return nil;
}

+ (id)initCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    //nil values sent cause defaults to be used.
    return nil;
    
}


+ (id)initCellForTitleDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag
{
    return nil;
}
+ (id)initCellDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag
{
    return nil;
}
-(void) killYourself
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////
-(void) updateCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    //stub 
}
-(void)updateCellWithImageAndText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName withImage:(UIImage*)theImage withImageName:(NSString*)theImageName withImageBackColor:(UIColor *)imageBackColor
{
    
}
-(CGFloat) estimateCellheightAsheader
{
    return 2;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(void) vcWillDisplayHeaderView:(UIView *)view myVC:(UITableViewController *) tvc
{
    
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //put my displayable contents in a passed table view cell
    
    

    
}
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    return 0;
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    return nil;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
/*-(CGFloat) heightForMyRow
{
    return 0;
}*/
-(UIColor *) giveCellTextColor
{
    return nil;
}
-(UIColor *) giveCellBackColor
{
    return nil;
}
-(NSString *) giveCellTextStr
{
    return nil;
}
-(UIFont *) giveCellFontAndSize
{
    return nil;
}
-(UIImage *) giveCellImage
{
    return nil;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
