//
//  CellButtonsScroll.h
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
#import "HDButtonView.h"
#import "TableViewController.h"
@interface CellButtonsScroll : CellTypesAll


@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) NSMutableArray *cellsButtonsArray;
@property (nonatomic, readwrite) UIScrollView* buttonContainerView;
@property (nonatomic, retain)    NSArray *buttonView;
//@property (nonatomic, readwrite) BOOL reloadOnly;//@property (nonatomic, readwrite) BOOL buttonViewScrolls;
//@property (nonatomic, readwrite) HDButtonView* buttonView;

//To expose new method specific for this cell type, also add to CellTypesAll.h
+ (id )initCellDefaults;

//+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)cellButtonArray;
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray; //buttonScroll:(BOOL)buttonsScroll;

-(UIColor *) giveCellBackColor;





@end
