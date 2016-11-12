//
//  CellButtonsContainer.h
//  MovieManiaDualOS
//
//  Created by Dan Hammond on 11/12/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellTypesAll.h"


@interface CellButtonsContainer : CellTypesAll
@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) NSMutableArray *cellsButtonsArray;
@property (nonatomic, readwrite) UIScrollView* buttonContainerView;
@property (nonatomic, readwrite) NSArray *buttonView;
@property (nonatomic, readwrite) BOOL indicateSelItem;




@end
