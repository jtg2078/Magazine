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
@end
