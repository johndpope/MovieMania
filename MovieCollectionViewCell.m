//
//  MovieCollectionViewCell.m
//  TVOSExample
//
//  Created by Christian Lysne on 13/09/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@implementation MovieCollectionViewCell

@synthesize posterView,titleLabel,indexPath,myButton;
-(id) init
{
    self = [super init];
    if (self) {
        
        
        GlobalTableProto *gtp = [GlobalTableProto sharedGlobalTableProto];
        self.contentView.frame=CGRectMake(0,0, gtp.sizeGlobalPoster.width,gtp.sizeGlobalPoster.height);
        self.posterView = [[UIView alloc] initWithFrame:self.contentView.frame];
    }
    return self;
}



@end
