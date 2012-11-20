//
//  PageCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/10.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "PageCell.h"

@implementation PageCell

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
-(void)update:(NSDictionary *)dic{
    MagazineManager *manager = [MagazineManager sharedInstance];
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
    [_bImageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
}

- (void)dealloc {
    [_bImageView release];

    [super dealloc];
}
@end
