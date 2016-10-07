//
//  CellTextDef.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellTextDef.h"

@implementation CellTextDef


@synthesize cellDispTextPtr,numberOfLines;
@synthesize cellSeparatorVisible;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    [cellDispTextPtr killYourself];
    cellDispTextPtr=nil;
    
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellTextDef *)nCellTextDef
{
    nCellTextDef.enableUserActivity=TRUE;
    nCellTextDef.cellclassType=CELLCLASS_TEXT;
   nCellTextDef.cellDispTextPtr=[DispTText initDispTTextDefaultsForCell];
    nCellTextDef.numberOfLines=1;
    nCellTextDef.cellMaxHeight=0;
    nCellTextDef.cellSeparatorVisible=FALSE;
   

}


+ (id)initCellForTitleDefaults
{
    CellTextDef* nCellTextDef=[[CellTextDef alloc]init];    //calls makeUseDefaults
    
   nCellTextDef.cellDispTextPtr=[DispTText initDispTTextDefaultsForTable];
    return nCellTextDef;

}
+ (id)initCellForSectionDefaults
{
    CellTextDef* nCellTextDef=[[CellTextDef alloc]init];    //calls makeUseDefaults
    
    nCellTextDef.cellDispTextPtr=[DispTText initDispTTextDefaultsForSection];
    return nCellTextDef;
    
}
+ (id)initCellDefaults
{
    
    /*   loadView
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0];
    cell.textLabel.numberOfLines=2;
    cell.textLabel.lineBreakMode=UILineBreakModeMiddleTruncation;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    */
    CellTextDef* nCellTextDef=[[CellTextDef alloc]init];
    [nCellTextDef makeUseDefaults:nCellTextDef];
    return nCellTextDef;
}


+ (id)initCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    //nil values sent cause defaults to be used.
    CellTextDef* nCellTextDef=[[CellTextDef alloc]init]; //init sets defaults for us
    
    [nCellTextDef updateCellText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    
    
        
    nCellTextDef.numberOfLines=1;
     
    return nCellTextDef;

    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellTextColor
{
    return self.cellDispTextPtr.textColor;
}
-(UIColor *) giveCellBackColor
{
    return self.cellDispTextPtr.backgoundColor;
}
-(NSString *) giveCellTextStr
{
    return self.cellDispTextPtr.textStr;
}
-(UIFont *) giveCellFontAndSize
{
    return self.cellDispTextPtr.textFontAndSize;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////
-(CGFloat) estimateCellheightAsheader
{
    
    //this is pixels
    int maxwidth=[GlobalCalcVals sharedGlobalCalcVals].tableCreatedWidth;
    int expectedLines= [self heightFromString:self.cellDispTextPtr.textStr withFont:self.cellDispTextPtr.textFontAndSize constraintToWidth:maxwidth];
    
    UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    
    //L A B E L
    //1  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //1  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    aLabel.textAlignment=NSTextAlignmentLeft;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    [aLabel setText: self.cellDispTextPtr.textStr];
    [aLabel setNumberOfLines: expectedLines];   //0];
    [aLabel sizeToFit];
    aLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    // aLabel.preferredMaxLayoutWidth=maxwidth;
    int padding=0;
    //  aLabel.frame=CGRectMake(padding, 0, maxwidth - (2 * padding) ,( aLabel.frame.size.height) * expectedLines);
    //  aLabel.frame=CGRectMake(padding, 0, maxwidth  ,( aLabel.frame.size.height) * expectedLines);
    
    NSLog(@"alabel rect %@ bounds %@", NSStringFromCGRect(aLabel.frame), NSStringFromCGRect(aLabel.bounds));
    aLabel.autoresizingMask=self.cellDispTextPtr.alignMe;
    // aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    //   aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin; //aligns right
    //  aLabel.autoresizingMask= UIViewAutoresizingFlexibleRightMargin; //aligns left
    padding=0;
    
    
    //  returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, aLabel.frame.size.width - (2 * padding) ,( aLabel.frame.size.height) * expectedLines)];
    UIView *returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, aLabel.frame.size.width - (2 * padding) ,( aLabel.frame.size.height) * expectedLines)];
    self.cellMaxHeight=returnedUIView.frame.size.height;
    returnedUIView=nil;
    
    return self.cellMaxHeight;   //this can't be 1,2,5, BUT   15 good
}
-(void) updateCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    [self.cellDispTextPtr updateDispTTextDefText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    
}

