//
//  CollectionViewCell.h
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"

@interface CollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) UIView *posterView;
@property (retain, nonatomic) UILabel *titleLabel;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, retain) UIButton *myButton;


@end
