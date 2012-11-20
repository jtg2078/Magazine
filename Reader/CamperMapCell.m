//
//  CamperMapCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/14.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "CamperMapCell.h"

@implementation CamperMapCell

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
    
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"file"]];
    [_bImageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
    [_scrollImage setImage:[UIImage imageWithContentsOfFile:filename]];
    _scrollView.contentSize=CGSizeMake(1307, 924);
    //[_scrollView setContentOffset:CGPointMake(570, 0)];
    

}

- (void)dealloc {
    [_bImageView release];
    [_scrollView release];
    [_scrollImage release];
    [super dealloc];
}
@end
