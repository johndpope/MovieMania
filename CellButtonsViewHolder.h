//
//  CellButtonsViewHolder.h
//  MovieManiaDualOS
//
//  Created by Dan Hammond on 11/15/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TableViewController.h"
@class TableViewController;
@class ActionRequest;
@class CellButtonsScroll;
@interface CellButtonsViewHolder : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray*  buttonSequence;//*myButtons;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIImageView *selectedBtnBox;
@property (nonatomic, readwrite) ActionRequest *tvfocusAction;
@property (nonatomic, strong) UIScrollView          *containerView;
@property (nonatomic, readwrite) int                rowNumber;
@property (nonatomic, readwrite) BOOL  isCollectionView;

- (id)initWithContainer:(UIScrollView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr withTVC:(TableViewController *)tvcPtr asCollectionView:(BOOL)asCollectionView;
- (id)initWithButtons:(NSMutableArray*)myButtons viewFrame:(CGRect)thisFrame forContainer:(UIScrollView*)container viewScrolls:(BOOL)viewScrolls;

+(void)removeSelectedButtonBoxFromAllRows;
+(void)newSectionFromTableViewScroll:(NSIndexPath*)indexPath;


@end


