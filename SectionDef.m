//
//  SectionDef.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "SectionDef.h"

@implementation SectionDef




@synthesize sCellsContentDefArr;
@synthesize sectionFooterContentPtr;
@synthesize sectionHeaderContentPtr;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    [self.sectionFooterContentPtr killYourself];
    [self.sectionHeaderContentPtr killYourself];
    for (int i=0; i<[self.sCellsContentDefArr count]; i++) {
        [[self.sCellsContentDefArr objectAtIndex:i] killYourself];
    }
    self.sCellsContentDefArr=nil;
}

-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(SectionDef *)nSectionDef
{
    
    //note default is a text cell header and text cell footer
    //don't assume there is a section header or footer?

    
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc] init];// [CellTextDef initCellForSectionDefaults];
    
    if (nSectionDef.sectionHeaderContentPtr) {
        nSectionDef.sectionHeaderContentPtr.ccTableViewCellPtr=nil;
    }

    
 
    
    
    nSectionDef.sectionFooterContentPtr=[[CellContentDef alloc] init];//[CellTextDef initCellForSectionDefaults];
    if (nSectionDef.sectionFooterContentPtr) {
        nSectionDef.sectionFooterContentPtr.ccTableViewCellPtr=nil;
    }
    
    
    nSectionDef.sCellsContentDefArr=[[NSMutableArray alloc]init];


}

+ (SectionDef *)initSectionDefaults
{
    
    /*
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0];
    cell.textLabel.numberOfLines=2;
    cell.textLabel.lineBreakMode=UILineBreakModeMiddleTruncation;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    */
    SectionDef* nSectionDef=[[SectionDef alloc]init];
    [nSectionDef makeUseDefaults:nSectionDef];
    return nSectionDef;
}


+ (SectionDef *)initSectionHeaderAsButtons:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    SectionDef* nSectionDef=[[SectionDef alloc]init];   //init sets defaults for us
    [nSectionDef.sectionHeaderContentPtr killYourself];   //get rid of default header text cell created by init
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr=[CellButtonsScroll initCellDefaults];  //default initializer - just sets color to demonstrate
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    
    if (!ftxt) {
        [nSectionDef.sectionFooterContentPtr killYourself];
        nSectionDef.sectionFooterContentPtr=nil;
    }
    else{
            [nSectionDef.sectionFooterContentPtr.ccCellTypePtr updateCellText:ftxt withTextColor:ftextClr withBackgroundColor:fbackColor withTextFontSize:ftxtFontSize withTextFontName:ftxtFontName];
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    }
    

    //  [nTableDef.tableFooterCellPtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    return nSectionDef;
}
+ (SectionDef *)initSectionHeaderAsSimpleStackView:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    SectionDef* nSectionDef=[[SectionDef alloc]init];   //init sets defaults for us
    [nSectionDef.sectionHeaderContentPtr killYourself];   //get rid of default header text cell created by init
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr=[CellStackView initCellDefaults];  //default initializer - just sets color to demonstrate
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    
    
    [nSectionDef.sectionFooterContentPtr.ccCellTypePtr updateCellText:ftxt withTextColor:ftextClr withBackgroundColor:fbackColor withTextFontSize:ftxtFontSize withTextFontName:ftxtFontName];
    //  [nTableDef.tableFooterCellPtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    nSectionDef.sectionFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    
    return nSectionDef;
}



+ (SectionDef *)initSectionHeaderImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    SectionDef* nSectionDef=[[SectionDef alloc]init];   //init sets defaults for us
    [nSectionDef.sectionHeaderContentPtr killYourself];   //get rid of default header text cell created by init
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr=[CellImageOnly initCellForTitleDefaults:nil withPNGName:imageName withBackColor:backColor rotateWhenVisible:FALSE];
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
       
 
  //  [nTableDef.tableFooterCellPtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    
    if (ftxt) {
        [nSectionDef.sectionFooterContentPtr.ccCellTypePtr updateCellText:ftxt withTextColor:ftextClr withBackgroundColor:fbackColor withTextFontSize:ftxtFontSize withTextFontName:ftxtFontName];
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    }
    else{
        nSectionDef.sectionFooterContentPtr=nil;
    }
    
    
    return nSectionDef;
}



