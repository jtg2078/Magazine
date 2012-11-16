//
//  MagazineCellToDownload.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineCellToDownload.h"

@implementation MagazineCellToDownload

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

- (IBAction)downloadButtonPressed:(id)sender
{
    [self.downloadButton setTitle:@"Preparing..." forState:UIControlStateNormal];
    [self.delegate downloadIssue:self.myIndexPath];
}

- (void)layoutSubviews
{
    MagazineManager *manager = [MagazineManager sharedInstance];
    if(manager.isFlowLayout)
    {
        self.coverImageView.frame = CGRectMake(20, 15, 157, 210);
        self.magazineName.frame = CGRectMake(191, 73, 73, 21);
        self.issueTitle.frame = CGRectMake(191, 94, 73, 21);
        self.downloadButton.frame = CGRectMake(191, 191, 124, 40);
    }
    else
    {
        self.coverImageView.frame = CGRectMake(92, 20, 517, 761);
        self.magazineName.frame = CGRectMake(92, 798, 73, 21);
        self.issueTitle.frame = CGRectMake(92, 822, 73, 21);
        self.downloadButton.frame = CGRectMake(493, 803, 124, 40);
    }
}

@end