-(UIStackView *) makeMyComplexUIStackView:(UILayoutGuide *)masterViewLMG
{
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
 //T   UILabel *mlabel1 = [UILabel new];
 //T   mlabel1.text = @"Label 1";
 //T   mlabel1.backgroundColor = [UIColor redColor];
    
 //T   UILabel *mlabel2 = [UILabel new];
 //T   mlabel2.text = @"Label 2";
 //T   mlabel2.backgroundColor = [UIColor greenColor];
    
 //T   [labelsStack addArrangedSubview:mlabel1];
 //T   [labelsStack addArrangedSubview:mlabel2];
    
   // int expectedLines= [self heightFromString:self.cellDispTextPtr.textStr withFont:self.cellDispTextPtr.textFontAndSize constraintToWidth:maxwidth];
    UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    
    //L A B E L
  //frame  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
  //frame  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    aLabel.textAlignment=NSTextAlignmentLeft;
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    
    
    [aLabel setText: self.cellDispTextPtr.textStr];
    
  //  [aLabel setNumberOfLines: expectedLines];   //0];
    [aLabel setNumberOfLines:0];
   // [aLabel sizeToFit];
    
    aLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    // aLabel.preferredMaxLayoutWidth=maxwidth;
   // int padding=0;
    //  aLabel.frame=CGRectMake(padding, 0, maxwidth - (2 * padding) ,( aLabel.frame.size.height) * expectedLines);
  //  aLabel.frame=CGRectMake(padding, 0, maxwidth  ,( aLabel.frame.size.height) * expectedLines);
    
    NSLog(@"alabel rect %@ bounds %@", NSStringFromCGRect(aLabel.frame), NSStringFromCGRect(aLabel.bounds));
    aLabel.autoresizingMask=self.cellDispTextPtr.alignMe;
    // aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    //   aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin; //aligns right
    //  aLabel.autoresizingMask= UIViewAutoresizingFlexibleRightMargin; //aligns left
    
    

    [labelsStack addArrangedSubview:aLabel];
    
  //  [labelsStack.leftAnchor      constraintEqualToAnchor:masterViewLMG.leftAnchor].active = YES;
  //   [labelsStack.rightAnchor      constraintEqualToAnchor:masterViewLMG.rightAnchor].active = YES;

    
    
    
    /*   CALayer *aLayer = [CALayer layer];
     aLayer.frame=CGRectMake(0, 0, labelsStackW, labelsStackH); //MAKE SAME SIZE AS STACK    DON"T DO THIS.  CANT HAVE FRAME YET
     aLayer.backgroundColor = [[UIColor clearColor] CGColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
     aLayer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
     aLayer.borderWidth=5.0;
     aLayer.cornerRadius = 12.;
     [labelsStack.layer addSublayer:aLayer];
     */
    
    
    
    
    
    
    
    
    
    
    //lHOlderStack contains the labelsStack ONLY
    UIStackView *lHOlderStack = [[UIStackView alloc]init];
    lHOlderStack.axis=UILayoutConstraintAxisHorizontal;
    lHOlderStack.spacing=5;
    lHOlderStack.alignment=UIStackViewAlignmentCenter;
    lHOlderStack.distribution=UIStackViewDistributionFillEqually;
    lHOlderStack.translatesAutoresizingMaskIntoConstraints = false;
    
    /*  CALayer *bLayer = [CALayer layer];
     bLayer.frame=CGRectMake(0, 0, labelsStackW, labelsStackH); //MAKE SAME SIZE AS STACK
     bLayer.backgroundColor = [[UIColor blueColor] CGColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
     bLayer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
     bLayer.borderWidth=5.0;
     bLayer.cornerRadius = 12.;
     [lHOlderStack.layer addSublayer:bLayer];
     */
    
    [lHOlderStack addArrangedSubview:labelsStack];
    
    
    
    
    
    
    //twoStack contains uiimageview and lHolderStack
    UIStackView *twoStack = [[UIStackView alloc]init];
    twoStack.axis=UILayoutConstraintAxisHorizontal;
    twoStack.spacing=5;
    twoStack.alignment=UIStackViewAlignmentCenter;
    twoStack.distribution=UIStackViewDistributionFillEqually;
    twoStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    //DO in CALLING routine [tempBackView addSubview: twoStack];
    
    
    UIImageView *aUIImageView;//=[[UIImageView alloc]init];
    // U I I M A G E V I E W
    aUIImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; //actual size (ht) set by pic
    aUIImageView.hidden=false;
    aUIImageView.clipsToBounds = YES;  //frame
   //1 aUIImageView.layer.cornerRadius = 8.0;   //frame
   //1 aUIImageView.layer.borderWidth = 2.0;    //frame
   //1 aUIImageView.layer.borderColor = [UIColor blackColor].CGColor; //frame
    
    [aUIImageView setBackgroundColor:[UIColor clearColor]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buffy100x100" ofType:@"png"];
    UIImage * imageToShow = [UIImage imageWithContentsOfFile:filePath];
    [aUIImageView setImage:imageToShow];
    NSLog(@"aUIImageView frame %@",NSStringFromCGRect(aUIImageView.frame));
    
    
    aUIImageView.contentMode = UIViewContentModeCenter;
    
 
        aUIImageView.hidden=false; //test   - WORKS  labels stay aligned ?
    
    
    [twoStack addArrangedSubview:aUIImageView];
    [twoStack addArrangedSubview: lHOlderStack];
    
    
    
    //DO in CALLING routine    [twoStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    //DO in CALLING routine    [twoStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    return twoStack;

    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////

- (int)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)maxwidth
{
   
    //scan for \n or \r
    
    //int numberOfOccurences = [[text componentsSeparatedByString:@"\n"] count];
    int num = (int)[[text mutableCopy]  replaceOccurrencesOfString:@"\n" withString:@"X" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.05;
    
    NSDictionary* attributes = @{
                                 NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: style
                                 };
    
    
    
    CGSize expectedLabelSize = [text sizeWithAttributes:attributes];
    
    int expectedLines=ceil ( (expectedLabelSize.width+1) / maxwidth);
    if (expectedLines < 1) {
        expectedLines=1;
    }
    
    return expectedLines + num;
}
-(UIView *) WORKSforSINGLEline_putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight
{
    //return  UIView to display this stuff
    UIView* returnedUIView;
    int expectedLines= [self heightFromString:self.cellDispTextPtr.textStr withFont:self.cellDispTextPtr.textFontAndSize constraintToWidth:maxwidth];

    UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    
    //L A B E L
  //1  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
  //1  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    aLabel.textAlignment=NSTextAlignmentLeft;
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    [aLabel setText: self.cellDispTextPtr.textStr];
    [aLabel setNumberOfLines: expectedLines];   //0];
    [aLabel sizeToFit];
    aLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    // aLabel.preferredMaxLayoutWidth=maxwidth;
    int padding=0;
    //  aLabel.frame=CGRectMake(padding, 0, maxwidth - (2 * padding) ,( aLabel.frame.size.height) * expectedLines);
    //  aLabel.frame=CGRectMake(padding, 0, maxwidth  ,( aLabel.frame.size.height) * expectedLines);
    
    NSLog(@"alabel rect %@ bounds %@", NSStringFromCGRect(aLabel.frame), NSStringFromCGRect(aLabel.bounds));
    aLabel.autoresizingMask=self.cellDispTextPtr.alignMe;
    // aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    //   aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin; //aligns right
    //  aLabel.autoresizingMask= UIViewAutoresizingFlexibleRightMargin; //aligns left
    padding=10;
    
    
    //  returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, aLabel.frame.size.width - (2 * padding) ,( aLabel.frame.size.height) * expectedLines)];
    returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, aLabel.frame.size.width - (2 * padding) ,( aLabel.frame.size.height) * expectedLines)];
    returnedUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    returnedUIView.backgroundColor=[UIColor clearColor];
  //1 returnedUIView.layer.cornerRadius=8;
  //1  returnedUIView.layer.borderWidth=2.0;
  //1  returnedUIView.layer.borderColor=[UIColor redColor].CGColor;
    
    self.cellMaxHeight=aLabel.frame.size.height;
    [returnedUIView addSubview:aLabel];
    return returnedUIView;
}//dummy method to save
-(UIFont *) obtainMyFontForConstraintWidth:(int) maxwidth forString:(NSString*)myString
{
    UIFont *myNewFont=self.cellDispTextPtr.textFontAndSize;
    BOOL pointFound=FALSE;
    int minimumPoint=6;
    NSString *myFontLabel=self.cellDispTextPtr.textFontAndSize.fontName;
    int thisPoint=myNewFont.pointSize;
    int expectedLines;
    while (( thisPoint > minimumPoint) && (!pointFound)) {
         expectedLines= [self heightFromString:myString withFont:myNewFont constraintToWidth:maxwidth];
        if (expectedLines==1) {
            pointFound=TRUE;
        }
        else{
            thisPoint=thisPoint-2;
            myNewFont=[UIFont fontWithName:myFontLabel size:thisPoint];
        }
    }
    return myNewFont;    //if can't get less than one line with minimum font YOU MUST CLIP IT
    
    
    
    
    
}
-(UILabel *)buildSingleLineLabelMaxWidth:(int)maxwidth
{
    
    //REduce FONT size until fits in width provided
    
    UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    int padding=10;
    int expectedLines;
    UIFont *myNewFont;
    
    
    expectedLines= [self heightFromString:self.cellDispTextPtr.textStr withFont:self.cellDispTextPtr.textFontAndSize  constraintToWidth:maxwidth];
    if (expectedLines > 1) {   //if can't get less than one line with minimum font YOU MUST CLIP IT
        myNewFont=[self obtainMyFontForConstraintWidth:maxwidth forString:self.cellDispTextPtr.textStr];
        self.cellDispTextPtr.textFontAndSize=myNewFont;
    }
    
    //L A B E L
    // aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    // aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentRight;               //centers my text in my box
    aLabel.textAlignment=self.cellDispTextPtr.alignMe;
    
    
    
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    
    
    [aLabel setText: self.cellDispTextPtr.textStr];
    
    [aLabel setNumberOfLines: 1];   //0];
    
    
    aLabel.lineBreakMode = NSLineBreakByTruncatingTail;  //<<<<<<---------
     [aLabel sizeToFit];

    aLabel.frame=CGRectMake(padding, 0, maxwidth  , aLabel.frame.size.height);
    

    return aLabel;
    
}

