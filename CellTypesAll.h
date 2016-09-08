//
//  CellTypesAll.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableProtoDefines.h" 
#import "GlobalCalcVals.h"



//#import "CellImageOnly.h"
//#import "CellTextDef.h"
//#import "ProductRecord.h"
@interface CellTypesAll : NSObject




@property (nonatomic, readwrite) int cellclassType;

@property (nonatomic, readwrite) CGFloat cellMaxHeight;
//@property (nonatomic, retain) NSMutableDictionary *dataRecords;
//@property (nonatomic, retain) NSString *dataRecordKey;
@property (nonatomic, readwrite)BOOL usedByHeaderOrFooter;
@property (nonatomic, readwrite) NSInteger nextTableView;
@property (nonatomic, readwrite) BOOL enableUserActivity;
//@property (nonatomic, retain) NSMutableDictionary *aProductDict;
//@property (nonatomic, retain) NSMutableDictionary *aLocDict;
//@property (nonatomic, retain) NSMutableDictionary *dataBaseDictsPtrs;
@property (nonatomic, readwrite, nullable)          NSMutableDictionary *productDict;
@property (nonatomic, readwrite, nullable)          NSMutableDictionary *locDict;

@property (nonatomic, readwrite) int buttonType;
//@property (nonatomic, retain) ProductRecord *aProduct;
//@property (nonatomic, readwrite) BOOL viewScrolls;
//@property (nonatomic, retain) NSMutableDictionary *dataBaseDict;
@property (nonatomic, readwrite) BOOL reloadOnly;
@property (nonatomic, readwrite, nullable) NSDate *cellDate;
-(void) killYourself;


//BELOW implemented when useful for all types of cells, otherwise not used (NOOP)



//Exposed initialization methods
-(CGFloat) estimateCellheightAsheader;
+ (nullable id )initCellDefaults;
+ (nullable id )initCellDefaultsWithBackColor:(nullable UIColor *)backColor;
+ (nullable id)initCellInUIViewWithCellText:(nullable NSString*)txt withTextColor:(nullable UIColor*)textClr withBackgroundColor:(nullable UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(nullable NSString*)txtFontName andViewBackColor:(nullable UIColor *)viewBackColor;
+ (nullable id )initCellText:(nullable NSString*)txt withTextColor:(nullable UIColor*)textClr withBackgroundColor:(nullable UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(nullable NSString*)txtFontName;

+ (nullable id)initCellWithImageAndText:(nullable NSString*)txt withTextColor:(nullable UIColor*)textClr withBackgroundColor:(nullable UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(nullable NSString*)txtFontName withImage:(nullable UIImage*)theImage withImageName:(nullable NSString*)theImageName withImageBackColor:(nullable UIColor *)imageBackColor;


+ (nullable id)initCellForTitleDefaults:(nullable UIImage *)imageToShow withPNGName:(nullable NSString *)imageName withBackColor:(nullable UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag;
+ (nullable id)initCellDefaults:(nullable UIImage *)imageToShow withPNGName:(nullable NSString *)imageName withBackColor:(nullable UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag;


//Exposed update methods

-(void)updateCellWithImageAndText:(nullable NSString*)txt withTextColor:(nullable UIColor*)textClr withBackgroundColor:(nullable UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(nullable NSString*)txtFontName withImage:(nullable UIImage*)theImage withImageName:(nullable NSString*)theImageName withImageBackColor:(nullable UIColor *)imageBackColor;


-(void) updateCellText:(nullable NSString*)txt withTextColor:(nullable UIColor*)textClr withBackgroundColor:(nullable UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(nullable NSString*)txtFontName;




//Exposed Viewing Methods
-(void) vcWillDisplayHeaderView:(nullable UIView *)view myVC:(nullable UITableViewController *) tvc;

-(void) putMeInTableViewCell:(nullable UITableViewCell*)tvcellPtr withTVC:(nullable UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH;
-(CGFloat) provideCellHeight:(nullable UITableViewCell*)tvcPtr;

-(nullable UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(nullable UITableViewController *) tvcPtr;




//Exposed Accessors -
-(nullable UIColor *) giveCellTextColor;
-(nullable UIColor *) giveCellBackColor;
-(nullable NSString *) giveCellTextStr;
-(nullable UIFont *) giveCellFontAndSize;
-(nullable UIImage *) giveCellImage;

//-(CGFloat) heightForMyRow;



//CellUIView manipulation methods
//-(void) addALabelCellToArray:(CellTextDef *) ctdPtr;
//-(void) replaceTheImageCell:(CellImageOnly *)cimageOnlyPtr;
//-(void) changeDisplayTemplate:(int)whichTemplate;



@end
