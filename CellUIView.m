//
//  CellUIView.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellUIView.h"
#import "GlobalTableProto.h"

#import "CellButtonsScroll.h"
@implementation CellUIView

@synthesize backgoundColor;


@synthesize cioPtrArr; //only using element 0
@synthesize displayTemplate;//image on left or on right if it exists

@synthesize cTextDefsArray,displaycTextDefsAlign;

@synthesize templateUIView,imageUIView,labelsUIView,buttonsUIView,templateASideView;

@synthesize posBottomRect,posLeftRect,posRightRect,posTopRect,posTemplateContainerRect;
@synthesize cButtonsArray; //only using element 0


@synthesize cInputFieldsArray,inputFieldsUIView;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    
    backgoundColor=nil;
    templateUIView=nil;
    imageUIView=nil;
    labelsUIView=nil;
    buttonsUIView=nil;
    templateASideView=nil;
    inputFieldsUIView=nil;
    
    for (int i=0; i<[self.cioPtrArr count]; i++) {
        [[self.cioPtrArr objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
    }
    cioPtrArr=nil;
    
    for (int i=0; i<[self.cButtonsArray count]; i++) {
        [[self.cButtonsArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
    }
    cButtonsArray=nil;
    
    for (int i=0; i<[self.cTextDefsArray count]; i++) {
        [[self.cTextDefsArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
    }
    cTextDefsArray=nil;
    
    for (int i=0; i<[self.cInputFieldsArray count]; i++) {
        [[self.cInputFieldsArray objectAtIndex:i] killYourself];    //array contents kill yourself....  if its an object
    }
    cInputFieldsArray=nil;
    posTopRect=CGRectZero;
    posBottomRect=CGRectZero;
    posLeftRect=CGRectZero;
    posRightRect=CGRectZero;
    posTemplateContainerRect=CGRectZero;
    
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellUIView *)nCell
{
    nCell.enableUserActivity=TRUE;
    nCell.cellclassType=CELLCLASS_UIVIEW;
    backgoundColor= TK_TRANSPARENT_COLOR;


    templateUIView=[[UIView alloc]initWithFrame:CGRectZero];
    templateUIView.backgroundColor=TK_TRANSPARENT_COLOR; //063016
    // nCell.cellMaxHeight=DEF_CELLHEIGHT;   //sections won't display without some non 0 value here
    nCell.cellMaxHeight=templateUIView.frame.size.height;
    
    nCell.cioPtrArr=[[NSMutableArray alloc]init];
    nCell.cTextDefsArray=[[NSMutableArray alloc]init];
    nCell.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;  //array of labels aligned horizontally or vertically
    
    nCell.cButtonsArray=[[NSMutableArray alloc]init];
    nCell.cInputFieldsArray=[[NSMutableArray alloc]init];
    nCell.posTopRect=CGRectZero;
    nCell.posBottomRect=CGRectZero;
    nCell.posLeftRect=CGRectZero;
    nCell.posRightRect=CGRectZero;
    nCell.posTemplateContainerRect=CGRectZero;
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Exposed Initialization
/////////////////////////////////////////
+(CellUIView *)mkcuvImageLeft:(UIImage*)theImage withImageName:(NSString *)imName andImageSize:(CGSize)imsize andTextsArrayRight:(NSMutableArray*)labelsArray useTextSizeTopCell:(int)topTextSize useTextSizeAdditionalCells:(int)textSize withBackGroundColor:(UIColor*)backClr withTextColor:(UIColor*)textClr
{
    CellUIView*ctdPtr=[[CellUIView alloc]init];    //calls makeUseDefaults
    ctdPtr.backgoundColor=backClr;
   // ctdPtr.templateUIView.backgroundColor=backClr;
    
    
 
    ctdPtr.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    ctdPtr.displayTemplate=kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT; //kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT

   
    CellImageOnly *cioPtr=[[CellImageOnly alloc]init];
    [cioPtr updateCellImage:theImage withPNGName:imName withBackColor:backClr rotateWhenVisible:NO withSize:imsize];
    [ctdPtr.cioPtrArr addObject:cioPtr];
    
    
    
    NSString *labString;
    labString=[labelsArray objectAtIndex:0];
    CellTextDef *firstLabelPtr=  [CellTextDef initCellText:labString withTextColor:textClr withBackgroundColor:backClr withTextFontSize:topTextSize withTextFontName:nil];
    firstLabelPtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
    [ctdPtr.cTextDefsArray addObject:firstLabelPtr];
    
    
    for (int index=1; index < [labelsArray count]; index++) {
        labString=[labelsArray objectAtIndex:index];
        CellTextDef *additonalLabelPtr=  [CellTextDef initCellText:labString withTextColor:textClr withBackgroundColor:backClr withTextFontSize:textSize withTextFontName:nil];
        additonalLabelPtr.cellDispTextPtr.alignMe=NSTextAlignmentLeft;
        [ctdPtr.cTextDefsArray addObject:additonalLabelPtr];
    }
    
    
    
    
    return ctdPtr;

}
+ (id )initCellDefaults
{
    CellUIView* nCell=[[CellUIView alloc]init];    //calls makeUseDefaults
    
    return nCell;
    
}



+ (id)initCellInUIViewWithCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName andViewBackColor:(UIColor *)viewBackColor

{
    
    CellUIView* nCell=[[CellUIView alloc]init];    //calls makeUseDefaults
    nCell.backgoundColor=viewBackColor;
    
    
    CellTextDef *ctdptr=[CellTextDef initCellText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    
    nCell.displaycTextDefsAlign=kDISP_ALIGN_VERTICAL;
    [nCell.cTextDefsArray addObject:ctdptr];
    
    
    
    
    
    return nCell;
}
-(void) addALabelCellToArray:(CellTextDef *) ctdPtr
{
    [self.cTextDefsArray addObject: ctdPtr];
}
-(void) replaceTheImageCell:(CellImageOnly *)cimageOnlyPtr
{
    [self.cioPtrArr addObject: cimageOnlyPtr];
}
-(void) changeDisplayTemplate:(int)whichTemplate
{
    self.displayTemplate=whichTemplate;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellBackColor
{
    return self.backgoundColor;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark  helper
//////////////////
- (int)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)maxwidth
{
    CGSize expectedLabelSize = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    
    int expectedLines=ceil ( (expectedLabelSize.width+1) / maxwidth);
    if (expectedLines < 1) {
        expectedLines=1;
    }
    return expectedLines;
}

-(UIStackView *) makeSimpleStackView
{
    
    
    
    
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
    
    // UILabel *mlabel1 = [self makeALabelSimpleString:@"simple 1"];

   // UILabel *mlabel2 = [self makeALabelSimpleString:@"simple 2"];
   // [labelsStack addArrangedSubview:mlabel1];
    //[labelsStack addArrangedSubview:mlabel2];
    
    
    
    return labelsStack;
    
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark POSITIONING Methods
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
//-(UIView *) createUIViewWithButtonsDefinedMaxWidth:(int)maxW andMaxHeight:(int)maxH
-(UIScrollView *) createUIViewWithButtonsDefinedMaxWidth:(int)maxW andMaxHeight:(int)maxH
{
//    UIView* returnedUIView;
    UIScrollView *returnedUIView;
    
    CellButtonsScroll *cbutPtr=[self.cButtonsArray objectAtIndex:0];
    
    returnedUIView = nil;
    if (!cbutPtr) {
        return nil;
    }
//    cbutPtr.buttonViewScrolls=YES;
    returnedUIView=(UIScrollView*) [cbutPtr putMeVisibleMaxWidth:maxW maxHeight:maxH withTVC:nil];  //DAN, I BET THE nil IS A PROBLEM
    
    
    return returnedUIView;
}
-(UIView *) createUIViewWithAnyImageDefined
{
    //return  UIView to display contained cIOPtr
    //maxW must be passed leaving room for textLabelArray if needed  (defined by template type)
    
    UIView* returnedUIView;//=[[UIView alloc]initWithFrame:CGRectZero];
    returnedUIView.backgroundColor=self.backgoundColor;
    UIImageView *aUIImageView;//=[[UIImageView alloc]init];
    // UILabel *aLabel;
    
    //L A B E L
    //  aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //  aLabel.layer.borderWidth = 3.0;
    
    // U I I M A G E V I E W
    aUIImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; //actual size (ht) set by pic
    aUIImageView.clipsToBounds = YES;
    aUIImageView.backgroundColor=self.backgoundColor;
    
    if ([self.cioPtrArr count]<1) {
        return nil;
    }
    CellImageOnly *cioPtr=[self.cioPtrArr objectAtIndex:0];
    if (!cioPtr) {
        return  nil;
    }
    
    
    
    
    
    
    // aUIImageView.layer.cornerRadius = 8.0;
    // aUIImageView.layer.borderWidth = 2.0;
    // aUIImageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    [aUIImageView setImage:cioPtr.myImage];
    
    
  //  CGSize imageSize=cioPtr.myImage.size;
    
    aUIImageView.frame = CGRectMake(0, 0, cioPtr.myImage.size.width, cioPtr.myImage.size.height );
    aUIImageView.contentMode = UIViewContentModeScaleAspectFit;
    int padding=0;
    returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, aUIImageView.frame.size.width - (2 * padding) , aUIImageView.frame.size.height)];
    returnedUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    returnedUIView.backgroundColor=[UIColor clearColor];
    //? returnedUIView.frame=aUIImageView.frame;
    
    
    returnedUIView.backgroundColor= self.backgoundColor;// [UIColor greenColor];
    // returnedUIView.layer.cornerRadius=8;
    //  returnedUIView.layer.borderWidth=2.0;
    //  returnedUIView.layer.borderColor=[UIColor redColor].CGColor;
    
    
    
    
    [returnedUIView addSubview:aUIImageView];
    NSLog(@"uiview containing image %@",NSStringFromCGRect(returnedUIView.frame));
    return returnedUIView;
    
}
-(UIView *)createUIViewWithAnyInputFieldsMaxWidth:(int)maxW
{
    if ([self.cInputFieldsArray count] < 1) {
        return nil;
    }
    UIView* returnedUIView=[[UIView alloc]init];
    
    
    int padding=2;
    
    

    CellTextDef *emptyLeftSide=[CellTextDef initCellText:@" " withTextColor:[UIColor clearColor] withBackgroundColor:[UIColor clearColor] withTextFontSize:2 withTextFontName:nil];
    
    NSMutableArray *allUITextFields=[[NSMutableArray alloc]init];
    NSMutableArray *allUITextLabs=[[NSMutableArray alloc]init];
    
    CellInputField *cifPtr;
    UITextField *aUITextFPtr;
    UILabel *aLabel;
 
    int madeUpFieldWidth=abs(maxW * 1/2);
    int tLabelW= abs(  maxW-madeUpFieldWidth-padding-padding-padding);
    int tLabelH=0;
    int tFieldW=madeUpFieldWidth;
    int tFieldH=0;
    
    
    
    
    CGSize sizeToEstimate1LineHeight;
    
    UIFont *estimationFont;
    //  U I T E X T F I E L D
    
   
    //BUILD two arrays,
    tFieldW=madeUpFieldWidth;
    for (int litem=0; litem<[self.cInputFieldsArray count]; litem++) {
        
        cifPtr=[self.cInputFieldsArray objectAtIndex:litem];
        aUITextFPtr=[cifPtr buildUITextFieldANDsetKey];      //B U I L D, frame will be 0 width  0 height
        
        
        
        if (litem==0) {  //set arbitrary height first time through
            if (cifPtr.leftSideDispTextPtr) {
                estimationFont=cifPtr.leftSideDispTextPtr.cellDispTextPtr.textFontAndSize;
            }
            else{
                estimationFont=cifPtr.placeholderTextDefPtr.cellDispTextPtr.textFontAndSize;
            }
            sizeToEstimate1LineHeight=[self estimateYourWidth:@"hi" withFont:estimationFont];
            tFieldH=sizeToEstimate1LineHeight.height;
            tLabelH=tFieldH;
        }
        
        aUITextFPtr.frame=CGRectMake(0, 0, tFieldW, tFieldH);
        [allUITextFields addObject:aUITextFPtr];
        
        
      //  NSString *bothString;
       
        
        
        if (cifPtr.leftSideDispTextPtr) {
            aLabel=[cifPtr.leftSideDispTextPtr buildSingleLineLabelMaxWidth:tLabelW];    //will truncate on display if too long.
            
          //  if (cifPtr.placeholderTextDefPtr) {
                //both left and right contents
                
           //     bothString=[NSString stringWithFormat:@"%@ %@",cifPtr.leftSideDispTextPtr.cellDispTextPtr.textStr,cifPtr.placeholderTextDefPtr.cellDispTextPtr.textStr];
          //      aLabel.text=bothString;
 
          //  }
            
        }
        else{
            //NEED EMPTY label for spacekeeper
            aLabel=[emptyLeftSide buildSingleLineLabelMaxWidth:tLabelW];    //will truncate on display if too long. real W not known yet
        }
        aLabel.frame=CGRectMake(0, 0, tLabelW, tLabelH);
        [allUITextLabs addObject:aLabel];
        
    }
    
    
 
    
    
    
    //put all in UIView
    
    
  
    
    int allCenterIFieldW=abs(maxW-(tFieldW/2)-2);   //field always on right
    int allCenterLabelW=abs(maxW-tFieldW-2-2-(tLabelW/2));//text if exists if left right justified with two spaces to hit InputField
    
    
    
    CGFloat previousHeight=2.0;//spacer
    UIView *loopUIView;
    switch (self.displaycTextDefsAlign) {
        case kDISP_ALIGN_HORIZONTAL:
            //figure this out
        case kDISP_ALIGN_VERTICAL:
        default:
            for (int litem=0; litem<[self.cInputFieldsArray count]; litem++) {
                cifPtr= [cInputFieldsArray objectAtIndex:litem];
                aLabel= [allUITextLabs objectAtIndex:litem];
                aLabel.center=CGPointMake(allCenterLabelW,fabs(previousHeight+(tLabelH/2)));

                loopUIView=[cifPtr putMeVisibleMaxWidth:maxW maxHeight:previousHeight withTVC:nil];
                            
                previousHeight=previousHeight+aLabel.frame.size.height + 2;
                [returnedUIView addSubview:loopUIView];
             /*
                aLabel= [allUITextLabs objectAtIndex:litem];
                aLabel.center=CGPointMake(allCenterLabelW,fabs(previousHeight+(tLabelH/2)));
                [returnedUIView addSubview:aLabel];
                
                aUITextFPtr= [allUITextFields objectAtIndex:litem];
                aUITextFPtr.center=CGPointMake( allCenterIFieldW,fabs(previousHeight+(tFieldH/2)));
                [returnedUIView addSubview:aUITextFPtr];
                
                previousHeight=previousHeight+aLabel.frame.size.height + 2;
                
                
                NSLog(@"InputField %@",NSStringFromCGRect(aUITextFPtr.frame));
                NSLog(@"    ALabel %@",NSStringFromCGRect(aLabel.frame));
              */
                
                
                
                
            }
            
            returnedUIView.frame=CGRectMake(0, 0, maxW, ceil( previousHeight)+1);
            
            
            
            break;
            
    }
    
    NSLog(@"ALLinputfields %@",NSStringFromCGRect(returnedUIView.frame));
    
    
    return returnedUIView;

}
-(UIView *) createUIViewWithAnyLabelsDefinedMaxWidth:(int)maxW
{
    //return  UIView to display this stuff
    
    if ([self.cTextDefsArray count] < 1) {
        return nil;
    }
    UIView* returnedUIView=[[UIView alloc]init];
    
    
    CellTextDef *ctdPtr;
    int padding=0;//2;
    
    
    NSMutableArray *madelabelsArr=[[NSMutableArray alloc]init]; //needed?
    
    CGFloat totalLabelsWidth=0.0;
    CGFloat totalLabelsHeight=0.0;
    
    
    
    int htOfSeparator=2;
    
    for (int litem=0; litem<[self.cTextDefsArray count]; litem++) {
       
        
        
        // UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
        ctdPtr=[self.cTextDefsArray objectAtIndex:litem];
        
        UILabel *aLabel=[ctdPtr buildMultiLineLabelMaxWidth:maxW]; ;
         totalLabelsHeight=totalLabelsHeight+aLabel.frame.size.height;
        totalLabelsWidth=totalLabelsWidth + aLabel.frame.size.width;
        if (!ctdPtr.cellSeparatorVisible){
            [madelabelsArr addObject: aLabel];
        }else{
 //       if (ctdPtr.cellSeparatorVisible) {
            UIView *additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,aLabel.frame.size.height,aLabel.frame.size.width,htOfSeparator)];
            additionalSeparator.backgroundColor = TK_TEXTCELL_SEPARATOR_COLOR;
            [madelabelsArr addObject:additionalSeparator];
            totalLabelsHeight=totalLabelsHeight+htOfSeparator;
            [madelabelsArr addObject: aLabel];
        }
        
        
        
    }
    
    CGFloat previousHeight=0.0;
    
    switch (self.displaycTextDefsAlign) {
        case kDISP_ALIGN_HORIZONTAL:
            //figure this out
        case kDISP_ALIGN_VERTICAL:
        default:
            
            
            for (int item=0; item<[madelabelsArr count]; item++) {
                UILabel *aLabel =[madelabelsArr objectAtIndex:item];
                
                aLabel.frame=CGRectMake(padding, previousHeight, aLabel.frame.size.width-padding*2, aLabel.frame.size.height);
                
                
                [returnedUIView addSubview:aLabel];
                previousHeight=previousHeight+aLabel.frame.size.height;
                
               // NSLog(@"thisLabel vertical %d: %@",item,NSStringFromCGRect(aLabel.frame));
                
                NSLog(@"");
                
            }
            
           //WAS returnedUIView.frame=CGRectMake(0, 0, maxW, ceil( previousHeight)+1);
            returnedUIView.frame=CGRectMake(0, 0, maxW,  previousHeight); //mah 070616
            
            
            
            break;
            
    }
    
   // NSLog(@"ALLlabels %@",NSStringFromCGRect(returnedUIView.frame));
    
    returnedUIView.backgroundColor=self.backgoundColor;
    return returnedUIView;
    
}


-(UIView *) assignUIViewTop:(UIView *)myTopViewPtr andUIViewBottom:(UIView *)myBotViewPtr fixedWidth:(CGFloat)fixedWidth
{
    
    //CLEAR previous settings
    posTopRect=CGRectZero;
    posBottomRect=CGRectZero;
    posLeftRect=CGRectZero;
    posRightRect=CGRectZero;
    posTemplateContainerRect=CGRectZero;
    
    CGFloat bottomHeight;
    CGFloat topHeight;
    CGFloat allowTotalHeight=0.0;
    CGFloat offset=20.0;
    CGFloat allowTotalWidth=0.0;
    
    CGFloat realTopWidth=0.0;
    CGFloat realBottomWidth=0.0;
    
    
    
    
    if (!myBotViewPtr) {
        offset=0;//2;//only a topView  like a many texts view
    }
    
    topHeight=myTopViewPtr.frame.size.height;
    bottomHeight=myBotViewPtr.frame.size.height;
    
    realBottomWidth=myBotViewPtr.frame.size.width;
    realTopWidth=myTopViewPtr.frame.size.width;
    
    
    
    
    
    
    
    //Figure out rectangles = center toprect and bottom rect?
    CGFloat x_soTopRectCentered=0.0;
    CGFloat x_soBottomRectCentered=0.0;
    
    
    
    x_soTopRectCentered=fabs( fixedWidth/2 - realTopWidth/2);   //woffset not considered
    x_soBottomRectCentered=fabs( fixedWidth/2 - realBottomWidth/2);   //woffset not considered
    
    posTopRect=CGRectMake(x_soTopRectCentered,
                          offset,
                          realTopWidth,
                          topHeight);
    
    posBottomRect=CGRectMake(x_soBottomRectCentered, topHeight +  offset,// +offset,
                             realBottomWidth,
                             bottomHeight);
    
   // allowTotalHeight=topHeight+bottomHeight+(offset*2);
    allowTotalHeight=topHeight+bottomHeight+(offset);
    
    allowTotalWidth=fixedWidth;
    
    posTemplateContainerRect=CGRectMake(0, 0, allowTotalWidth, allowTotalHeight);
    
    
    
    
    //ASSIGN
    myTopViewPtr.frame=self.posTopRect;
    myBotViewPtr.frame=self.posBottomRect;
    
    
    //MAKE FINAL 1 VIEW OF THE SIZED TOP and BOT Views
    
    UIView *newUIView=[[UIView alloc]initWithFrame:self.posTemplateContainerRect];
    newUIView.backgroundColor=self.backgoundColor;//[UIColor clearColor];//063016
    if (myTopViewPtr) {
        [newUIView addSubview:myTopViewPtr];
    }
    if (myBotViewPtr) {
        [newUIView addSubview:myBotViewPtr];
    }
    
    
    // UIView *dummyColorView=[[UIView alloc]initWithFrame:self.imageUIView.frame];
    // UIView *dummyColorView=[[UIView alloc]initWithFrame:self.labelsUIView.frame];
    // dummyColorView.backgroundColor=[UIColor orangeColor];
    // [self.templateUIView addSubview:dummyColorView];
    
    return newUIView;
    
    
    
    
    
    
}
-(UIView *) assignUIViewLeft:(UIView *)myLeftViewPtr andUIViewRight:(UIView *)myRightViewPtr fixedWidth:(CGFloat)fixedWidth

{  //return total height, set posTemplateContainerRect, posLeftRect, posRightRect
    
    //CLEAR previous settings
    posTopRect=CGRectZero;
    posBottomRect=CGRectZero;
    posLeftRect=CGRectZero;
    posRightRect=CGRectZero;
    
    CGFloat leftHeight;
    CGFloat rightHeight;
    CGFloat leftWidth;
    CGFloat rightWidth;
    CGFloat allowTotalHeight=0.0;
    CGFloat allowTotalWidth=0.0;
    CGFloat offset=0.0;
    
    
    
    
    leftWidth=myLeftViewPtr.frame.size.width;
    leftHeight=myLeftViewPtr.frame.size.height;
    
    rightWidth=myRightViewPtr.frame.size.width;
    rightHeight=myRightViewPtr.frame.size.height;
    
    
    if (leftHeight > rightHeight) {
        allowTotalHeight=leftHeight+offset;
    }
    else{
        allowTotalHeight=rightHeight+offset;
    }
    
    
    
    //Figure out rectangles
    allowTotalWidth=fixedWidth;
    CGFloat y_soLeftRectCentered=0.0;
    CGFloat y_soRightRectCentered=0.0;
    
    
    y_soLeftRectCentered=fabs(allowTotalHeight/2-leftHeight/2);
    y_soRightRectCentered=fabs(allowTotalHeight/2- rightHeight/2);
    
    
    posLeftRect=CGRectMake(0, y_soLeftRectCentered, leftWidth, leftHeight);
    
    posRightRect=CGRectMake(leftWidth, y_soRightRectCentered, rightWidth, rightHeight);
    
    posTemplateContainerRect=CGRectMake(0, 0, allowTotalWidth, allowTotalHeight);
    
    
    
    
    
    
    //ASSIGN RESULTS to FRAMES
    myLeftViewPtr.frame=self.posLeftRect;
    myRightViewPtr.frame=self.posRightRect;
    
    
    //PUT IN VIEW withRESULTS
    
    UIView *newUIView=[[UIView alloc]initWithFrame:self.posTemplateContainerRect];
    newUIView.backgroundColor=self.backgoundColor;//[UIColor clearColor];//063016
    if (myLeftViewPtr) {
        [newUIView addSubview:myLeftViewPtr];
    }
    if (myRightViewPtr) {
        [newUIView addSubview:myRightViewPtr];
    }
    
    
    return newUIView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    
    int answerInt=self.cellMaxHeight;
   // int totals=0.0;
    CellImageOnly *cioptr;
    if (!answerInt) {
        //being asked before drawn....have to estimate
        switch (self.displayTemplate) {
            case kDISP_TEMPLATE_LABELS_ONLY:
                answerInt=(int) [self.cTextDefsArray count]*24;
                
                
                break;
                
            case kDISP_TEMPLATE_INPUTFIELDS_ONLY:
                break;
            case kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP:
            case kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSTOP_LABELBOTTOM:
            
            case kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT:
            case kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT:
                
            case kDISP_TEMPLATE_BUTTONSLEFT_LABLESRIGHT:
            case kDISP_TEMPLATE_BUTTONSRIGHT_LABLESLEFT:
                
            case kDISP_TEMPLATE_BUTTONSLEFT_IMAGERIGHT:
            case kDISP_TEMPLATE_BUTTONSRIGHT_IMAGELEFT:
                
            case kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM:
             case kDISP_TEMPLATE_IMAGEBOTTOM_LABELSTOP:
            case kDISP_TEMPLATE_BUTTONSTOP_LABLESBOTTOM:
             case kDISP_TEMPLATE_BUTTONSBOTTOM_LABLESTOP:
                
             case kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM:
             case kDISP_TEMPLATE_BUTTONSBOTTOM_IMAGETOP:
                answerInt=0;
                if ([cioPtrArr count] ) {
                    cioptr=[cioPtrArr objectAtIndex:0];
                    answerInt=cioptr.imageSize.height;
                }
                
                NSLog(@"");
                
                break;
            default:
                answerInt=0;
                break;

        }//end type of template
    }//end if estimating
    
    
    
    return answerInt;
}


-(void) defineTemplateUIViewforMaxWidth:(int)maxW maxHeight:(int)maxH
{
   
    CGFloat maxWsubset=maxW;
    
    
    self.imageUIView=nil;
    self.buttonsUIView=nil;
    self.labelsUIView=nil;
    self.templateUIView=nil;
    self.templateASideView=nil;
    self.inputFieldsUIView=nil;
    
    
    
    
    
    
    switch (self.displayTemplate) {
        case kDISP_TEMPLATE_INPUTFIELDS_ONLY:
            
            self.inputFieldsUIView=[self createUIViewWithAnyInputFieldsMaxWidth:maxW];
            
            
            self.templateUIView=[self assignUIViewTop:self.inputFieldsUIView andUIViewBottom:nil fixedWidth:maxW] ;
            self.cellMaxHeight=self.templateUIView.frame.size.height;

            break;
        case kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP:
            //special  image always on left
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxWsubset];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxWsubset andMaxHeight:maxH];
            
            //make sub to contain button&label
            self.templateASideView=[self assignUIViewTop:self.labelsUIView andUIViewBottom:self.buttonsUIView fixedWidth:maxWsubset];
            self.templateUIView=[self assignUIViewLeft:self.imageUIView andUIViewRight:self.templateASideView fixedWidth:maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
        case kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSTOP_LABELBOTTOM:
            //special  image always on left
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxWsubset];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxWsubset andMaxHeight:maxH];
            
            //make sub to contain button&label
            self.templateASideView=[self assignUIViewTop:self.buttonsUIView andUIViewBottom:self.labelsUIView fixedWidth:maxWsubset];
            self.templateUIView=[self assignUIViewLeft:self.imageUIView andUIViewRight:self.templateASideView fixedWidth:maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            
            break;
        case kDISP_TEMPLATE_LABELS_ONLY:
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW];
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;
            self.templateUIView=[self assignUIViewTop:self.labelsUIView andUIViewBottom:nil fixedWidth:maxW] ;
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            
            break;
        case kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT:
            
            //setMaxW after find out image width
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxWsubset];
            
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.labelsUIView andUIViewRight:self.imageUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            break;
            
        case kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT:
            
            //setMaxW after find out image width
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxWsubset];
            
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.imageUIView andUIViewRight:self.labelsUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            break;
            
        case kDISP_TEMPLATE_BUTTONSLEFT_LABLESRIGHT:
            //setMaxW after find out image width
            
            //????   maxWforLabels=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW/2];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW/2 andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.buttonsUIView andUIViewRight:self.labelsUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            
            break;
        case kDISP_TEMPLATE_BUTTONSRIGHT_LABLESLEFT:
            //setMaxW after find out image width
            
            //????   maxWforLabels=maxW - self.imageUIView.frame.size.width;
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW/2];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW/2 andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.labelsUIView andUIViewRight:self.buttonsUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            
            break;
        case kDISP_TEMPLATE_BUTTONSLEFT_IMAGERIGHT:
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxWsubset andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.buttonsUIView andUIViewRight:self.imageUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
        case kDISP_TEMPLATE_BUTTONSRIGHT_IMAGELEFT:
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            maxWsubset=maxW - self.imageUIView.frame.size.width;
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxWsubset andMaxHeight:maxH];
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_LeftRight_FixedWidth: maxW];
            self.templateUIView=[self assignUIViewLeft:self.imageUIView andUIViewRight:self.buttonsUIView fixedWidth: maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
        case kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM:

            self.imageUIView=[self createUIViewWithAnyImageDefined];
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW];
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.imageUIView andUIViewBottom:self.labelsUIView fixedWidth:maxW];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
            
        case kDISP_TEMPLATE_IMAGEBOTTOM_LABELSTOP:
            
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW];
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.labelsUIView andUIViewBottom:self.imageUIView fixedWidth:maxW  ];
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
            
            
            
            
        case kDISP_TEMPLATE_BUTTONSTOP_LABLESBOTTOM:
            
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.buttonsUIView andUIViewBottom:self.labelsUIView fixedWidth: maxW] ;//+ 20;
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            break;
            
        case kDISP_TEMPLATE_BUTTONSBOTTOM_LABLESTOP:
            
            self.labelsUIView=[self createUIViewWithAnyLabelsDefinedMaxWidth:maxW];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.labelsUIView andUIViewBottom:self.buttonsUIView fixedWidth: maxW] ;//+ 20;
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            break;
        case kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM:
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.buttonsUIView andUIViewBottom:self.imageUIView fixedWidth: maxW] ;//+ 20;
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
        case kDISP_TEMPLATE_BUTTONSBOTTOM_IMAGETOP:
            self.imageUIView=[self createUIViewWithAnyImageDefined];
            self.buttonsUIView=[self createUIViewWithButtonsDefinedMaxWidth:maxW andMaxHeight:maxH];
            
            //self.templateUIView=[self assigneAndPositionTemplateUIViews_TopBottom_FixedWidth:maxW] ;//+ 20;
            self.templateUIView=[self assignUIViewTop:self.imageUIView andUIViewBottom:self.buttonsUIView fixedWidth: maxW] ;//+ 20;
            self.cellMaxHeight=self.templateUIView.frame.size.height;
            
            break;
            
            
            
        default://show nothing?
            posTopRect=CGRectZero;
            posBottomRect=CGRectZero;
            posLeftRect=CGRectZero;
            posRightRect=CGRectZero;
            
            
            break;
    }
    
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    
    
    
    [self defineTemplateUIViewforMaxWidth:maxW maxHeight:maxH];

   // tvcellPtr.contentView.backgroundColor=[UIColor clearColor]; //no effect?

    
    
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    
    
    [tvcellPtr.contentView addSubview:templateUIView];
    
    self.cellMaxHeight=templateUIView.frame.size.height;
    //JUSTATEST DELETE BELOW
    // UIView *view =[[UIView alloc]init];
    //view.frame = tvcPtr.contentView.frame;
    //  view.frame=CGRectMake(0, 0, cellFrameW, cellFrameH);
    //  view.backgroundColor = [UIColor blueColor];//To be sure that the custom view in the cell
    //  [tvcPtr addSubview:view];
    //  self.cellMaxHeight= view.frame.size.height;
    
    //  return;
    //JUSTATEST DELETE ABOVE
    
    
    
    
    
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    
    
    [self defineTemplateUIViewforMaxWidth:maxwidth maxHeight:maxheight];
    return templateUIView;
    
    
       
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark OLD Methods
/////////////////////////////////////////

@end
