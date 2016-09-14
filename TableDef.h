//
//  TableDef.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#import "TableProtoDefines.h"
#import "DispTText.h"
#import "CellContentDef.h"
#import "CellTypesAll.h"
#import "CellTextDef.h"
#import "CellImageOnly.h"

#import "CellImageLTextR.h"
#import "GlobalCalcVals.h"
#import "CellUIView.h"

#import "AutomatedXACT.h"

@interface TableDef : NSObject


@property (nonatomic, readwrite) CellContentDef *tableHeaderContentPtr;
@property (nonatomic, readwrite) BOOL tableHeaderFixed;
@property (nonatomic, readwrite) UIView *fixedTableHeaderUIView;


@property (nonatomic, readwrite) CellContentDef *tableFooterContentPtr;
@property (nonatomic, readwrite) BOOL tableFooterFixed;
@property (nonatomic, readwrite) UIView *fixedTableFooterUIView;



@property (nonatomic, readwrite) BOOL titleOpaque;
@property (nonatomic, readwrite) BOOL cellDispPrepared; //cells initialized and ready to display
@property (nonatomic, readwrite) int tvcCreatedHeight;
@property (nonatomic, readwrite) int tvcCreatedWidth;

@property (nonatomic, readwrite) NSMutableArray *tableSections; //SectionDef



@property (nonatomic , readwrite) NSMutableArray *tableVariablesArray; //array of TransactionData pointers
@property (nonatomic,readwrite) NSMutableDictionary *dbAllTabTransDict;// dictionary of Transaction(s) do-Able from this table
@property (nonatomic , readwrite) BOOL tableDisplayFirstVisibleNotification; //flag to only do these transactions once....when display starts up



@property(nonatomic, readwrite) NSMutableArray *autoXACTarray;

-(void) killYourself;








+ (TableDef *)initTableHeaderROTateImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName;
+ (TableDef *)initTableHeaderANDfooterROTateImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerImageName:(NSString*)footerImageName  withFooterBackgroundColor:(UIColor*)footerBackColor;
+ (TableDef *)initTableHeaderImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName;

+ (TableDef *)initTableDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName;

+ (TableDef *)initTableBothImageDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName withTheImage:(UIImage *) actualImage withImageName:(NSString*)imageName  withImageBackgroundColor:(UIColor*)imageBackColor;

-(void) showMeInDisplay:(UITableViewController *) tvc   tvcCreatedWidth:(int)createdWidth  tvcCreatedHeight:(int)createdHeight;
-(BOOL) cellCanOwnFocusThisRow:(int)thisRow andSection:(int) thisSection;//NEW

@end
