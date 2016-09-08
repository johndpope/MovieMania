//
//  CellButtonsScroll.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "CellImageOnly.h"

@implementation CellImageOnly

@synthesize myImage,myImageName,backgoundColor;
@synthesize rotateWhenVisible,myUIImageViewRotating;
@synthesize imageSize;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    myImage=nil;
    myImageName=nil;
    backgoundColor=nil;
    myUIImageViewRotating=nil;
}
-(id) init
{
    self = [super init];
    if (self) {
        [self makeUseDefaults:self];
        
    }
    return self;
}
-(void) makeUseDefaults:(CellImageOnly *)nCell
{
 nCell.enableUserActivity=TRUE;   
    nCell.cellclassType=CELLCLASS_IMAGE_ONLY;
    myImage=nil;
    rotateWhenVisible=FALSE;
    myImageName=nil;
    nCell.backgoundColor= TK_TRANSPARENT_COLOR;
    myUIImageViewRotating=nil;
    nCell.cellMaxHeight=0;//DEF_CELLHEIGHT;


}


+ (id)initCellForTitleDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag
{
    CellImageOnly* nCell=[[CellImageOnly alloc]init];    //calls makeUseDefaults
//temporary read from bundle
    
    if (imageToShow == nil) {
        if(imageName==nil){
            imageName=@"defImage";
        }
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        imageToShow = [UIImage imageWithContentsOfFile:filePath];
    }
    
   nCell.myImageName=imageName;
    nCell.myImage=imageToShow;
    nCell.backgoundColor=backColor;
    nCell.rotateWhenVisible=rotateFlag;
    return nCell;

}
+ (id)initCellDefaults:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag withSize:(CGSize)picSize{
     CellImageOnly* nCell=[[CellImageOnly alloc]init];    //calls makeUseDefaults

//temporary read from bundle
    if (imageToShow == nil) {
        if(imageName==nil){
            imageName=@"defImage";
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        imageToShow = [UIImage imageWithContentsOfFile:filePath];
    }

    
    nCell.myImageName=imageName;
//    nCell.myImage=imageToShow;
    nCell.backgoundColor=backColor;
    nCell.rotateWhenVisible=rotateFlag;
    nCell.cellMaxHeight =picSize.height;
    nCell.imageSize= picSize;
    UIImage *scaledImage = [self imageWithImage:imageToShow scaledToSize:nCell.imageSize];
    
   // CGSize imsizenow=scaledImage.size;
    nCell.myImage = scaledImage;
    return nCell;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)anewSize {
    
    UIGraphicsBeginImageContextWithOptions(anewSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, anewSize.width, anewSize.height)];
    UIImage *anewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return anewImage;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////
-(UIColor *) giveCellBackColor
{
    return self.backgoundColor;
}
-(UIImage *) giveCellImage
{
    return self.myImage;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Assignment Methods
/////////////////////////////////////////

- (void)updateCellImage:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag
{
        //calls makeUseDefaults
    
    //temporary read from bundle
    if (imageToShow == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        imageToShow = [UIImage imageWithContentsOfFile:filePath];
    }
    
    UIImage *scaledImage = [CellImageOnly imageWithImage:imageToShow scaledToSize:imageSize];
    
    self.myImageName=imageName;
 //   self.myImage=imageToShow;
    self.myImage = scaledImage;
    self.backgoundColor=backColor;
    self.rotateWhenVisible=rotateFlag;
}

- (void)updateCellImage:(UIImage *)imageToShow withPNGName:(NSString *)imageName withBackColor:(UIColor *)backColor rotateWhenVisible:(BOOL)rotateFlag withSize:(CGSize)picSize
{
    //calls makeUseDefaults
    imageSize=picSize;
    //temporary read from bundle
    if (imageToShow == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        imageToShow = [UIImage imageWithContentsOfFile:filePath];
    }
    
    UIImage *scaledImage = [CellImageOnly imageWithImage:imageToShow scaledToSize:imageSize];
    
    self.myImageName=imageName;
    //   self.myImage=imageToShow;
    self.myImage = scaledImage;
    self.backgoundColor=backColor;
    self.rotateWhenVisible=rotateFlag;
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
    
    

    //DOES THIS EVER NEED TO BE SCALED?
    UIImage *myScaledImage = myImage;//[CellImageOnly imageWithImage:myImage scaledToSize:self.imageSize];
  //OFF by X value.....  tvcellPtr.imageView.image=myScaledImage;
    
    
    
    
  

    
    
    
    
    
    
    
//    self.cellMaxHeight=myImage.size.height;
    
    UIImageView *aUIImageView= [[UIImageView alloc] initWithFrame:CGRectZero]; //actual size (ht) set by pic
    //aUIImageView.clipsToBounds = YES;
   // aUIImageView.layer.cornerRadius = 8.0;
   // aUIImageView.layer.borderWidth = 2.0;
   // aUIImageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [aUIImageView setBackgroundColor:self.backgoundColor];
    [aUIImageView setImage:myScaledImage];
    self.cellMaxHeight=aUIImageView.frame.size.height;
    
    
    aUIImageView.frame = CGRectMake(0, 0, myScaledImage.size.width, myScaledImage.size.height);
    aUIImageView.contentMode = UIViewContentModeCenter;
    
    tvcellPtr.backgroundColor=[UIColor clearColor];
    tvcellPtr.contentView.backgroundColor=[UIColor clearColor];
    [tvcellPtr.contentView addSubview:aUIImageView];
    
    //[tvcPtr se:self.cellDispTextPtr.textStr];
    
}
-(UIView *) putMeVisibleMaxWidth:(int)maxwidth maxHeight:(int)maxheight withTVC:(UITableViewController *) tvcPtr
{
    //return  UIView to display this stuff
    UIView* returnedUIView;//=[[UIView alloc]initWithFrame:CGRectZero];
    
    UIImageView *aUIImageView;//=[[UIImageView alloc]init];
   // UILabel *aLabel;
 
    //L A B E L
  //  aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  //  aLabel.layer.borderColor = [UIColor blackColor].CGColor;
  //  aLabel.layer.borderWidth = 3.0;
    
    // U I I M A G E V I E W
    UIImage *myScaledImage = [CellImageOnly imageWithImage:myImage scaledToSize:self.imageSize];
    aUIImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; //actual size (ht) set by pic
    aUIImageView.clipsToBounds = YES;
   //1 aUIImageView.layer.cornerRadius = 8.0;
   //1 aUIImageView.layer.borderWidth = 2.0;
   //1 aUIImageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [aUIImageView setBackgroundColor:self.backgoundColor];
    [aUIImageView setImage:myScaledImage];
    
    
    aUIImageView.frame = CGRectMake(0, 0, maxwidth, myImage.size.height + 10); // replace 100 with the height of your image, plus a bit if you want it to have a margin
    aUIImageView.contentMode = UIViewContentModeCenter;
    
    
    
    int padding=0;//10;
    returnedUIView=[[UIView alloc] initWithFrame:CGRectMake(padding, 0, aUIImageView.frame.size.width - (2 * padding) , aUIImageView.frame.size.height)];
    returnedUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    returnedUIView.backgroundColor=[UIColor clearColor];
   //? returnedUIView.frame=aUIImageView.frame;
    
    
    returnedUIView.backgroundColor=  self.backgoundColor;
   //1 returnedUIView.layer.cornerRadius=8;
   //1 returnedUIView.layer.borderWidth=2.0;
   //1 returnedUIView.layer.borderColor=[UIColor redColor].CGColor;

    
    
    self.cellMaxHeight=aUIImageView.frame.size.height;
    
    [returnedUIView addSubview:aUIImageView];
    
    
    
    
    
    if (rotateWhenVisible) {
        self.myUIImageViewRotating=aUIImageView;
        // [self rotateImageOnce:thisImageView duration:3.0  curve:UIViewAnimationCurveEaseIn degrees:180]; //350,360 no, 180 good   WORKS
        [self rotateImageUsingBlock:aUIImageView duration:3.0  curve:UIViewAnimationCurveEaseIn degrees:180]; //350,360 no, 180 good
        

    }
    else{
        myUIImageViewRotating=nil;
    }
    
    
    
    return returnedUIView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Rotation Methods
/////////////////////////////////////////

- (void)rotateImageUsingBlock:(UIImageView *)image duration:(NSTimeInterval)duration
                        curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    // [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:duration];
    //  [UIView setAnimationCurve:curve];
    
    // [UIView setAnimationBeginsFromCurrentState:YES];
    self.myUIImageViewRotating=image;
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    //  image.transform = transform;
    
    // Commit the changes
    //   [UIView commitAnimations];
    
    
    
    //or
    //    [UIView animateWithDuration:duration
    //                        delay:0.1
    //                    options:UIViewAnimationOptionCurveEaseIn
    //               animations:^ {
    //                 image.transform = transform;
    
    //           }completion:^(BOOL finished) {
    //             NSLog(@"anim done");
    //       }];
    
    
    //or
    
    [UIView animateWithDuration:duration
                          delay:0.1
                        options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         image.transform = transform;
                         
                     }completion:^(BOOL finished) {
                         NSLog(@"anim done");
                     }];
    
    
    
    
    
    
    
}

- (void)rotateImageOnce:(UIImageView *)image duration:(NSTimeInterval)duration
                  curve:(int)curve degrees:(CGFloat)degrees
{//WORKS
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    // Commit the changes
    [UIView commitAnimations];
}

/*
- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{//eventually T R A P S
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    [UIView setAnimationDidStopSelector:@selector(fadeInDidStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    // Commit the changes
    [UIView commitAnimations];
}
- (void)reverseRotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
                     curve:(int)curve degrees:(CGFloat)degrees
{//eventually T R A P S
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =     CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    [UIView setAnimationDidStopSelector:@selector(fadeInDidStopReverse:finished:context:)];
    [UIView setAnimationDelegate:self];
    // Commit the changes
    [UIView commitAnimations];
}
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
