//
//  CellInputField.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellInputField.h"
#import "Runtime.h"
@implementation CellInputField
{
    UITextField *myTextField;
    
}

@synthesize placeholderTextDefPtr,leftSideDispTextPtr;
@synthesize autocorrectionType,borderStyle,clearButtonMode,contentVerticalAlignment,keyboardType,returnKeyType;

@synthesize secureEntry;

@synthesize  transDataPtr,displayTag, wrappedTag;
@synthesize gInputFieldsDictKey;
@synthesize inputFieldIAV,helpLabel,helpTextPtr;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    [self.placeholderTextDefPtr killYourself];
    [self.leftSideDispTextPtr killYourself];
    [self.transDataPtr killYourself];
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellInputField *)nCell
{
    nCell.enableUserActivity=TRUE;
    nCell.cellclassType=CELLCLASS_INPUTFIELD;
    nCell.placeholderTextDefPtr=[CellTextDef initCellDefaults];
    nCell.placeholderTextDefPtr.cellDispTextPtr.textStr=@"enter text";
    nCell.placeholderTextDefPtr.numberOfLines=1;
    nCell.autocorrectionType=UITextAutocorrectionTypeNo;
    nCell.borderStyle=UITextBorderStyleRoundedRect;
    nCell.clearButtonMode=UITextFieldViewModeWhileEditing;
    nCell.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    nCell.keyboardType=UIKeyboardTypeDefault;
    nCell.returnKeyType=UIReturnKeyDone;
   
    nCell.cellMaxHeight=DEF_CELLHEIGHT;
    //nCell.userEntered=nil;   //moved to transactionData
    nCell.leftSideDispTextPtr=[CellTextDef initCellDefaults];
    nCell.leftSideDispTextPtr.cellDispTextPtr.textStr=nil;//not displayed by default
    nCell.secureEntry=FALSE;
    nCell.transDataPtr=[[TransactionData alloc]init];
    nCell.gInputFieldsDictKey=@"defaultCellKey";
    
    nCell.helpTextPtr=[CellTextDef initCellDefaults];
    nCell.helpTextPtr.cellDispTextPtr.textStr=@"";
    /*
#if TARGET_OS_TV

#endif
    */
}





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////
-(CGSize) estimateYourWidth:(NSString *)myText withFont:(UIFont *)myFont
{
    CGSize mySize=CGSizeZero;
    
   // NSDictionary *userAttributes = @{NSFontAttributeName: self.placeholderDispTextPtr.textFontAndSize,
   //                                  NSForegroundColorAttributeName: [UIColor blackColor]};
    
    NSDictionary *userAttributes = @{NSFontAttributeName: myFont};
    
    
    mySize = [myText sizeWithAttributes: userAttributes];
    return mySize;
}

-(UITextField *)buildUITextFieldANDsetKey
{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.borderStyle =self.borderStyle;// UITextBorderStyleRoundedRect;
    textField.font = self.placeholderTextDefPtr.cellDispTextPtr.textFontAndSize;//[UIFont systemFontOfSize:15];
    textField.placeholder = self.placeholderTextDefPtr.cellDispTextPtr.textStr;//@"enter text";
    textField.textColor=self.placeholderTextDefPtr.cellDispTextPtr.textColor;
  //!!  textField.backgroundColor=self.placeholderTextDefPtr.cellDispTextPtr.backgoundColor;
    textField.autocorrectionType =self.autocorrectionType;// UITextAutocorrectionTypeNo;
    textField.keyboardType = self.keyboardType;//UIKeyboardTypeDefault;
    textField.returnKeyType = self.returnKeyType;//UIReturnKeyDone;
    textField.clearButtonMode = self.clearButtonMode;//UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = self.contentVerticalAlignment;//UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType=UITextAutocapitalizationTypeNone;   //no first letter magically capitallized
    
    
    [textField setSecureTextEntry:self.secureEntry];   //YES changes typed chars to dots
    
    
    self.displayTag=[[GlobalTableProto sharedGlobalTableProto]giveMeUniqueNSIntegerForDisplayTag];   //tags are NSInteger
    self.wrappedTag=[NSNumber numberWithLong:self.displayTag];  //dictionary key is object=nsnumber
    
    

   [[GlobalTableProto sharedGlobalTableProto].allEntryFieldsDictionary setObject:self forKey:self.wrappedTag];

    
    
    textField.tag=displayTag;
    textField.userInteractionEnabled=YES;
    textField.delegate=self;
    myTextField = textField;
    
    
    
    
    //overrides for placeholder.... before it wasn't showing at all, have to set tintcolor
    textField.borderStyle=UITextBorderStyleLine;
    UIColor *pcolor=[UIColor whiteColor];//self.placeholderTextDefPtr.cellDispTextPtr.textColor;//myra putback [UIColor grayColor];
   textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholderTextDefPtr.cellDispTextPtr.textStr attributes:@{NSForegroundColorAttributeName: pcolor}];
    
    //    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:nil attributes:@{NSForegroundColorAttributeName: pcolor,NSFontAttributeName : [UIFont fontWithName:@"Helvetica Neue" size:14]}];
    
    textField.tintColor=[UIColor orangeColor];
   // NSLog(@" placeholder is %@",textField.placeholder);
    NSLog(@"");
    
    //[myTextField becomeFirstResponder];  //causes keyboard to appear  DO NOT DO THIS HERE
    return textField;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    return self.cellMaxHeight;
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //put my displayable contents in a passed table view cell
    
    
  //  tvcPtr.backgroundColor=self.cellDispTextPtr.backgoundColor;//ccTextDef.backgoundColor;
  //  tvcellPtr.textLabel.text=self.myImageName;
    
    UIView *viewToUse=[self putMeVisibleMaxWidth:maxW maxHeight:maxH withTVC:tvcontrollerPtr];
    
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    
    
    [tvcellPtr.contentView addSubview:viewToUse];
    self.cellMaxHeight=viewToUse.frame.size.height;
    
    
    
