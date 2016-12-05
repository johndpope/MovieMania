//
//  TableViewController.h
//
//
//  
//


//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GlobalTableProto.h"
#import "GlobalCalcVals.h"
#import "ActionRequest.h"
#import "CellMovieView.h"
//#import "YTPlayerView.h"

@interface TableViewController : UITableViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate, UITableViewDelegate>//<YTPlayerViewDelegate>

//@property (nonatomic, readwrite) int inMovieVC;
//@property (nonatomic, readwrite) ActionRequest *actionForReloadingView;
- (id)initWithTableDataPtr:(TableDef *)tableDefPtr usingTableViewStyle:(UITableViewStyle)tvcStyle viewFrame:(CGRect)thisFrame;//CHANGED
//@property(nonatomic, readwrite) BOOL reloadOnly;
//-(void)touchDownOnButton:(id)sender;
//-(void)touchUpOnButton:(id)sender;

@end
