//
//  CellTextDef.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellTypesAll.h"
#import "TableProtoDefines.h" 
#import "DispTText.h"

@interface CellTextDef : CellTypesAll


@property (nonatomic, readwrite) DispTText *cellDispTextPtr;
@property (nonatomic, readwrite) int numberOfLines;
@property (nonatomic, readwrite) BOOL cellSeparatorVisible;



-(void) killYourself;
+ (id)initCellForTitleDefaults;
+ (id)initCellForSectionDefaults;
+ (id)initCellDefaults;
+ (id)initCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;



-(void) updateCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;

-(UILabel *)buildMultiLineLabelMaxWidth:(int)maxwidth;
-(UILabel *)buildSingleLineLabelMaxWidth:(int)maxwidth;


-(UIColor *) giveCellTextColor;
-(UIColor *) giveCellBackColor;
-(NSString *) giveCellTextStr;
-(UIFont *) giveCellFontAndSize;



@end