-(UILabel *)buildMultiLineLabelMaxWidth:(int)maxwidth
{
    UILabel *aLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    //int padding=10;
    int expectedLines= [self heightFromString:self.cellDispTextPtr.textStr withFont:self.cellDispTextPtr.textFontAndSize constraintToWidth:maxwidth];
    //L A B E L
    // aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    // aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    aLabel.textAlignment=self.cellDispTextPtr.alignMe;
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    
    
    [aLabel setText: self.cellDispTextPtr.textStr];
    
    [aLabel setNumberOfLines: expectedLines];   //0];
    
    [aLabel sizeToFit];
    
    aLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    
   //aLabel.frame=CGRectMake(padding, 0, maxwidth  ,( aLabel.frame.size.height) * expectedLines);
    aLabel.frame=CGRectMake(0, 0, maxwidth  ,( aLabel.frame.size.height) * expectedLines);
    
    // NSLog(@"alabel rect %@ bounds %@", NSStringFromCGRect(aLabel.frame), NSStringFromCGRect(aLabel.bounds));
   
    switch (self.cellDispTextPtr.alignMe) {
        case NSTextAlignmentLeft:
            aLabel.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
            break;
        case NSTextAlignmentRight:
            aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
            break;
        default: //center NSTextAlignmentCenter
            aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            aLabel.textAlignment=NSTextAlignmentCenter;
            break;
    }
    
    
    // aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; //aligns center
    //   aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin; //aligns right
    //  aLabel.autoresizingMask= UIViewAutoresizingFlexibleRightMargin; //aligns left
    return aLabel;

}

