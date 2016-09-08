//
//  DispTText.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TableProtoDefines.h"

@interface DispTText : NSObject



@property (nonatomic, readwrite) NSString *textStr;
@property (nonatomic, readwrite) UIColor *textColor;
@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) UIFont *textFontAndSize;
@property (nonatomic, readwrite)  int alignMe;

-(void) killYourself;


+ (DispTText *)initDispTTextDefaultsForCell;
+ (DispTText *)initDispTTextDefaultsForSection;
+ (DispTText *)initDispTTextDefaultsForTable;
+ (DispTText *)initDispTTextDefaults;

+ (DispTText *)initDispTTextDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;



- (void)updateDispTTextDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName;




@end
