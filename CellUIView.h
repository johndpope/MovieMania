//
//  CellUIView.h
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
#import "CellImageOnly.h"
#import "CellTextDef.h"


#import "CustomCellUIView.h"


@interface CellUIView : CellTypesAll   //<UITextFieldDelegate>


@property (nonatomic, readwrite) UIColor *backgoundColor;




@property (nonatomic, readwrite) CustomCellUIView *templateUIView;   //final

@property (nonatomic, readwrite) UIView *templateASideView; //special.... holds two views TOP?BOTTOM

@property (nonatomic, readwrite) UIView *labelsUIView;
@property (nonatomic, readwrite) UIView *imageUIView;
@property (nonatomic, readwrite) UIView *buttonsUIView;

//@property (nonatomic, readwrite) UIScrollView *buttonsUIView;
@property (nonatomic, readwrite) UIView *inputFieldsUIView;
//#define kDISP_TEMPLATEIMAGE_LEFT 0
//#define kDISP_TEMPLATEIMAGE_RIGHT 1
//#define kDISP_TEMPLATEIMAGE_TOP 2
//#define kDISP_TEMPLATEIMAGE_BOTTOM 3
@property (nonatomic, readwrite) int displayTemplate; //kDISP_TEMPLATE//image location, cell array location implied



//I M A G E:   one image for now  CellImageOnly ptr
@property (nonatomic, readwrite) NSMutableArray *cioPtrArr;   //only using object 0  as CellImageOnly


//L A B E L S
//UILabel array.... CellTextDef ptrs
@property (nonatomic, readwrite) NSMutableArray *cTextDefsArray;
//#define kDISP_ALIGN_VERTICAL 0
//#define kDISP_ALIGN_HORIZONTAL 1
@property (nonatomic, readwrite) int displaycTextDefsAlign;

//B U T T O N S
@property (nonatomic, readwrite) NSMutableArray *cButtonsArray; //only using object 0  as CellButtonsScroll


//I N P U T   F I E L D S
@property (nonatomic, readwrite) NSMutableArray *cInputFieldsArray; //only using object 0  as CellButtonsScroll


//P O S I T I O N I N G
@property (nonatomic, readwrite) CGRect posTemplateContainerRect;
@property(nonatomic, readwrite) CGRect posTopRect;   //reassigned
@property(nonatomic, readwrite) CGRect posRightRect; //reassigned
@property(nonatomic, readwrite) CGRect posLeftRect; //reassigned
@property(nonatomic, readwrite) CGRect posBottomRect; //reassigned 






//To expose new method specific for this cell type, also add to CellTypesAll.h
+ (id )initCellDefaults;

+(CellUIView *)mkcuvImageLeft:(UIImage*)theImage withImageName:(NSString *)imName andImageSize:(CGSize)imsize andTextsArrayRight:(NSMutableArray*)labelsArray useTextSizeTopCell:(int)topTextSize useTextSizeAdditionalCells:(int)textSize withBackGroundColor:(UIColor*)backClr withTextColor:(UIColor*)textClr;

-(UIColor *) giveCellBackColor;

//+(CellUIView *)mkcuvImageLeft:(UIImage*)theImage withImageName:(NSString *)imName andImageSize:(CGSize)imsize andTextsArrayRight:(NSMutableArray*)labelsArray useTextSizeTopCell:(int)topTextSize useTextSizeAdditionalCells:(int)textSize;


-(void) changeDisplayTemplate:(int)whichTemplate;
-(void) defineTemplateUIViewforMaxWidth:(int)maxW maxHeight:(int)maxH;

@end
