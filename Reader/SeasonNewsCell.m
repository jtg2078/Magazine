//
//  SeasonNewsCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/11.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "SeasonNewsCell.h"
#import "PlayMovieViewController.h"
#import "AppDelegate.h"

@implementation SeasonNewsCell
@synthesize myDic;

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
- (IBAction)playMovie:(id)sender {
   
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    PlayMovieViewController *movie=[[[PlayMovieViewController alloc] initWithData:myDic] autorelease];
    [appDelegate presentViewController:movie animated:YES];
}

-(void)update:(NSDictionary *)dic{
    myDic=dic;
    MagazineManager *manager = [MagazineManager sharedInstance];
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
    [_bImageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
    NSString *str=[dic objectForKey:@"videoUrl"];
    _playButton.center=CGPointMake([[dic objectForKey:@"x"] intValue], [[dic objectForKey:@"y"] intValue]);
    if ([str isEqualToString:@""]) {
        [_playButton setHidden:YES];
    }else{
        [_playButton setHidden:NO];
    }
}

- (void)dealloc {
    [_bImageView release];
    [_playButton release];
    [super dealloc];
}
@end
