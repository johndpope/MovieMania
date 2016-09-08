//
//  CellImageOnly.h
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
//#import "GlobalTableProto.h"


@interface CellImageOnly : CellTypesAll

@property (nonatomic, readwrite) UIImage *myImage;
@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) NSString *myImageName;
@property (nonatomic, readwrite) BOOL rotateWhenVisible;
@property (nonatomic, readwrite) UIImageView *myUIImageViewRotating;
@property (nonatomic, readwrite) CGSize imageSize;

+ (id)initCellForTitleDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag;
+ (id)initCellDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag withSize:(CGSize)picSize;

-(UIImage *) giveCellImage;
-(UIColor *) giveCellBackColor;

- (void)updateCellImage:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag;
- (void)updateCellImage:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag withSize:(CGSize)picSize;
-(void) killYourself;
@end
