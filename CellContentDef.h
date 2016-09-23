//
//  CellContentDef.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#import "CellTypesAll.h"
#import "CustomTVCell.h"


@interface CellContentDef : NSObject


//@property (nonatomic, readwrite) UITableViewCell *ccTableViewCellPtr;
@property (nonatomic, readwrite) CustomTVCell *ccTableViewCellPtr;

@property (nonatomic, readwrite) CellTypesAll *ccCellTypePtr;




-(void) killYourself;
+ (CellContentDef *)initCellContentDefWithThisCell:(CellTypesAll*)cellTypeDefPtr;



@end
