//
//  CellInputField.h
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"
#import "CellTypesAll.h"
#import "CellTextDef.h"
#import "TableProtoDefines.h" 
#import "DispTText.h"
#import "TransactionData.h"




@interface CellInputField : CellTypesAll <UITextFieldDelegate>
@property (nonatomic, readwrite) CellTextDef *placeholderTextDefPtr; //takes care of font, text, color, backcolor
@property (nonatomic, readwrite) CellTextDef *leftSideDispTextPtr;

@property (nonatomic, readwrite) int borderStyle;
@property (nonatomic, readwrite) int autocorrectionType;
@property (nonatomic, readwrite) int keyboardType;
@property (nonatomic, readwrite) int returnKeyType;
@property (nonatomic, readwrite) int  clearButtonMode;
@property (nonatomic, readwrite) int contentVerticalAlignment;
@property (nonatomic, readwrite) BOOL secureEntry;
@property (nonatomic, readwrite) BOOL allowSpeechDetect;
@property (nonatomic, readwrite) NSString *gInputFieldsDictKey;

@property (nonatomic, readwrite) NSNumber *wrappedTag;  //dictionary keys have to be objects
@property (nonatomic, readwrite) NSInteger displayTag;  //UIInputText.tag has to be an NSInteger
@property (nonatomic, readwrite) TransactionData *transDataPtr;
@property (nonatomic, readwrite) UIView* inputFieldIAV; //input accessory view
@property (nonatomic, readwrite) UILabel *helpLabel;
@property (nonatomic, readwrite) CellTextDef *helpTextPtr;


-(void) killYourself;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;
-(UITextField *)buildUITextFieldANDsetKey;
-(void) enterWasPressed;
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr;

@end