#if TARGET_OS_TV
    [myTextField becomeFirstResponder];  //causes keyboard to appear
#endif

    
    
  //NO  [tvcellPtr.contentView addSubview:aUIImageView];
    
    
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    //return  UIView to display this stuff
    UIView* returnedUIView;//=[[UIView alloc]initWithFrame:CGRectZero];
    UIFont *estimationFont;
    //  U I T E X T F I E L D
    
  //  CGSize sizeNeededPlaceHolderText=[self estimateYourWidth:self.placeholderTextDefPtr.cellDispTextPtr.textStr withFont:self.placeholderTextDefPtr.cellDispTextPtr.textFontAndSize];
    if (self.leftSideDispTextPtr) {
        estimationFont=self.leftSideDispTextPtr.cellDispTextPtr.textFontAndSize;
    }
    else{
        estimationFont=self.placeholderTextDefPtr.cellDispTextPtr.textFontAndSize;
    }
    CGSize sizeToEstimate1LineHeight=[self estimateYourWidth:@"hi" withFont:estimationFont];
    
    CGSize sizeForLeftLabel=[self estimateYourWidth:self.leftSideDispTextPtr.cellDispTextPtr.textStr withFont:self.leftSideDispTextPtr.cellDispTextPtr.textFontAndSize];
    
    //Left Label is optional.  Placeholder text is optional
    
    
    UITextField *textField=[self buildUITextFieldANDsetKey];

    
    
    
    //what size is text field?  what size should left label be if we have one?
    
    
    
    
    
    int paddingTop=5;
    int paddingSide=20;
    
    
    int estimatedLeftLabelWidth=sizeForLeftLabel.width;
    
    int widthInF;
    int widthLeftLabel;
    
    if (estimatedLeftLabelWidth < 1) { //NO left label
        widthLeftLabel=0;
        widthInF=maxwidth-(paddingSide*2)-widthLeftLabel; //biggest ever useable
    }
    else {
        widthLeftLabel=estimatedLeftLabelWidth;
        widthInF=maxwidth-(paddingSide*2)-widthLeftLabel; //biggest ever useable
        //IS THIS VALID?   divide equally if not
        if (widthInF < 10) { //10 is some minimum to enter into?
            //reduce font size of label I guess
            widthInF=(maxwidth- (paddingSide*2))/2;
            widthLeftLabel=maxwidth-widthInF;
            
        }
    }
    
 
    
    
    
    UILabel *aLabel=nil;
    
   
    self.helpLabel=nil;
    
    
    textField.frame= CGRectMake(0, 0, widthInF, sizeToEstimate1LineHeight.height);
    
    if ([self.leftSideDispTextPtr.cellDispTextPtr.textStr length] > 0) {
        self.leftSideDispTextPtr.cellDispTextPtr.alignMe= NSTextAlignmentRight;//FORCE right justified label
        aLabel=[self.leftSideDispTextPtr buildSingleLineLabelMaxWidth:widthLeftLabel];    // B U I L D
        
        int totalObjectsHeight=aLabel.frame.size.height;
        if (totalObjectsHeight < textField.frame.size.height) {
            totalObjectsHeight=textField.frame.size.height;
        }
        
        
        
         returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, paddingTop, maxwidth  , totalObjectsHeight + (paddingTop*2))] ;
        
        
        textField.center=CGPointMake(returnedUIView.frame.size.width - (textField.frame.size.width/2) -2, returnedUIView.frame.size.height/2);
       // aLabel.center=CGPointMake(,returnedUIView.frame.size.height/2);
        aLabel.center=CGPointMake(fabs( maxwidth-textField.frame.size.width-(aLabel.frame.size.width/2)-2),returnedUIView.frame.size.height/2);
        
        
        
        //create helptext for TVOS
     CGSize sizeForHelpLabel=[self estimateYourWidth:self.helpTextPtr.cellDispTextPtr.textStr withFont:self.helpTextPtr.cellDispTextPtr.textFontAndSize];
        
        helpLabel=[helpTextPtr buildSingleLineLabelMaxWidth:sizeForHelpLabel.width];
        
        
        
        [returnedUIView addSubview: aLabel];   //remember aLabel height can be bigger than one line
         [returnedUIView addSubview:textField];
        
        
    }
    else{
        self.helpLabel=nil;
        returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, paddingTop, maxwidth  , textField.frame.size.height + (paddingTop*2))] ;
        
        // returnedUIView.backgroundColor=[UIColor redColor];
        textField.center=CGPointMake(returnedUIView.frame.size.width/2, returnedUIView.frame.size.height/2);
        [returnedUIView addSubview:textField];

    }
    
    
  
    
    
    
    self.cellMaxHeight=returnedUIView.frame.size.height;
    
