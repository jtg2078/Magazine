//
//  IndexCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/4.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "IndexCell.h"

@implementation IndexCell
@synthesize pageNo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellImageView release];
    [_title release];
    [_subtitle release];
    [super dealloc];
}
@end
