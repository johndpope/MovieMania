//
//  ViewController.h
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, retain) NSMutableArray *myButtons;
@property (nonatomic, retain) UICollectionView *collectionView;
- (id)initWithButtons:(NSMutableArray*)myButtons viewFrame:(CGRect)thisFrame;
@end

