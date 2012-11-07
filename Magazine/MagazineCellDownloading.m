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
@end
