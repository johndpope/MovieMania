//
//  HDButtonView.h
//  MusicMania
//
//  Created by Dan Hammond on 4/20/13.
//
//

#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"
//#import "GlobalCalcVals.h"

//@class SpritesAndButtons;
//@class MMSpriteAction;
@class TableViewController;
@class ActionRequest;



//#define kButtonRowModulus 100
#define kColumn1 21

@interface HDButtonView : UIView <UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate>
@property (nonatomic, readwrite) BOOL              isLongBtnPress;
//@property (nonatomic, readwrite) BOOL               containerViewScrolls;
@property (nonatomic, readwrite) int                buttonTag;
@property (nonatomic, strong) NSMutableArray        *buttonSequence;
@property (nonatomic, strong) UIScrollView          *containerView;
@property (nonatomic, readwrite) int                rowNumber;
@property (nonatomic, retain) UIImageView           *selectedBtnBox;
@property (nonatomic, readwrite) ActionRequest      *tvfocusAction;
//- (id)initWithContainer:(UIView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr containerScrolls:(BOOL)containerScrolls;

//- (id)initWithContainer:(UIView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr containerScrolls:(BOOL)containerScrolls withTVC:(TableViewController *)tvcPtr;

- (id)initWithContainer:(UIScrollView *)container buttonSequence:(NSMutableArray *)btnSequence rowNumbr:(int)rowNmbr withTVC:(TableViewController *)tvcPtr;

//+(void)updateThisButton:(SpritesAndButtons *)thisButtonDef aSpriteAction:(MMSpriteAction *)aSpriteAction buttonIsOn:(BOOL)buttonIsOn;
//+(void)enableThisSAB:(SpritesAndButtons *)aSAB;
//+(void)disableThisSAB:(SpritesAndButtons *)aSAB;
//-(void)addButtonViewToContainer:(UIView *)container animated:(BOOL)animated;
//-(void)removeButtonViewFromContainer:(UIView *)container animated:(BOOL)animated;
//-(UIView *)addButtonsToView;//:(NSMutableArray *)buttonSeqence containerView:(UIView *)containerView  rowNumber:(int)rowNumber;
//-(void)touchDownOnButton:(id)sender;
//-(void)touchUpOnButton:(id)sender;

//-(void)enableThisSAB;
//-(void)disableThisSAB;
//-(void)moveToButtonInCenter:(NSInteger)currentCenterBtnNumber;
+(void)makeUIButton:(ActionRequest*)actionReq inButtonSequence:(NSMutableArray *)buttonSeq;
-(void)checkUserFocusMovie;
-(void) borderButtonSel;
@end
