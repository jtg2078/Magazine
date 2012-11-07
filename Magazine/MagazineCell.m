//
//  MagazineCell.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineCell.h"

@implementation MagazineCell

- (void)commonInit
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (IBAction)deleteButtonPressed:(id)sender
{
    [self.delegate deleteIssue:self.myIndexPath];
}

- (IBAction)viewButtonPressed:(id)sender
{
    [self.delegate viewIssue:self.myIndexPath];
}

@end
