//
//  BuyingNoteCell.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/7.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "BuyingNoteCell.h"

@implementation BuyingNoteCell

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

    [_bImageView release];
    [_scrollView release];
    [_scrollImage release];
    [_infoImageButton release];
    [_infoButton release];

    [super dealloc];
}

-(void)update:(NSDictionary *)dic{
    MagazineManager *manager = [MagazineManager sharedInstance];
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
    [_bImageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
    
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"file"]];
    [_scrollImage setImage:[UIImage imageWithContentsOfFile:filename]];
    _scrollView.contentSize=CGSizeMake(1190, 333);
    [_scrollView setContentOffset:CGPointMake(502, 0)];
    
    //NSString *infoFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"popImage"] ofType:nil inDirectory:@"book"];
    NSString *infoFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"popImage"]];
    [_infoImageButton setImage:[UIImage imageWithContentsOfFile:infoFilename] forState:UIControlStateNormal];
    _scrollView.delegate=self;
    [_infoImageButton setAlpha:0];
    
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self popImageDisplay:NO];
}

- (IBAction)openInfo:(id)sender {
    
    if(_infoImageButton.frame.origin.y<186){
        [self popImageDisplay:YES];
        [_scrollView setContentOffset:CGPointMake(502, 0) animated:YES];
    }else{
        [self popImageDisplay:NO];
    }
}

-(void)popImageDisplay:(BOOL)show{
    int viewY=-1024;
    int _alpha=0;
    if (show) {
        viewY=186;
        _alpha=1;
    }
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _infoImageButton.frame = CGRectMake(136, viewY, 447, 769);
                         [_infoImageButton setAlpha:_alpha];
                     }
                     completion:nil
     
     ];
}
@end
