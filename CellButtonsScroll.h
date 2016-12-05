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
//#import "HDButtonView.h"
#import "TableViewController.h"
#import "CellButtonsViewHolder.h"
//#import "CollectionViewHolder.h"

@interface CellButtonsScroll : CellTypesAll

@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) NSMutableArray *cellsButtonsArray;
@property (nonatomic, retain) UIScrollView* buttonContainerView;
@property (nonatomic, retain)    NSArray *buttonView;
@property (nonatomic, readwrite) BOOL indicateSelItem;
@property (nonatomic, readwrite) BOOL isCollectionView;
//@property (nonatomic, readwrite) BOOL    useCellButtonsViewHolder;

+ (id )initCellDefaults;

//+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)cellButtonArray;
+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray isCollectionView:(BOOL)isCollectionView;

-(UIColor *) giveCellBackColor;





@end
