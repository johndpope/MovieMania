//
//  CellTextDef.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellImageLTextR.h"

@implementation CellImageLTextR


@synthesize cellDispTextPtr,numberOfLines;
@synthesize cellImagePtr;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    
    
    
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellImageLTextR *)nCellDef
{
    nCellDef.enableUserActivity=TRUE;
    nCellDef.cellclassType=CELLCLASS_TEXT;
   nCellDef.cellDispTextPtr=[DispTText initDispTTextDefaultsForCell];
    nCellDef.numberOfLines=1;
    nCellDef.cellImagePtr=[[CellImageOnly alloc]init];
    nCellDef.cellMaxHeight=DEF_CELLHEIGHT;
}


+ (id)initCellForTitleDefaults
{
    CellImageLTextR* nCellDef=[[CellImageLTextR alloc]init];    //calls makeUseDefaults
    
   nCellDef.cellDispTextPtr=[DispTText initDispTTextDefaultsForTable];
    return nCellDef;

}
+ (id)initCellDefaults
{
    
    CellImageLTextR* nCellDef=[[CellImageLTextR alloc]init];
    [nCellDef makeUseDefaults:nCellDef];
    return nCellDef;
}


+ (id)initCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    //nil values sent cause defaults to be used.
    CellImageLTextR* nCellTextDef=[[CellImageLTextR alloc]init]; //init sets defaults for us
    
    [nCellTextDef updateCellText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    
    
        
    nCellTextDef.numberOfLines=1;
     
    return nCellTextDef;

    
}
+ (id)initCellWithImageAndText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName withImage:(UIImage*)theImage withImageName:(NSString*)theImageName withImageBackColor:(UIColor *)imageBackColor withSize:(CGSize)picSize
{
    
    //nil values sent cause defaults to be used.
    CellImageLTextR* nCell=[[CellImageLTextR alloc]init]; //init sets defaults for us
    
    
    [nCell.cellDispTextPtr updateDispTTextDefText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];

    
    nCell.numberOfLines=1;
    
    //temporary read from bundle
    if (theImage == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:theImageName ofType:@"png"];
        theImage = [UIImage imageWithContentsOfFile:filePath];
    }
    [nCell.cellImagePtr updateCellImage:theImage withPNGName:theImageName withBackColor:imageBackColor rotateWhenVisible:NO withSize:picSize];

    
    
 
    
     
    return nCell;
    
    
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

-(void) updateCellText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName
{
    
    [self.cellDispTextPtr updateDispTTextDefText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    


}
-(void)updateCellWithImageAndText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName withImage:(UIImage*)theImage withImageName:(NSString*)theImageName withImageBackColor:(UIColor *)imageBackColor
{
    
    

    
    
       [self.cellDispTextPtr updateDispTTextDefText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    //return  UIView to display this stuff
    UIView* returnedUIView;
   
    
    
    //L A B E L
    UILabel *aLabel= [[UILabel alloc] initWithFrame:CGRectZero];
  //1  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
  //1  aLabel.layer.borderWidth = 3.0;
    aLabel.textAlignment=NSTextAlignmentCenter;  //centers my text
    aLabel.textColor = self.cellDispTextPtr.textColor;
    aLabel.backgroundColor = self.cellDispTextPtr.backgoundColor;
    aLabel.font = self.cellDispTextPtr.textFontAndSize;   //set font
    aLabel.text = self.cellDispTextPtr.textStr;
    [aLabel setNumberOfLines: 0];
    [aLabel sizeToFit];
    
    aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin; // leave in aligns center
   // aLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin; //aligns right
   // aLabel.autoresizingMask= UIViewAutoresizingFlexibleRightMargin; //aligns left
    

    //image in a uiView
    UIView *myImUIView=[self.cellImagePtr putMeVisibleMaxWidth:maxwidth maxHeight:maxheight withTVC:tvcPtr];
    NSLog(@"myimuiview frame %@", NSStringFromCGRect(myImUIView.frame));
    //[thumbnailImage setContentMode:UIViewContentModeScaleAspectFill];
    myImUIView.alpha=0.3;
    
    
 /*   UIImageView *thumbnailImage;
    thumbnailImage = [[UIImageView alloc] initWithFrame:CGRectMake(xImage, yImage, imageWidth, imageHeight)];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(xImage,imageHeight - titleHeight , titleWidth , titleHeight )];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(xTitle, yTitle , titleWidth ,titleHeight)];
    titleView.alpha = 0.3;
    [thumbnailImage setContentMode:UIViewContentModeScaleAspectFill];
    thumbnailImage.clipsToBounds = YES;
    [self.view addSubview:thumbnailImage];
    [self.view addSubview:titleView];
    */
    
    
    
    int padding=10;
   // returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, aLabel.frame.size.width - (2 * padding) , aLabel.frame.size.height)];
    returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, myImUIView.frame.size.width - (2 * padding) , myImUIView.frame.size.height)];
    returnedUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
    
    returnedUIView.backgroundColor=[UIColor clearColor];
    returnedUIView.contentMode=UIViewContentModeLeft; //?
    myImUIView.center=CGPointMake(myImUIView.frame.size.width/2, myImUIView.frame.size.height/2);
    
   
    [returnedUIView addSubview:myImUIView];
    
     [returnedUIView addSubview:aLabel];    //
    
    
    if (myImUIView.frame.size.height > aLabel.frame.size.height) {
        self.cellMaxHeight=myImUIView.frame.size.height;
    }
    else {
        self.cellMaxHeight=aLabel.frame.size.height;
    }
    

    
    
    
    
    return returnedUIView;
}
-(CGFloat) provideCellHeight:(UITableViewCell*)tvcPtr
{
    return self.cellMaxHeight;
}
-(void) putMeInTableViewCell:(UITableViewCell*)tvcellPtr withTVC:(UITableViewController *)tvcontrollerPtr maxWidth:(int)maxW maxHeight:(int)maxH
{
    //put my displayable contents in a passed table view cell
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    
    
    
    tvcellPtr.textLabel.textColor=self.cellDispTextPtr.textColor;
    tvcellPtr.backgroundColor=self.cellDispTextPtr.backgoundColor;//ccTextDef.backgoundColor;
    tvcellPtr.textLabel.text=self.cellDispTextPtr.textStr;
    tvcellPtr.imageView.image=self.cellImagePtr.myImage;
    self.cellMaxHeight=self.cellImagePtr.myImage.size.height;
    //[tvcPtr se:self.cellDispTextPtr.textStr];
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
