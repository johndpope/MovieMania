//
//  IDentifyUserViewController.h
//
//
//  
//

#import <UIKit/UIKit.h>
#import "GlobalTableProto.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "ActionRequest.h"

#import "IDentifyUModel.h"
@interface IDentifyUser :NSObject

@property (nonatomic, readwrite) NSString *theUserID;
@property (nonatomic, readwrite) NSString *theUserPW;
@property (nonatomic, readwrite) UIView *viewActive;
@property (nonatomic, readwrite) NSString *errorLocalDescr;
//@property (nonatomic, retain) ActionRequest *queryData;

-(BOOL)startValidateUserUsingView:(UIView *)thisView forUser:(NSString *)userStr andPW:(NSString *)pwStr withQueryData:(ActionRequest *)queryData;


@end