+ (SectionDef *)initSectionHeaderText:(NSString*)htxt withTextColor:(UIColor*)htextClr withBackgroundColor:(UIColor*)hbackColor withTextFontSize:(int)htxtFontSize withTextFontName:(NSString*)htxtFontName footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName
{
    
    //nil values sent cause defaults to be used.
    
    SectionDef* nSectionDef=[[SectionDef alloc]init];   //init sets defaults for us
    
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr=[CellTextDef initCellForSectionDefaults];
    
    
    
    
    [nSectionDef.sectionHeaderContentPtr.ccCellTypePtr updateCellText:htxt withTextColor:htextClr withBackgroundColor:hbackColor withTextFontSize:htxtFontSize withTextFontName:htxtFontName];
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    
    if (ftxt) {
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr=[CellTextDef initCellForSectionDefaults];
        [nSectionDef.sectionFooterContentPtr.ccCellTypePtr updateCellText:ftxt withTextColor:ftextClr withBackgroundColor:fbackColor withTextFontSize:ftxtFontSize withTextFontName:ftxtFontName];
        
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    }
    else{
        nSectionDef.sectionFooterContentPtr=nil;
    }
    

    
    return nSectionDef;
}
+ (SectionDef *)initSectionHeaderCenteredText:(NSString*)htxt withTextColor:(UIColor*)htextClr withBackgroundColor:(UIColor*)hbackColor withTextFontSize:(int)htxtFontSize withTextFontName:(NSString*)htxtFontName footerCenteredText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName
{
    
    //nil values sent cause defaults to be used.
    
    SectionDef* nSectionDef=[[SectionDef alloc]init];   //init sets defaults for us
    
    nSectionDef.sectionHeaderContentPtr=[[CellContentDef alloc]init];
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr=[CellTextDef initCellForSectionDefaults];
    
    
    
    [nSectionDef.sectionHeaderContentPtr.ccCellTypePtr updateCellText:htxt withTextColor:htextClr withBackgroundColor:hbackColor withTextFontSize:htxtFontSize withTextFontName:htxtFontName];
    
    CellTextDef *ctdptr=(CellTextDef*)nSectionDef.sectionHeaderContentPtr.ccCellTypePtr;
    ctdptr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;

    
    
    nSectionDef.sectionHeaderContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
    
    if (ftxt) {
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr=[CellTextDef initCellForSectionDefaults];
        [nSectionDef.sectionFooterContentPtr.ccCellTypePtr updateCellText:ftxt withTextColor:ftextClr withBackgroundColor:fbackColor withTextFontSize:ftxtFontSize withTextFontName:ftxtFontName];
        
        nSectionDef.sectionFooterContentPtr.ccCellTypePtr.usedByHeaderOrFooter=TRUE;
        
        
        ctdptr=(CellTextDef*)nSectionDef.sectionFooterContentPtr.ccCellTypePtr;
        ctdptr.cellDispTextPtr.alignMe=NSTextAlignmentCenter;
        
        
        
    }
    else{
        nSectionDef.sectionFooterContentPtr=nil;
    }
    
    
    
    return nSectionDef;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////
- (CGFloat) heightForFooterInSection
{
    
    if(self.sectionFooterContentPtr){
        return self.sectionFooterContentPtr.ccCellTypePtr.cellMaxHeight;
    }
    else
    {
        return 0;
    }
    
}
- (CGFloat) heightForHeaderInSection
{
    CGFloat someh;
    if(self.sectionHeaderContentPtr){
       // CGFloat answer= [self.sectionHeaderContentPtr.ccCellTypePtr  provideCellHeight:thisCell];
        
        
        if (!self.sectionHeaderContentPtr.ccCellTypePtr.cellMaxHeight) {   //when this is zero, must estimate it
           someh= [self.sectionHeaderContentPtr.ccCellTypePtr estimateCellheightAsheader];
            return someh;
        }
        
        return  self.sectionHeaderContentPtr.ccCellTypePtr.cellMaxHeight;
    }
    else
    {
        return 0;
    }

    
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(void) vcWillDisplayHeaderView:(UIView *)view myVC:(UITableViewController *) tvc
{
    //the UITableViewController is displayinbg the passed view for this section
    if ( self.sectionHeaderContentPtr){
         [ self.sectionHeaderContentPtr.ccCellTypePtr vcWillDisplayHeaderView:view myVC:tvc];
        
    }

    
    
}
-(UIView *) showMyHeaderInDisplay:(UITableViewController *) tvc
{
    
    GlobalCalcVals *gGCVptr=[GlobalCalcVals sharedGlobalCalcVals];
    if ( self.sectionHeaderContentPtr){
        return [ self.sectionHeaderContentPtr.ccCellTypePtr putMeVisibleMaxWidth:gGCVptr.tableCreatedWidth maxHeight:gGCVptr.tableCreatedHeight withTVC:tvc];
        
    }
    
    
    
    return  nil;
    
    
 
}
-(UIView *) showMyFooterInDisplay:(UITableViewController *) tvc
{
    
    
    GlobalCalcVals *gGCVptr=[GlobalCalcVals sharedGlobalCalcVals];
    if ( self.sectionFooterContentPtr){
        return [ self.sectionFooterContentPtr.ccCellTypePtr putMeVisibleMaxWidth:gGCVptr.tableCreatedWidth maxHeight:gGCVptr.tableCreatedHeight withTVC:tvc];
        
    }
    
    
    
    return  nil;

    
    
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
