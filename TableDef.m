
//
//  CellTextDef.m
//  tableProto
//
//  Created by Myra Hambleton on 2/24/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import "TableDef.h"

#import "Transaction.h"

@implementation TableDef


@synthesize tableHeaderContentPtr;
@synthesize tableFooterContentPtr;

@synthesize  titleOpaque;
@synthesize tvcCreatedHeight,tvcCreatedWidth;
@synthesize tableSections;


@synthesize tableHeaderFixed,fixedTableFooterUIView,fixedTableHeaderUIView;
@synthesize tableFooterFixed;
@synthesize initialDraw;


@synthesize cellDispPrepared;  //true if cell initialization and allocation complete for table display

@synthesize dbAllTabTransDict,tableVariablesArray;
@synthesize tableDisplayFirstVisibleNotification,autoXACTarray;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Initialize
/////////////////////////////////////////
-(void) killYourself
{
    [self.tableFooterContentPtr killYourself];
    [self.tableHeaderContentPtr killYourself];
    for (int i=0; i<[self.tableSections count]; i++) {
        [[self.tableSections objectAtIndex:i] killYourself];
    }

    self.tableSections=nil;
    cellDispPrepared=FALSE;
    
    for(id key in self.dbAllTabTransDict) {
        Transaction *value = [self.dbAllTabTransDict objectForKey:key];
        [value killYourself];
    }
    [self.dbAllTabTransDict removeAllObjects];
    self.dbAllTabTransDict=nil;
    if (tableVariablesArray) {
        for (int i=0; i< [tableVariablesArray count]; i++) {
            [[tableVariablesArray objectAtIndex:i] killYourself];
        }
        tableVariablesArray=nil;
    }
    
    if (autoXACTarray) {
        for (int i=0; i< [autoXACTarray count]; i++) {
            [[autoXACTarray objectAtIndex:i] killYourself];
        }
        [autoXACTarray removeAllObjects]; //needed?
        autoXACTarray=nil;
    }
    
    

    
}

-(id) init
{
    self = [super init];
    if (self) {
        
        [self makeUseDefaults:self];
    }
    return self;
}
-(void) makeUseDefaults:(TableDef *)nTableDef
{
    initialDraw=YES;
    nTableDef.tableDisplayFirstVisibleNotification=FALSE;    //has runtime been notified yet?

    nTableDef.dbAllTabTransDict=[[NSMutableDictionary alloc] init];
    nTableDef.tableHeaderContentPtr=[[CellContentDef alloc]init];
    nTableDef.tableHeaderContentPtr.ccCellTypePtr=[CellTextDef initCellForTitleDefaults];
    nTableDef.tableFooterContentPtr=[[CellContentDef alloc]init];
    nTableDef.tableFooterContentPtr.ccCellTypePtr=[CellTextDef initCellForTitleDefaults];
    nTableDef.titleOpaque=YES;

    nTableDef.tableSections=[[NSMutableArray alloc]init];
    nTableDef.cellDispPrepared=FALSE;
    
    nTableDef.tableFooterFixed=FALSE;
    nTableDef.tableHeaderFixed=FALSE;
 nTableDef.tableVariablesArray=[[NSMutableArray alloc]init];
    nTableDef.autoXACTarray=[[NSMutableArray alloc]init]; //array of AutoXACT

}

+ (TableDef *)initTableDefDefaults
{
     /*    loadView
    CGRect titleRect = CGRectMake(0, 0, 300, 40);
    UILabel *tableTitle = [[UILabel alloc] initWithFrame:titleRect];
    tableTitle.textColor = [UIColor blueColor];
    tableTitle.backgroundColor = [self.tableView backgroundColor];
    tableTitle.opaque = YES;
    tableTitle.font = [UIFont boldSystemFontOfSize:18];
    tableTitle.text = [curTrail objectForKey:@"Name"];
    self.tableView.tableHeaderView = tableTitle;
    [self.tableView reloadData];
    */
    TableDef* nTableDef=[[TableDef alloc]init];
    [nTableDef makeUseDefaults:nTableDef];
    return nTableDef;
}


