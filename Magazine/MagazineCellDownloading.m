//
//  MagazineCellDownloading.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineCellDownloading.h"

@implementation MagazineCellDownloading

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

- (IBAction)pauseButtonPressed:(id)sender
{
    [self.delegate pauseDownload:self.myIndexPath];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate cancelDownload:self.myIndexPath];
}

- (void)layoutSubviews
{
    MagazineManager *manager = [MagazineManager sharedInstance];
    if(manager.isFlowLayout)
    {
        self.coverImageView.frame = CGRectMake(20, 15, 157, 210);
        self.magazineName.frame = CGRectMake(191, 73, 73, 21);
        self.issueTitle.frame = CGRectMake(191, 94, 73, 21);
        self.progressBarBgImageView.frame = CGRectMake(191,152,117,8);
        self.progressBarImageView.frame = CGRectMake(191, 152, 1, 8);
        self.progressLabel.frame = CGRectMake(191, 162, 117, 21);
        self.pauseButton.frame = CGRectMake(185, 191, 73, 40);
        self.cancelButton.frame = CGRectMake(250, 191, 73, 40);
    }
    else
    {
        self.coverImageView.frame = CGRectMake(92, 20, 517, 761);
        self.magazineName.frame = CGRectMake(92, 798, 73, 21);
        self.issueTitle.frame = CGRectMake(92, 822, 73, 21);
        self.progressBarBgImageView.frame = CGRectMake(340, 807,117,8);
        self.progressBarImageView.frame = CGRectMake(340, 807, 1, 8);
        self.progressLabel.frame = CGRectMake(340, 817, 117, 21);
        self.pauseButton.frame = CGRectMake(484, 803, 73, 40);
        self.cancelButton.frame = CGRectMake(549, 803, 73, 40);
    }
}

@end
