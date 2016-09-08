//
//  DetailViewController.h
//  HDI_iOS_Client
//
//  Created by Myra Hambleton on 4/13/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

