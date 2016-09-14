//
//  CustomTVCell.h
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "CellDataHolder.h"




@interface CustomTVCell : UITableViewCell <UIGestureRecognizerDelegate, UIScrollViewDelegate >



//@property (nonatomic, readwrite) CellDataHolder *cellDataHptr;   //pointer to the data used to make this cell display
@property (nonatomic, readwrite) int dispAsRow;
@property (nonatomic, readwrite) int dispAsSection;
@property (nonatomic, readwrite) BOOL initialized;

@property (nonatomic, readwrite) BOOL focusThisCellvar;

-(CustomTVCell*)mkSelfForSection:(int)thisSection andRow:(int)thisRow onTableDef:(id)tableDefPtr;
-(void) customCellInFocus:(BOOL)selected;
//-(CustomTVCellControl*)mkSelfContainDisplayForSection:(int)thisSection andRow:(int)thisRow;
//-(CustomTVCellControl*)mkSelfContainDisplayForSection:(int)thisSection andRow:(int)thisRow onTableDef:(TableDef *)tableDefPtr;

@end
