//
//  CellStackView.h
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


@interface CellStackView : CellTypesAll


@property (nonatomic, readwrite) UIColor *backgoundColor;
@property (nonatomic, readwrite) UIView *myActiveUIView;
@property (nonatomic, readwrite) NSMutableArray *cellStackViewArray;

//To expose new method specific for this cell type, also add to CellTypesAll.h
+ (id )initCellDefaults;



-(UIColor *) giveCellBackColor;





@end
