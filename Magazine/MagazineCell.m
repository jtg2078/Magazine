//
//  MagazineCell.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineCell.h"
#import "MagazineManager.h"

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

- (void)layoutSubviews
{
    MagazineManager *manager = [MagazineManager sharedInstance];
    if(manager.isFlowLayout)
    {
        self.coverImageView.frame = CGRectMake(20, 15, 157, 210);
        self.magazineName.frame = CGRectMake(191, 73, 73, 21);
        self.issueTitle.frame = CGRectMake(191, 94, 73, 21);
        self.viewButton.frame = CGRectMake(191, 143, 124, 40);
        self.deleteButton.frame = CGRectMake(191, 191, 124, 40);
    }
    else
    {
        self.coverImageView.frame = CGRectMake(92, 20, 517, 761);
        self.magazineName.frame = CGRectMake(92, 798, 73, 21);
        self.issueTitle.frame = CGRectMake(92, 822, 73, 21);
        self.viewButton.frame = CGRectMake(363, 803, 124, 40);
        self.deleteButton.frame = CGRectMake(493, 803, 124, 40);
    }
}

@end
