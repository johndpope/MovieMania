//
//  CellImageLTextR.h
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
#import "CellImageOnly.h"

@interface CellImageLTextR : CellTypesAll

@property (nonatomic, readwrite) CellImageOnly *cellImagePtr;
@property (nonatomic, readwrite) DispTText *cellDispTextPtr;
@property (nonatomic, readwrite) int numberOfLines;

-(void) killYourself;
+ (id)initCellForTitleDefaults;

+ (id)initCellDefaults;
+ (id)initCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;
+ (id)initCellWithImageAndText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName withImage:(UIImage*)theImage withImageName:(NSString*)theImageName withImageBackColor:(UIColor *)imageBackColor withSize:(CGSize)picSize;


-(void) updateCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;




-(UIColor *) giveCellTextColor;
-(UIColor *) giveCellBackColor;
-(NSString *) giveCellTextStr;
-(UIFont *) giveCellFontAndSize;



@end