+ (TableDef *)initTableHeaderImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    TableDef* nTableDef=[[TableDef alloc]init];   //init sets defaults too
    
    [nTableDef.tableHeaderContentPtr killYourself];
    nTableDef.tableHeaderContentPtr=nil;
    nTableDef.tableHeaderContentPtr=[[CellContentDef alloc]init];
    nTableDef.tableHeaderContentPtr.ccCellTypePtr=[CellImageOnly initCellForTitleDefaults:nil withPNGName:imageName withBackColor:backColor rotateWhenVisible:FALSE];
        

    [nTableDef.tableFooterContentPtr.ccCellTypePtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    
    
    
    return nTableDef;
    
    
}
+ (TableDef *)initTableHeaderROTateImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    TableDef* nTableDef=[[TableDef alloc]init];   //init sets defaults too
    
    [nTableDef.tableHeaderContentPtr killYourself];
    nTableDef.tableHeaderContentPtr=[[CellContentDef alloc]init];  //replace text type with rotating image
    
    
    nTableDef.tableHeaderContentPtr.ccCellTypePtr=[CellImageOnly initCellForTitleDefaults:nil withPNGName:imageName withBackColor:backColor rotateWhenVisible:TRUE];

    
    
    [nTableDef.tableFooterContentPtr.ccCellTypePtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    
    
    
    return nTableDef;
    
    
}
+ (TableDef *)initTableHeaderANDfooterROTateImageName:(NSString*)imageName  withBackgroundColor:(UIColor*)backColor  footerImageName:(NSString*)footerImageName  withFooterBackgroundColor:(UIColor*)footerBackColor
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    TableDef* nTableDef=[[TableDef alloc]init];   //init sets defaults too
    
    [nTableDef.tableHeaderContentPtr killYourself];
    nTableDef.tableHeaderContentPtr=[[CellContentDef alloc]init];  //replace text type with rotating image
    nTableDef.tableHeaderContentPtr.ccCellTypePtr=[CellImageOnly initCellForTitleDefaults:nil withPNGName:imageName withBackColor:backColor rotateWhenVisible:TRUE];
    
    [nTableDef.tableFooterContentPtr killYourself];
    nTableDef.tableFooterContentPtr=[[CellContentDef alloc]init];
    nTableDef.tableFooterContentPtr.ccCellTypePtr=[CellImageOnly initCellForTitleDefaults:nil withPNGName:footerImageName withBackColor:footerBackColor rotateWhenVisible:TRUE];
    
  
    
    
    
    
    return nTableDef;
    
    
}



+ (TableDef *)initTableBothImageDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName withTheImage:(UIImage *) actualImage withImageName:(NSString*)imageName  withImageBackgroundColor:(UIColor*)imageBackColor
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    TableDef* nTableDef=[[TableDef alloc]init];   //init sets defaults too, assumes text type
    
    [nTableDef.tableHeaderContentPtr killYourself];  //replace text type with image+text
    nTableDef.tableHeaderContentPtr=[[CellContentDef alloc]init];
    

    nTableDef.tableHeaderContentPtr.ccCellTypePtr =[CellImageLTextR initCellWithImageAndText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName withImage:actualImage withImageName:imageName withImageBackColor:imageBackColor];
 
    
    [nTableDef.tableFooterContentPtr.ccCellTypePtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    
    
    
    return nTableDef;

    
    
    
    
}