#if TARGET_OS_TV
    [myTextField becomeFirstResponder];  //causes keyboard to appear
#endif

    return returnedUIView;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  UITextField processing
////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField{   //enter in field
    NSLog(@"CellInputField  textFieldShouldReturn:");
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{   //hit tab, after shouldReturn (enter)
   
NSLog(@"CellInputField  textFieldShouldEndEditing:");
   self.transDataPtr.userDefinedData=textField.text;//NEW
    if (textField.text) {
         [[GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.gInputFieldsDictionary setObject:textField.text forKey: self.gInputFieldsDictKey];
    }
   textField.placeholder = textField.text; //new tvos testing
    UIColor *pcolor=[UIColor whiteColor];//self.placeholderTextDefPtr.cellDispTextPtr.textColor;//myra putback [UIColor grayColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.text attributes:@{NSForegroundColorAttributeName: pcolor}];
    //textField.tintColor=[UIColor grayColor];
    //[textField setNeedsDisplay];
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return YES;
    
    
 //   self.userEntered=textField.text;
 //   [textField resignFirstResponder];
 //   return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{   //after shouldEndEditing completes
    
    NSLog(@"CellInputField  textFieldDidEndEditing:");

    
    
 /*   if (!textField)
        textField = myTextField;
    NSLog(@"textfield.tag %ld",(long)textField .tag);
//    NSInteger tag=textField.tag;
    
 //   NSString *keyString = [NSString stringWithFormat:@"%ld",tag];
 //   CellInputField *thisCellInputField=[[GlobalTableProto sharedGlobalTableProto].allEntryFieldsDictionary objectForKey:keyString];
    NSLog(@"data entered is %@",textField.text);
    self.userEntered=textField.text;
    [textField resignFirstResponder];
//ZY    CellInputField *cifPtr;
//    cifPtr=(CellInputField *)textField.tag;
    NSLog(@"");*/
}
-(void) setupInputAccessoryView:(UITextField *)textField{
    
    NSLog(@"current inputAccessoryView %@",textField.inputAccessoryView);
    
#if TARGET_OS_TV
    
    //its always full screen so have to have accessory view or won't know what you are replacing
    
    if (!helpLabel) {
        return;
    }
    
    self.inputFieldIAV=[[UIView alloc]initWithFrame: CGRectMake(0, 0, helpLabel.bounds.size.width + 10, helpLabel.bounds.size.height+10)];
    //self.inputFieldIAV.backgroundColor=[UIColor redColor];
    [self.inputFieldIAV addSubview:self.helpLabel];
    
    
    
    textField.inputAccessoryView= self.inputFieldIAV;
    NSLog(@"now inputAccessoryView %@",textField.inputAccessoryView);
    NSLog(@"");
#endif
    
    
    

    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"CellInputField  textFieldShouldBeginEditing:");
    [self setupInputAccessoryView:textField];
    

   
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"CellInputField  textFieldDidBeginEditing:");
      textField.tintColor=[UIColor whiteColor];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"CellInputField textfield did begin editing");
    
    //get the current data strsing inside the text field
    NSString *myTextData = [textField.text stringByReplacingCharactersInRange:range
                                                                   withString:string];
    NSInteger fieldTag = textField.tag;
    NSLog(@"Current data in text field is %@  usingTag %li", myTextData,(long)fieldTag);
    // NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    
    self.transDataPtr.userDefinedData=myTextData;//NEW
    
    if (myTextData) {
        [[GlobalTableProto sharedGlobalTableProto].liveRuntimePtr.gInputFieldsDictionary setObject:myTextData forKey: self.gInputFieldsDictKey];
    }
    
    
    return YES;

}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"CellInputField textFieldShouldClear:");
    return YES;
}

@end
