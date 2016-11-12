//
//  ViewController.h
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActionRequest;
@interface CollectionViewHolder : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray *myButtons;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIImageView *selectedBtnBox;
@property (nonatomic, readwrite) ActionRequest *tvfocusAction;
@property (nonatomic, strong) UIScrollView          *containerView;

- (id)initWithButtons:(NSMutableArray*)myButtons viewFrame:(CGRect)thisFrame forContainer:(UIScrollView*)container;
@end

