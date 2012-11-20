//
//  BrandCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/8.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "BrandCell.h"

@implementation BrandCell
@synthesize myDic;
@synthesize scrollview;

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

- (IBAction)popDisplay:(id)sender {
    UIScrollView *_scrollview=[[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)] autorelease];
    self.scrollview=_scrollview;
    _scrollview=nil;
    
    self.scrollview.contentSize=CGSizeMake(2000, 1024);
    [self addSubview:self.scrollview];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[myDic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[myDic objectForKey:@"file"]];
    UIImageView *popImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2000, 1024)] autorelease];
    [popImageView setImage:[UIImage imageWithContentsOfFile:filename]];
    [self.scrollview addSubview:popImageView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(700, 10, 44, 44)];

    [closeButton setImage:[UIImage imageNamed:@"close_B.png"] forState:UIControlStateNormal];
                                                           
    [closeButton addTarget:self action:@selector(closePopDisplay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
}
-(void)closePopDisplay:(id)sender{
    [self.scrollview removeFromSuperview];
    [sender removeFromSuperview];
    
}

-(void)update:(NSDictionary *)dic{
    myDic=dic;
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[myDic objectForKey:@"backImage"]];
    [_bImageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
    
}

- (void)dealloc {
    [_bImageView release];
    [_infoButton release];

    [super dealloc];
}
@end
