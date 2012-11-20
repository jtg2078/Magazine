//
//  VideoBtn.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/15.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "VideoBtn.h"

@implementation VideoBtn
@synthesize videoUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"video_b.png"] forState:UIControlStateNormal];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
