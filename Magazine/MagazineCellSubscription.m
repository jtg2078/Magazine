//
//  MagazineCellSubscription.m
//  Magazine
//
//  Created by jason on 12/4/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineCellSubscription.h"

@implementation MagazineCellSubscription

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

- (IBAction)myButtonPressed:(id)sender
{
    [self.delegate subscribeToMagazine];
}

- (void)layoutSubviews
{
    MagazineManager *manager = [MagazineManager sharedInstance];
    if(manager.isFlowLayout)
    {
        self.myImageView.frame = CGRectMake(0, 0, 339, 245);
        self.myImageView.image = [UIImage imageNamed:@"subscriptionCell.png"];
        self.myButton.frame = CGRectMake(130, 130, 183, 37);
        [self.myButton setImage:[UIImage imageNamed:@"subscriptionBtnCell.png"]
                       forState:UIControlStateNormal];
    }
    else
    {
        self.myImageView.frame = CGRectMake(0, 0, 708, 900);
        self.myImageView.image = [UIImage imageNamed:@"subscriptionPage.png"];
        self.myButton.frame = CGRectMake(165, 640, 375, 74);
        [self.myButton setImage:[UIImage imageNamed:@"subscriptionBtnPage.png"]
                       forState:UIControlStateNormal];
    }
}

@end
