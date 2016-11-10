//
//  MovieCollectionViewCell.h
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"

@interface MovieCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) UIImageView *posterImageView;
@property (retain, nonatomic) UILabel *titleLabel;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, retain) UIButton *myButton;


@end
