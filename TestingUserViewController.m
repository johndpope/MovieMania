

#import "TestingUserViewController.h"







@interface TestingUserViewController()

@end


@implementation TestingUserViewController


@synthesize stacksUIViewArray,stack1;
@synthesize stackLeft,stackRight,stackSubContent;
@synthesize stackLeftUIViewArray,stackRightUIViewArray,stackSubContentUIViewArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //below hides the <back link   so starup view controller is not accessible and the text "<back" isn't either
    self.navigationItem.leftBarButtonItem =     [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;   //so uiview not under nav bar
    //  self.view.frame=CGRectMake(50, 100, 200, 200);
    // self.view.bounds=self.view.bounds;
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    NSLog(@"testingUesrViewController.view frame  %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"testingUesrViewController.view bounds %@",NSStringFromCGRect(self.view.bounds));
    
    
}
-(void) viewWillAppear:(BOOL)animated
{
    //this works....doesn't have to be in viewDidAppear
    
    
    UIView *tempBackView=[[UIView alloc]init];
    
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:270].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:600].active = true;
    
    tempBackView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
    [self.view addSubview: tempBackView];
    
    
    UILayoutGuide *viewsMargin = self.view.layoutMarginsGuide;
    UILayoutGuide *tempBackViewLMG=tempBackView.layoutMarginsGuide;
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
    [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    
    
    
    UIStackView *complexStack=[self makeSimpleStackView];
    [tempBackView addSubview: complexStack];
    
    
    //pin stack accordingly
    // [complexStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [complexStack.topAnchor      constraintEqualToAnchor:tempBackViewLMG.topAnchor].active = YES;
    [complexStack.leftAnchor constraintEqualToAnchor:tempBackViewLMG.leftAnchor].active = YES;

    UILayoutGuide *complexStackViewLMG=complexStack.layoutMarginsGuide;
    
    
    
    UIStackView *csv2=[self makeComplexStackViewHideImage];
    [tempBackView addSubview:csv2];
    [csv2.topAnchor      constraintEqualToAnchor:complexStackViewLMG.bottomAnchor].active = YES;
    [csv2.leftAnchor constraintEqualToAnchor:complexStackViewLMG.leftAnchor].active = YES;
    
    
    return;

    
}
-(void) viewDidAppear:(BOOL)animated
{
    return;
    
    UIView *tempBackView=[[UIView alloc]init];
   
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:270].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:600].active = true;
    
     tempBackView.translatesAutoresizingMaskIntoConstraints = false;
   
  
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
     [self.view addSubview: tempBackView];
    
    
    UILayoutGuide *viewsMargin = self.view.layoutMarginsGuide;
    UILayoutGuide *tempBackViewLMG=tempBackView.layoutMarginsGuide;
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
    [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    
    
    
    UIStackView *complexStack=[self makeSimpleStackView];
    [tempBackView addSubview: complexStack];
    
    
    //pin stack accordingly
   // [complexStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [complexStack.topAnchor      constraintEqualToAnchor:tempBackViewLMG.topAnchor].active = YES;
    [complexStack.leftAnchor constraintEqualToAnchor:tempBackViewLMG.leftAnchor].active = YES;
    
    UILayoutGuide *complexStackViewLMG=complexStack.layoutMarginsGuide;
    
    
    
    UIStackView *csv2=[self makeComplexStackViewHideImage];
    [tempBackView addSubview:csv2];
    [csv2.topAnchor      constraintEqualToAnchor:complexStackViewLMG.bottomAnchor].active = YES;
    [csv2.leftAnchor constraintEqualToAnchor:complexStackViewLMG.leftAnchor].active = YES;
    
    
    return;
    
    
    
    
    
    
    
    
    
    //[tempBackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8.0].active = YES;  //moves me right (x)
   //[tempBackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:8.0].active = YES;
    //[tempBackView.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
    
    
    
    
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
   // int labelsStackH=300;
  //  int labelsStackW=270;
    
    
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    UILabel *mlabel1 = [UILabel new];
    mlabel1.text = @"Label 1";
    mlabel1.backgroundColor = [UIColor darkGrayColor];//[UIColor redColor];
    
    UILabel *mlabel2 = [UILabel new];
    mlabel2.text = @"Label 2";
    mlabel2.backgroundColor = [UIColor darkGrayColor];// [UIColor greenColor];

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

    
    [tempBackView addSubview: twoStack];
    
    
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
    
   
    
    [twoStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [twoStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
   // [tempBackView addSubview:aUIImageView];
    return;
    
    
    
    
    int stackH=600;
    int stackW=270;
    UIStackView *myStack = [[UIStackView alloc]init];
    //myStack.axis=UILayoutConstraintAxisHorizontal;//UILayoutConstraintAxisVertical;
    myStack.axis=UILayoutConstraintAxisVertical;
    myStack.spacing=5;
    myStack.alignment=UIStackViewAlignmentCenter;
    //myStack.distribution=UIStackViewDistributionEqualSpacing;
    //myStack.distribution=UIStackViewDistributionEqualCentering;
    myStack.distribution=UIStackViewDistributionFillEqually;
    //myStack.distribution=UIStackViewDistributionFillProportionally;
    myStack.translatesAutoresizingMaskIntoConstraints = false;
    //myStack.translatesAutoresizingMaskIntoConstraints = true;
    
    [myStack.widthAnchor constraintEqualToConstant:stackW].active = true;
    [myStack.heightAnchor constraintEqualToConstant:stackH].active = true;
    NSLog(@"myStack bounds %@",NSStringFromCGRect(myStack.bounds));
    NSLog(@"myStack frame %@",NSStringFromCGRect(myStack.frame));

    //[self.view addSubview:myStack];
    [tempBackView addSubview:myStack];
    
    
    
   // [myStack.centerXAnchor      constraintEqualToAnchor:tempBackViewsMargin.centerXAnchor].active = YES;
   // [myStack.centerYAnchor      constraintEqualToAnchor:tempBackViewsMargin.centerYAnchor].active = YES;
    
    [myStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [myStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    

    CALayer *pulseLayer = [CALayer layer];
    pulseLayer.frame=CGRectMake(0, 0, stackW, stackH); //MAKE SAME SIZE AS STACK
    pulseLayer.backgroundColor = [[UIColor clearColor] CGColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    pulseLayer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    pulseLayer.borderWidth=5.0;
    pulseLayer.cornerRadius = 12.;
    [myStack.layer addSublayer:pulseLayer];
   
    
    
    
    
    
    
    
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"Label 1";
    label1.backgroundColor = [UIColor redColor];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"Label 2";
    label2.backgroundColor = [UIColor greenColor];
    UILabel *label3 = [UILabel new];
    label3.text = @"Label 3";
    label3.backgroundColor = [UIColor blueColor];
    
    [myStack addArrangedSubview:label1];
    [myStack addArrangedSubview:label2];
    [myStack addArrangedSubview:label3];
    
    
    
 
    return;
    
    
    
    
    
    
    
    
    
    
    
    
    
    //[self viewDidLoadWOrkingExample];
   // return;
    
    
    
    self.stackLeftUIViewArray = [[NSMutableArray alloc ]init];
    self.stackRightUIViewArray = [[NSMutableArray alloc ]init];
    self.stackSubContentUIViewArray = [[NSMutableArray alloc ]init];

    CGRect myFrame = CGRectMake(100.0f, 120.0f, 150.0f, 40.0f);
    
    
    
    
    //right SUB stackview
    UILabel *alabel1=[self makeALabel:myFrame withString:@"first label"];

    
    UILabel *alabel2=[self makeALabel:myFrame withString:@"second label"];
    
   // [self.view addSubview:alabel2];
   // [tempBackView addSubview:alabel2];
   // return;
    
    
    
    
    
    
    
  //  CALayer *pulseLayer = [CALayer layer];
    pulseLayer.frame=CGRectMake(0, 0, 50, 50);
    pulseLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    //pulseLayer.bounds = CGRectMake(0., 0., 80., 80.);
    pulseLayer.cornerRadius = 12.;
    pulseLayer.position = CGPointMake( tempBackView.frame.size.width/2,tempBackView.frame.size.height/2);//tempBackView.center;
    
   // [tempBackView.layer addSublayer:pulseLayer];
    
    
    
    
    
    
    
    
    //View 1
     UIView *view1 = [[UIView alloc] init];
     view1.backgroundColor = [UIColor blueColor];
      [view1.heightAnchor constraintEqualToConstant:50].active = true;
      [view1.widthAnchor constraintEqualToConstant:50].active = true;
    //UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)]; //no
    
    
    view1.backgroundColor = [UIColor blueColor];
    NSLog(@"view1 frame %@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1 bounds %@",NSStringFromCGRect(view1.bounds));
    //[tempBackView addSubview: view1];
    self.view.translatesAutoresizingMaskIntoConstraints=YES;
    [myStack addArrangedSubview:view1];
    
    
   // [myStack.layer addSublayer:pulseLayer];
    
 //   [tempBackView.heightAnchor constraintEqualToConstant:100].active = true;
    [tempBackView addSubview:myStack];
    NSLog(@"view1 frame %@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1 bounds %@",NSStringFromCGRect(view1.bounds));

    return;
    
    
  //  [self.stackSubContentUIViewArray addObject:view1];
    

    [self.stackSubContentUIViewArray addObject:alabel1];
    [self.stackSubContentUIViewArray addObject:alabel2];
    
   // self.stackSubContent=[[UIStackView alloc]initWithArrangedSubviews:stackSubContentUIViewArray];
    self.stackSubContent=[[UIStackView alloc]init];
    
    
    
    
    

   
   // [self.stackSubContent addArrangedSubview:view1];
    
    self.stackSubContent.spacing=10;
    self.stackSubContent.alignment=UIStackViewAlignmentCenter;
    self.stackSubContent.distribution=UIStackViewDistributionEqualSpacing;
    self.stackSubContent.axis=UILayoutConstraintAxisVertical;
    //self.stackRight.axis=UILayoutConstraintAxisHorizontal;
    self.stackSubContent.translatesAutoresizingMaskIntoConstraints = false;

   // [stackSubContent.heightAnchor constraintEqualToConstant:300].active = true;
  //  [stackSubContent.widthAnchor constraintEqualToConstant:380].active = true;
    
    
 //   CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 //   shapeLayer.frame =stackSubContent.frame; //CGRectMake(150, 50, 200, 200);
 //   shapeLayer.fillColor = [UIColor whiteColor].CGColor;
 //   shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    //shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 380, 320)].CGPath;
 //   shapeLayer.path = [UIBezierPath bezierPathWithRect:shapeLayer.bounds].CGPath;
 //   [stackSubContent.layer addSublayer:shapeLayer];
    
   // stackSubContent.layer.borderColor = [UIColor yellowColor].CGColor;
   // stackSubContent.layer.borderWidth = 3.0;
   //   [self.view addSubview:stackSubContent]; //works
    [stackSubContent addArrangedSubview:alabel1];
   // [tempBackView addSubview: stackSubContent];
    [self.view addSubview:stackSubContent];
    return;
    
    
    
        //right  stackview holder of subcontent stackview
    [self.stackRightUIViewArray addObject:self.stackSubContent];
    self.stackRight=[[UIStackView alloc]initWithArrangedSubviews:stackRightUIViewArray];
    self.stackRight.backgroundColor=[UIColor orangeColor];
    self.stackRight.spacing=10;
    self.stackRight.alignment=UIStackViewAlignmentCenter;
    self.stackRight.distribution=UIStackViewDistributionEqualSpacing;
   // self.stackRight.axis=UILayoutConstraintAxisVertical;
    self.stackRight.axis=UILayoutConstraintAxisHorizontal;
    self.stackRight.translatesAutoresizingMaskIntoConstraints = false;
    [stackRight.heightAnchor constraintEqualToConstant:320].active = true;
    [stackRight.widthAnchor constraintEqualToConstant:380].active = true;
    
    
    
    //View Left for Image   and all of right side
    UIView *viewLeft = [[UIView alloc] init];
    viewLeft.backgroundColor = [UIColor greenColor];
    [viewLeft.heightAnchor constraintEqualToConstant:400].active = true;
    [viewLeft.widthAnchor constraintEqualToConstant:480].active = true;
    [self.stackLeftUIViewArray addObject:viewLeft];
    [self.stackLeftUIViewArray addObject:self.stackRightUIViewArray];
    
    self.stackLeft=[[UIStackView alloc]initWithArrangedSubviews:stackLeftUIViewArray];
    self.stackLeft.backgroundColor=[UIColor blueColor];
    self.stackLeft.spacing=2;
    self.stackLeft.alignment=UIStackViewAlignmentCenter;
    self.stackLeft.distribution=UIStackViewDistributionEqualSpacing;
    //  self.stack1.axis=UILayoutConstraintAxisVertical;
    self.stackLeft.axis=UILayoutConstraintAxisHorizontal;
    self.stackLeft.translatesAutoresizingMaskIntoConstraints = false;
    
    //[self.view addSubview:stackRight];
    
    //[self.view addSubview:stackLeft];
    
    
  
    
    
    
    
    
    
    
    
    
    
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  HELPER
//

-(UIStackView *) makeSimpleStackView
{
    
    
    
    
    /////////////////labelsStack contains the UILabels arranged vertically
    UIStackView *labelsStack = [[UIStackView alloc]init];
    labelsStack.axis=UILayoutConstraintAxisVertical;
    labelsStack.spacing=5;
    labelsStack.alignment=UIStackViewAlignmentCenter;
    labelsStack.distribution=UIStackViewDistributionFillEqually;
    labelsStack.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
    
   // UILabel *mlabel1 = [self makeALabelwithString:@"simple1" maxWidth:207 maxHeight:50  ];
    UILabel *mlabel1 = [self makeALabelSimpleString:@"simple 1"];
   // UILabel *mlabel2 = [self makeALabelwithString:@"simple2" maxWidth:207 maxHeight:50  ];
     UILabel *mlabel2 = [self makeALabelSimpleString:@"simple 2"];
    [labelsStack addArrangedSubview:mlabel1];
    [labelsStack addArrangedSubview:mlabel2];
    
    
    
    return labelsStack;
    
    
}

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
-(UIStackView *) makeComplexStackViewHideImage
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
    twoStack.alignment=UIStackViewAlignmentFill;
   // twoStack.distribution=UIStackViewDistributionFillEqually;
    twoStack.distribution=UIStackViewDistributionEqualSpacing;
   // twoStack.distribution=UIStackViewDistributionFill;
   // twoStack.distribution=UIStackViewDistributionFillProportionally;
  //  twoStack.distribution=UIStackViewDistributionEqualCentering;
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
    
    
    
    //imageToShow=nil;
    
    
    
    [aUIImageView setImage:imageToShow];
    NSLog(@"aUIImageView frame %@",NSStringFromCGRect(aUIImageView.frame));
    
    
    aUIImageView.contentMode = UIViewContentModeCenter;
    
   //hide image
   //moves label alignment left  aUIImageView.hidden=true; //test   - WORKS  labels stay aligned ?
    
    aUIImageView.hidden=true;
    
    [twoStack addArrangedSubview:aUIImageView];
    [twoStack addArrangedSubview: lHOlderStack];
    
    
    
    //DO in CALLING routine    [twoStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    //DO in CALLING routine    [twoStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    return twoStack;
    
}
-(UILabel *)makeALabelSimpleString:(NSString *)thisString
{
    UILabel *title;
    title = [[UILabel alloc] init];
    title.text=thisString;
    title.textColor=[UIColor blackColor];
    title.backgroundColor=[UIColor blueColor];
    return title;
}
-(UILabel *)makeALabelwithString:(NSString *)thisString maxWidth:(CGFloat)maxW maxHeight:(CGFloat)maxH
{
    //self.myLabel = [[UILabel alloc] initWithFrame:myFrame];
    UILabel *title;
    title = [[UILabel alloc] init];
    // CGRect myFrame=CGRectMake(0, 0, maxW, maxH);
    //[title setFrame:myFrame];
    title.layer.borderColor = [UIColor yellowColor].CGColor;
    title.layer.borderWidth = 3.0;
    //title.layer.cornerRadius=8.0;
    //title.clipsToBounds=YES;
    
    title.text = thisString;
    title.font = [UIFont boldSystemFontOfSize:16.0f];
    title.textAlignment =  NSTextAlignmentCenter;
    title.backgroundColor=[UIColor redColor];
    title.textColor=[UIColor blackColor];
    title.userInteractionEnabled=NO;
    
    title.preferredMaxLayoutWidth=maxW;
    [title.heightAnchor constraintEqualToConstant:maxH].active = true;   //req'd for stack
    
    
    [title.widthAnchor constraintEqualToConstant:maxW].active = true;     //req'd for stack
    title.hidden=false;
    return title;
    
}

-(UILabel *)makeALabel:(CGRect) myFrame withString:(NSString *)thisString
{
    //self.myLabel = [[UILabel alloc] initWithFrame:myFrame];
    UILabel *title;
    title = [[UILabel alloc] init];
    [title setFrame:myFrame];
    title.layer.borderColor = [UIColor yellowColor].CGColor;
    title.layer.borderWidth = 3.0;
    //title.layer.cornerRadius=8.0;
    //title.clipsToBounds=YES;
    
    title.text = thisString;
    title.font = [UIFont boldSystemFontOfSize:16.0f];
    title.textAlignment =  NSTextAlignmentCenter;
    title.backgroundColor=[UIColor redColor];
    title.textColor=[UIColor blackColor];
    title.userInteractionEnabled=NO;
    
    title.preferredMaxLayoutWidth=myFrame.size.width;
    [title.heightAnchor constraintEqualToConstant:title.frame.size.height].active = true;   //req'd for stack
    
    [title.widthAnchor constraintEqualToConstant:title.frame.size.width].active = true;     //req'd for stack

    return title;
    
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  NOTIFY
//
- (void)notifyITSallGOOD
{
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerSuccess  object:nil];
    NSLog(@"IDentifyUserViewController notifyITSallGOOD");
}

- (void)notifyITSallBAD
{
    [[NSNotificationCenter defaultCenter] postNotificationName: ConstIDentifyUserControllerFailure  object:nil];
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#pragma mark  SAVE-THESE WORK
///////////////////
-(void) workingTwoEntriesComplexStackViewviewDidAppear:(BOOL)animated
{
    
    
    UIView *tempBackView=[[UIView alloc]init];
    
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:270].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:600].active = true;
    
    tempBackView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
    [self.view addSubview: tempBackView];
    
    
    UILayoutGuide *viewsMargin = self.view.layoutMarginsGuide;
    UILayoutGuide *tempBackViewLMG=tempBackView.layoutMarginsGuide;
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
    [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    
    
    
    UIStackView *complexStack=[self makeComplexStackView];
    [tempBackView addSubview: complexStack];
    
    
    //pin stack accordingly
    // [complexStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [complexStack.topAnchor      constraintEqualToAnchor:tempBackViewLMG.topAnchor].active = YES;
    [complexStack.leftAnchor constraintEqualToAnchor:tempBackViewLMG.leftAnchor].active = YES;
    
    UILayoutGuide *complexStackViewLMG=complexStack.layoutMarginsGuide;
    
    
    
    UIStackView *csv2=[self makeComplexStackViewHideImage];
    [tempBackView addSubview:csv2];
    [csv2.topAnchor      constraintEqualToAnchor:complexStackViewLMG.bottomAnchor].active = YES;
    [csv2.leftAnchor constraintEqualToAnchor:complexStackViewLMG.leftAnchor].active = YES;
    
    
    return;
    
}
-(void) viewDidAppearCellsWorkingExample:(BOOL)animated
{
    
    UIView *tempBackView=[[UIView alloc]init];
    
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:270].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:600].active = true;
    
    tempBackView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
    [self.view addSubview: tempBackView];
    
    
    UILayoutGuide *viewsMargin = self.view.layoutMarginsGuide;
    
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
    [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    //[tempBackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8.0].active = YES;  //moves me right (x)
    //[tempBackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:8.0].active = YES;
    //[tempBackView.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
    
    
    
    
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
  //  int labelsStackH=300;
  //  int labelsStackW=270;
    
    
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
    
    
    [tempBackView addSubview: twoStack];
    
    
    UIImageView *aUIImageView;//=[[UIImageView alloc]init];
    // U I I M A G E V I E W
    aUIImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; //actual size (ht) set by pic
    /* aUIImageView.clipsToBounds = YES;
     aUIImageView.layer.cornerRadius = 8.0;
     aUIImageView.layer.borderWidth = 2.0;
     aUIImageView.layer.borderColor = [UIColor blackColor].CGColor;
     */
    [aUIImageView setBackgroundColor:[UIColor clearColor]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"buffy100x100" ofType:@"png"];
    UIImage * imageToShow = [UIImage imageWithContentsOfFile:filePath];
    [aUIImageView setImage:imageToShow];
    NSLog(@"aUIImageView frame %@",NSStringFromCGRect(aUIImageView.frame));
    
    // aUIImageView.frame = CGRectMake(0, 0, imageToShow.size.width+10, imageToShow.size.height + 10); // replace 100 with the height of your image, plus a bit if you want it to have a margin
    aUIImageView.contentMode = UIViewContentModeCenter;
    [twoStack addArrangedSubview:aUIImageView];
    [twoStack addArrangedSubview: lHOlderStack];
    
    
    
    [twoStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [twoStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    // [tempBackView addSubview:aUIImageView];
    return;

}

-(void) viewDidAppearWorkingExample:(BOOL)animated
{
    UIView *tempBackView=[[UIView alloc]init];
    
    tempBackView.backgroundColor=[UIColor orangeColor];
    [tempBackView.widthAnchor constraintEqualToConstant:270].active = true;
    [tempBackView.heightAnchor constraintEqualToConstant:600].active = true;
    
    tempBackView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    NSLog(@"tempBackView frame  %@",NSStringFromCGRect(tempBackView.frame));
    NSLog(@"tempBackView bounds %@",NSStringFromCGRect(tempBackView.bounds));
    
    [self.view addSubview: tempBackView];
    
    
    UILayoutGuide *viewsMargin = self.view.layoutMarginsGuide;
    
    //[tempBackView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    
    [tempBackView.centerXAnchor constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [tempBackView.centerYAnchor constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    //[tempBackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8.0].active = YES;  //moves me right (x)
    //[tempBackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:8.0].active = YES;
    //[tempBackView.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
  //  UILayoutGuide *tempBackViewsMargin = tempBackView.layoutMarginsGuide;
    
    
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
    
    
    
    int stackH=600;
    int stackW=270;
    UIStackView *myStack = [[UIStackView alloc]init];
    //myStack.axis=UILayoutConstraintAxisHorizontal;//UILayoutConstraintAxisVertical;
    myStack.axis=UILayoutConstraintAxisVertical;
    myStack.spacing=5;
    myStack.alignment=UIStackViewAlignmentCenter;
    //myStack.distribution=UIStackViewDistributionEqualSpacing;
    //myStack.distribution=UIStackViewDistributionEqualCentering;
    myStack.distribution=UIStackViewDistributionFillEqually;
    //myStack.distribution=UIStackViewDistributionFillProportionally;
    myStack.translatesAutoresizingMaskIntoConstraints = false;
    //myStack.translatesAutoresizingMaskIntoConstraints = true;
    
    [myStack.widthAnchor constraintEqualToConstant:stackW].active = true;
    [myStack.heightAnchor constraintEqualToConstant:stackH].active = true;
    NSLog(@"myStack bounds %@",NSStringFromCGRect(myStack.bounds));
    NSLog(@"myStack frame %@",NSStringFromCGRect(myStack.frame));
    
    //[self.view addSubview:myStack];
    [tempBackView addSubview:myStack];
    
    
    
    // [myStack.centerXAnchor      constraintEqualToAnchor:tempBackViewsMargin.centerXAnchor].active = YES;
    // [myStack.centerYAnchor      constraintEqualToAnchor:tempBackViewsMargin.centerYAnchor].active = YES;
    
    [myStack.centerXAnchor      constraintEqualToAnchor:viewsMargin.centerXAnchor].active = YES;
    [myStack.centerYAnchor      constraintEqualToAnchor:viewsMargin.centerYAnchor].active = YES;
    
    
    CALayer *pulseLayer = [CALayer layer];
    pulseLayer.frame=CGRectMake(0, 0, stackW, stackH); //MAKE SAME SIZE AS STACK
    pulseLayer.backgroundColor = [[UIColor clearColor] CGColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    pulseLayer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    pulseLayer.borderWidth=5.0;
    pulseLayer.cornerRadius = 12.;
    [myStack.layer addSublayer:pulseLayer];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"Label 1";
    label1.backgroundColor = [UIColor redColor];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"Label 2";
    label2.backgroundColor = [UIColor greenColor];
    UILabel *label3 = [UILabel new];
    label3.text = @"Label 3";
    label3.backgroundColor = [UIColor blueColor];
    
    [myStack addArrangedSubview:label1];
    [myStack addArrangedSubview:label2];
    [myStack addArrangedSubview:label3];
    
    
    
    
    return;
    
    
}
-(void)viewDidLoadWOrkingExample
{
    //use viewDidAppearWorkingExample   - its better
    
    
    
    
    UIView *viewRight = [[UIView alloc] init];
    viewRight.backgroundColor = [UIColor blueColor];
    [viewRight.heightAnchor constraintEqualToConstant:100].active = true;
    [viewRight.widthAnchor constraintEqualToConstant:120].active = true;
    
    
    
    
    
    
    //View 1
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    [view1.heightAnchor constraintEqualToConstant:100].active = true;
    [view1.widthAnchor constraintEqualToConstant:120].active = true;
    
    
    //View 2
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    [view2.heightAnchor constraintEqualToConstant:100].active = true;
    [view2.widthAnchor constraintEqualToConstant:120].active = true;
    
    //View 3
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor orangeColor];
    [view3.heightAnchor constraintEqualToConstant:100].active = true;
    [view3.widthAnchor constraintEqualToConstant:140].active = true;
    
    //View 4
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor redColor];
    [view4.heightAnchor constraintEqualToConstant:100].active = true;
    [view4.widthAnchor constraintEqualToConstant:140].active = true;
    
    self.stacksUIViewArray = [[NSMutableArray alloc ]init];
    [self.stacksUIViewArray addObject:view1];
    [self.stacksUIViewArray addObject:view2];
    [self.stacksUIViewArray addObject:view3];
    [self.stacksUIViewArray addObject:view4];
    
    
    //DOESN'T WORK
    // self.stack1=[[UIStackView alloc]initWithArrangedSubviews:self.stacksUIViewArray];
    //  [self.view addSubview:stack1];
    //self.stack1=[[UIStackView alloc]init];
    self.stack1=[[UIStackView alloc]initWithArrangedSubviews:self.stacksUIViewArray];
    //self.stack1 = [[UIStackView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    NSLog(@"stack1 frame %@",NSStringFromCGRect(self.stack1.frame));
    self.stack1.backgroundColor=[UIColor redColor];//stack1 with no frame size so is not shown.....
    //  self.stack1.spacing=30; //0 otherwise...touching corners
    self.stack1.spacing=5;
    self.stack1.alignment=UIStackViewAlignmentCenter;
    
    self.stack1.distribution=UIStackViewDistributionEqualSpacing;
    //  self.stack1.axis=UILayoutConstraintAxisVertical;
    self.stack1.axis=UILayoutConstraintAxisHorizontal;
    self.stack1.translatesAutoresizingMaskIntoConstraints = false;
    //[self.stack1 addArrangedSubview:view1];
    //[self.stack1 addArrangedSubview:view2];
    
    [self.view addSubview:stack1];
    
}









@end
