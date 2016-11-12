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
#import "CollectionViewHolder.h"
#import "CellButtonsContainer.h"
@interface CellCollectionView : CellTypesAll


@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) NSMutableArray *cellsButtonsArray;
@property (nonatomic, readwrite) UIScrollView* buttonContainerView;
@property (nonatomic, retain)    NSArray *buttonView;
@property (nonatomic, readwrite) BOOL indicateSelItem;

+ (id )initCellDefaults;

+ (id )initCellDefaultsWithBackColor:(UIColor *)backColor withCellButtonArray:(NSMutableArray *)buttonArray; //buttonScroll:(BOOL)buttonsScroll;

-(UIColor *) giveCellBackColor;





@end