-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    //return  UIView to display this stuff
    UIView* returnedUIView;
   
    UILabel *aLabel=[self buildMultiLineLabelMaxWidth:maxwidth-10];
    
    

    
    
   // returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, aLabel.frame.size.width - (2 * padding) , aLabel.frame.size.height) ];
    returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, aLabel.frame.size.width  , aLabel.frame.size.height) ];
    returnedUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    returnedUIView.backgroundColor=self.cellDispTextPtr.backgoundColor;
   // returnedUIView.layer.cornerRadius=8;
   // returnedUIView.layer.borderWidth=2.0;
   // returnedUIView.layer.borderColor=[UIColor redColor].CGColor;
    
    self.cellMaxHeight=aLabel.frame.size.height;
    
    [returnedUIView addSubview:aLabel];
    return returnedUIView;
}
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
   // NSLog(@"CELLTEXTDEF str: %@ ht:%f",self.cellDispTextPtr.textStr,self.cellMaxHeight);
    
    if (!self.cellMaxHeight) {
        
        self.cellMaxHeight=[self estimateCellheightAsheader];
        
    }
    
    
    return self.cellMaxHeight;
}

-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    
    int maxwidth=[GlobalCalcVals sharedGlobalCalcVals].tableCreatedWidth;//?tvcellPtr.frame.size.width;
    
    UILabel *aLabel=[self buildMultiLineLabelMaxWidth:maxwidth-10];
    self.cellMaxHeight=aLabel.frame.size.height;
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    [tvcellPtr.contentView addSubview:aLabel];
    
    
    
    //for separator too
    UIView * additionalSeparator;
    // works
    int htOfSeparator=2;
    if (cellSeparatorVisible) {
        additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,aLabel.frame.size.height,maxW,htOfSeparator)];
        additionalSeparator.backgroundColor = TK_TEXTCELL_SEPARATOR_COLOR;
        [tvcellPtr.contentView addSubview:additionalSeparator];
        self.cellMaxHeight=self.cellMaxHeight+htOfSeparator;

    }
    
    
    
    
   // tvcellPtr.textLabel=[self buildMultiLineLabelMaxWidth:maxwidth];
    
    return;
    
  
    /*
    UILayoutGuide *masterViewLMG=tvcPtr.contentView.layoutMarginsGuide;
    [tvcPtr.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];

    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentLeading;    //UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    // labelsStack.baselineRelativeArrangement=true;//?makes blury
     labelsStack.layoutMarginsRelativeArrangement=true;//?
    
    //A     L A B E L
    //frame  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //frame  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    aLabel.textAlignment=NSTextAlignmentCenter;//NSTextAlignmentLeft;
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    
    
    //B     L A B E L
    //frame  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //frame  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    UILabel *bLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    bLabel.textAlignment=NSTextAlignmentCenter;//NSTextAlignmentLeft;
    bLabel.textColor = self.cellDispTextPtr.textColor;
    bLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    bLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    bLabel.text = self.cellDispTextPtr.textStr;
    
    //C     L A B E L
    //frame  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //frame  aLabel.layer.borderWidth = 3.0;
    // aLabel.textAlignment=NSTextAlignmentCenter;               //centers my text in my box
    UILabel *cLabel= [[UILabel alloc] initWithFrame:CGRectZero];
    cLabel.textAlignment=NSTextAlignmentCenter;//NSTextAlignmentLeft;
    cLabel.textColor = self.cellDispTextPtr.textColor;
    cLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    cLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    cLabel.text = self.cellDispTextPtr.textStr;

    
    
    
     [labelsStack addArrangedSubview:aLabel];
     [labelsStack addArrangedSubview:bLabel];
     [labelsStack addArrangedSubview:cLabel];
    
    
    [tvcPtr.contentView addSubview:labelsStack];
    UILayoutGuide *labelstackLMG=labelsStack.layoutMarginsGuide;
    */
    // [complexStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    /*NSLayoutXAxisAnchor:
     tempBackView.centerXAnchor
     tempBackView.trailingAnchor
     tempBackView.rightAnchor
     tempBackView.leftAnchor
     tempBackView.leadingAnchor */
    /*NSLayoutYAxisAnchor
     tempBackView.centerYAnchor
     tempBackView.firstBaselineAnchor
     tempBackView.lastBaselineAnchor
     tempBackView.topAnchor
     tempBackView.bottomAnchor
     */
    
 //   [masterViewLMG.leadingAnchor      constraintEqualToAnchor:labelstackLMG.leadingAnchor].active = YES;
 //   [masterViewLMG.bottomAnchor      constraintGreaterThanOrEqualToAnchor:labelstackLMG.bottomAnchor].active = YES;
    
    
    
 

   
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
