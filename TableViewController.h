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

@interface TableViewController : UITableViewController //<UIGestureRecognizerDelegate>//<YTPlayerViewDelegate>

//@property (nonatomic, readwrite) int inMovieVC;
//@property (nonatomic, readwrite) ActionRequest *actionForReloadingView;
- (id)initWithTableDataPtr:(TableDef *)tableDefPtr usingTableViewStyle:(UITableViewStyle)tvcStyle;
//@property(nonatomic, readwrite) BOOL reloadOnly;
//-(void)touchDownOnButton:(id)sender;
//-(void)touchUpOnButton:(id)sender;

@end
