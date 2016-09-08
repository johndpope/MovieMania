//
//  DispTText.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "DispTText.h"

@implementation DispTText


@synthesize textStr,textColor,textFontAndSize;
@synthesize backgoundColor,alignMe;




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    textColor=nil;
    textFontAndSize=nil;
    backgoundColor=nil;
    textStr=nil;
}
-(id) init
{
    self = [super init];
    if (self) {
        
        [self makeUseDefaults:self];
    }
    return self;
}
-(void) makeUseDefaults:(DispTText *)nDispTText
{

    nDispTText.textStr=@"";
    nDispTText.textColor=TK_TEXT_COLOR;
    nDispTText.backgoundColor=TK_TRANSPARENT_COLOR;
    
    nDispTText.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:12];
    nDispTText.alignMe=UIViewAutoresizingFlexibleRightMargin; //aligns left
    // UIViewAutoresizingFlexibleLeftMargin; //aligns right
    // UIViewAutoresizingFlexibleRightMargin; //aligns left

    
    //nDispTText.textFontName=@"Arial Rounded MT Bold";
   // nDispTText.textFontSize=DEF_CELLFONTSIZE;

    /*
    
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    NSLog(@"plain font: %@", font.fontName); // “HelveticaNeue”
    
    UIFont *boldFont = [UIFont fontWithDescriptor:[[font fontDescriptor] fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:font.pointSize];
    NSLog(@"bold version: %@", boldFont.fontName); // “HelveticaNeue-Bold”
    
    UIFont *italicFont = [UIFont fontWithDescriptor:[[font fontDescriptor] fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic] size:font.pointSize];
    NSLog(@"italic version: %@", italicFont.fontName); // “HelveticaNeue-Italic”
    
    UIFont *boldItalicFont = [UIFont fontWithDescriptor:[[font fontDescriptor] fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold | UIFontDescriptorTraitItalic] size:font.pointSize];
    NSLog(@"bold & italic version: %@", boldItalicFont.fontName); // “HelveticaNeue-BoldItalic”
    
    */
    
   

}
+ (DispTText *)initDispTTextDefaultsForSection
{
    DispTText* nDispTText=[[DispTText alloc]init];
    nDispTText.textStr=@"";
    nDispTText.textColor=TK_TEXT_COLOR;
    nDispTText.backgoundColor=TK_TRANSPARENT_COLOR;
     nDispTText.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:16];
    
    nDispTText.alignMe=UIViewAutoresizingFlexibleRightMargin; //aligns left
    //UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; aligns center
    // UIViewAutoresizingFlexibleLeftMargin; //aligns right
    // UIViewAutoresizingFlexibleRightMargin; //aligns left
    
    
    

    return nDispTText;
}

+ (DispTText *)initDispTTextDefaultsForTable
{
    DispTText* nDispTText=[[DispTText alloc]init];
    nDispTText.textStr=@"";
    nDispTText.textColor=TK_TEXT_COLOR;
    nDispTText.backgoundColor=TK_TRANSPARENT_COLOR;
 nDispTText.textFontAndSize=[UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    
    nDispTText.alignMe=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    //UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    // UIViewAutoresizingFlexibleLeftMargin; //aligns right
    // UIViewAutoresizingFlexibleRightMargin; //aligns left
    return nDispTText;
}
+ (DispTText *)initDispTTextDefaultsForCell
{
    DispTText* nDispTText=[[DispTText alloc]init];
    nDispTText.textStr=@"";
    nDispTText.textColor=TK_TEXT_COLOR;
    nDispTText.backgoundColor=TK_TRANSPARENT_COLOR;
    nDispTText.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:14];
    nDispTText.alignMe=UIViewAutoresizingFlexibleLeftMargin;
    //UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; aligns center
    // UIViewAutoresizingFlexibleLeftMargin; //aligns right
    // UIViewAutoresizingFlexibleRightMargin; //aligns left

    return nDispTText;

}
+ (DispTText *)initDispTTextDefaults
{
      DispTText* nDispTText=[[DispTText alloc]init];
    [nDispTText makeUseDefaults:nDispTText];
    return nDispTText;
}


+ (DispTText *)initDispTTextDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    DispTText* nDispTText=[[DispTText alloc]init];   //init sets defaults too
    
    
    nDispTText.textStr=txt;
    if (textClr) {
        nDispTText.textColor=textClr;
    }
    if (backColor) {
        nDispTText.backgoundColor=backColor;
    }
    if (txtFontName) {
        if (txtFontSize > 0){
            nDispTText.textFontAndSize=[UIFont fontWithName:txtFontName size:txtFontSize];
        }
        else{
            nDispTText.textFontAndSize=[UIFont fontWithName:txtFontName size:DEF_CELLFONTSIZE];
        }
       
    }
    else{
        //no font name - use system font
        if (txtFontSize > 0){
            nDispTText.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:txtFontSize];
        }
        else{
            nDispTText.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:DEF_CELLFONTSIZE];
        }
    }
   
    
    
     
    return nDispTText;

    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Update Methods
/////////////////////////////////////////

- (void)updateDispTTextDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    self.textStr=txt;
    if (textClr) {
        self.textColor=textClr;
    }
    
    if (backColor) {
        self.backgoundColor=backColor;
    }
   // else{
   //     self.backgoundColor=[UIColor redColor];
   // }
    if (txtFontName) {
        if (txtFontSize > 0){
            self.textFontAndSize=[UIFont fontWithName:txtFontName size:txtFontSize];
        }
        else{
            self.textFontAndSize=[UIFont fontWithName:txtFontName size:DEF_CELLFONTSIZE];
        }
        
    }
    else{
        //no font name, use system name
        //no font name - use system font
        if (txtFontSize > 0){
            self.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:txtFontSize];
        }
        else{
            self.textFontAndSize=[UIFont fontWithName:@"Helvetica Neue" size:DEF_CELLFONTSIZE];
        }

    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////
@end
