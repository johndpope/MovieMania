//
//  GlobalCalcVals.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "GlobalCalcVals.h"


@implementation GlobalCalcVals

@synthesize tableCreatedHeight,tableCreatedWidth;


//@synthesize tvc;



+(GlobalCalcVals *)sharedGlobalCalcVals
{
    static GlobalCalcVals *sharedGlobalCalcVals;
    if (sharedGlobalCalcVals == nil) {
        sharedGlobalCalcVals = [[super allocWithZone:nil] init];
        
        
        [sharedGlobalCalcVals initDefaultValues];
        
    }
    
    return sharedGlobalCalcVals;
}




-(void) initDefaultValues
{
    tableCreatedHeight=0;
    tableCreatedWidth=0;
   
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Helper Methods
/////////////////////////////////////////
-(UIStackView *) makeComplexStackView
{
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    UILabel *mlabel1 = [UILabel new];
    mlabel1.text = @"Label 1";
    mlabel1.backgroundColor = [UIColor redColor];
    
    UILabel *mlabel2 = [UILabel new];
    mlabel2.text = @"Label 2";
    mlabel2.backgroundColor = [UIColor greenColor];
    
    [labelsStack addArrangedSubview:mlabel1];
    [labelsStack addArrangedSubview:mlabel2];
    //TESTING  [tempBackView addSubview:labelsStack];
    // [labelsStack.widthAnchor constraintEqualToConstant:labelsStackW].active = true;
    // [labelsStack.heightAnchor constraintEqualToConstant:labelsStackH].active = true;
    
    /*   CALayer *aLayer = [CALayer layer];
     aLayer.frame=CGRectMake(0, 0, labelsStackW, labelsStackH); //MAKE SAME SIZE AS STACK
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
    //TEST [tempBackView addSubview:lHOlderStack];
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
    aUIImageView.layer.cornerRadius = 8.0;   //frame
    aUIImageView.layer.borderWidth = 2.0;    //frame
    aUIImageView.layer.borderColor = [UIColor blackColor].CGColor; //frame
    
    [aUIImageView setBackgroundColor:[UIColor clearColor]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buffy100x100" ofType:@"png"];
    UIImage * imageToShow = [UIImage imageWithContentsOfFile:filePath];
    [aUIImageView setImage:imageToShow];
    NSLog(@"aUIImageView frame %@",NSStringFromCGRect(aUIImageView.frame));
    
    
    aUIImageView.contentMode = UIViewContentModeCenter;
    
    
    // aUIImageView.hidden=true; //test   - WORKS  labels stay aligned ?
    [twoStack addArrangedSubview:aUIImageView];
    [twoStack addArrangedSubview: lHOlderStack];
    
    
    
    //DO in CALLING routine    [twoStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    //DO in CALLING routine    [twoStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    return twoStack;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end