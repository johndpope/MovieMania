//
//  SectionDef.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TableProtoDefines.h"
#import "DispTText.h"
#import "CellContentDef.h"
#import "CellTypesAll.h"
#import "CellTextDef.h"
#import "CellImageOnly.h"
#import "CellButtonsScroll.h"
#import "CellStackView.h"




@interface SectionDef : NSObject

@property (nonatomic, readwrite) CellContentDef *sectionHeaderContentPtr;//CellTypesAll *sectionHeaderCellPtr;
@property (nonatomic, readwrite) CellContentDef *sectionFooterContentPtr;////CellTypesAll *sectionFooterCellPtr;


@property (nonatomic, readwrite) NSMutableArray *sCellsContentDefArr; //array of cellContentDef


-(void) killYourself;


+ (SectionDef *)initSectionDefaults;
+ (SectionDef *)initSectionHeaderAsSimpleStackView:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName;
+ (SectionDef *)initSectionHeaderImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName;



//left justified header/ftr text
+ (SectionDef *)initSectionHeaderText:(NSString*)htxt withTextColor:(UIColor*)htextClr withBackgroundColor:(UIColor*)hbackColor withTextFontSize:(int)htxtFontSize withTextFontName:(NSString*)htxtFontName footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName;

//centered header/ftr text
+ (SectionDef *)initSectionHeaderCenteredText:(NSString*)htxt withTextColor:(UIColor*)htextClr withBackgroundColor:(UIColor*)hbackColor withTextFontSize:(int)htxtFontSize withTextFontName:(NSString*)htxtFontName footerCenteredText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName;



+ (SectionDef *)initSectionHeaderAsButtons:(UIColor*)backColor  footerText:(NSString*)ftxt footerTextColor:(UIColor*)ftextClr footerBackgroundColor:(UIColor*)fbackColor footerTextFontSize:(int)ftxtFontSize footerTextFontName:(NSString*)ftxtFontName;


- (CGFloat) heightForFooterInSection;

- (CGFloat) heightForHeaderInSection;


-(void) vcWillDisplayHeaderView:(UIView *)view myVC:(UITableViewController *) tvc;

-(UIView *) showMyHeaderInDisplay:(UITableViewController *) tvc;

-(UIView *) showMyFooterInDisplay:(UITableViewController *) tvc;





@end
