//
//  ViewController.h
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TableViewController.h"
@class ActionRequest;
@class TableViewController;
@interface CollectionViewHolder : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray*  buttonSequence;//*myButtons;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIImageView *selectedBtnBox;
@property (nonatomic, readwrite) ActionRequest *tvfocusAction;
@property (nonatomic, strong) UIScrollView          *containerView;
@property (nonatomic, readwrite) int                rowNumber;
- (id)initWithContainer:(UIScrollView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr withTVC:(TableViewController *)tvcPtr;
- (id)initWithButtons:(NSMutableArray*)myButtons viewFrame:(CGRect)thisFrame forContainer:(UIScrollView*)container viewScrolls:(BOOL)viewScrolls;
@end