+ (TableDef *)initTableDefText:(NSString*)txt withTextColor:(UIColor*)textClr withBackgroundColor:(UIColor*)backColor withTextFontSize:(int)txtFontSize withTextFontName:(NSString*)txtFontName footerText:(NSString*)footerTxt withFooterTextColor:(UIColor*)footerTextClr withFooterBackgroundColor:(UIColor*)footerBackColor withFooterTextFontSize:(int)footerTxtFontSize withFooterTextFontName:(NSString*)footerTxtFontName
{
    
    //SET NON-NIL values Sent.  Otherwise defaults are used
    
    TableDef* nTableDef=[[TableDef alloc]init];   //init sets defaults too
    
    
    [nTableDef.tableHeaderContentPtr.ccCellTypePtr updateCellText:txt withTextColor:textClr withBackgroundColor:backColor withTextFontSize:txtFontSize withTextFontName:txtFontName];
    [nTableDef.tableFooterContentPtr.ccCellTypePtr updateCellText:footerTxt withTextColor:footerTextClr withBackgroundColor:footerBackColor withTextFontSize:footerTxtFontSize withTextFontName:footerTxtFontName];
    
    
    
     
    return nTableDef;

    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Access Methods
/////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Display Methods
/////////////////////////////////////////
-(BOOL) cellCanOwnFocusThisRow:(int)thisRow andSection:(int) thisSection
{//my cell can recv focus message if it doesn't contain a button.
    //if it contains a button, the scroll view has to handle all the focus messages
    //this only shows up in TVOS
    SectionDef *sectionPtr;
    sectionPtr=[self.tableSections  objectAtIndex:thisSection];
    
    if (!sectionPtr) {
        return YES;
    }
    
    
    CellContentDef *sectionCellsPtr;
    sectionCellsPtr=[sectionPtr.sCellsContentDefArr objectAtIndex:thisRow];
    if (!sectionCellsPtr) {
        return YES;
    }
    if([sectionCellsPtr.ccCellTypePtr isKindOfClass:[CellButtonsScroll class]]){
        return NO;
    }
    return YES;
    
}


-(void) showMeInDisplay:(UITableViewController *) tvc   tvcCreatedWidth:(int)createdWidth  tvcCreatedHeight:(int)createdHeight
{
    
    //Make returned UIViews the header and footer for the table
    
    
    self.tvcCreatedWidth=createdWidth;
    self.tvcCreatedHeight=createdHeight;   //all scrollable, no fixed header or footer
    
    UIView *returnedHeaderUIView=[self.tableHeaderContentPtr.ccCellTypePtr putMeVisibleMaxWidth:createdWidth maxHeight:createdHeight withTVC:tvc];
    
//***HEADER
    
    if (self.tableHeaderFixed) { //already displayed as fixed UIView
       
        NSLog(@"origin %@",NSStringFromCGPoint(returnedHeaderUIView.frame.origin) );
        self.fixedTableHeaderUIView=returnedHeaderUIView;
        tvc.tableView.tableHeaderView=nil;
       // self.tvcCreatedWidth=createdWidth;
       // self.tvcCreatedHeight=createdHeight-returnedHeaderUIView.frame.size.height;
        
        
        
        
        
    }
    else{
        
        tvc.tableView.tableHeaderView=returnedHeaderUIView;

    }
    
    
 UIView *returnedFooterUIView=[self.tableFooterContentPtr.ccCellTypePtr putMeVisibleMaxWidth:createdWidth maxHeight:createdHeight withTVC:tvc];
    
//****FOOTER
    if (self.tableFooterFixed) {    //already displayed as fixed UIView
        tvc.tableView.tableFooterView= nil;
        self.fixedTableFooterUIView=returnedFooterUIView;
       // self.tvcCreatedWidth=createdWidth;
       // self.tvcCreatedHeight=createdHeight-returnedFooterUIView.frame.size.height;
        

    }
    else{
        
        tvc.tableView.tableFooterView=returnedFooterUIView;
        

    }
    self.tvcCreatedWidth=createdWidth;
    self.tvcCreatedHeight=createdHeight-returnedFooterUIView.frame.size.height-returnedHeaderUIView.frame.size.height;
    //what is tvcCreatedHeight, tvcCreatedWidth
    
    
    if (initialDraw) {
        initialDraw=NO;
        [tvc.tableView reloadData];
        
    }
    else{
        NSIndexPath *tmpIndexpath=[NSIndexPath indexPathForRow:0 inSection:1];
        
        
        [tvc.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:tmpIndexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
    
     
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Debug Methods
/////////////////////////////////////////


@end
