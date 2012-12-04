//
//  CamperMapViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/14.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "CamperMapViewController.h"

@interface CamperMapViewController ()

@end

@implementation CamperMapViewController
@synthesize pageAry;


-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"CamperMapViewController" bundle:nil];
    if (self) {
        // Custom initialization
        pageAry=ary;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = NSStringFromClass([self class]);
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSDictionary *dic=[pageAry objectAtIndex:1];
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
    [_backImage setImage:[UIImage imageWithContentsOfFile:backFilename]];
    
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"file"]];
    [_scrollImage setImage:[UIImage imageWithContentsOfFile:filename]];
    _scrollView.contentSize=CGSizeMake(1307, 924);
    _topScrollView.contentSize=CGSizeMake(768, 2048);

}

- (IBAction)backTop:(id)sender {
    [_topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)goPage:(id)sender {
    int sn=2;
    if (sender==_btn1) {
        sn=2;
    }else if(sender==_btn2){
        sn=3;
    }else if(sender==_btn3){
        sn=4;
    }else{
        sn=5;
    }
    NSDictionary *dic=[pageAry objectAtIndex:sn];
    //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
    [_imageView setImage:[UIImage imageWithContentsOfFile:backFilename]];
    
    [_topScrollView setContentOffset:CGPointMake(0, 1024) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_backImage release];
    [_scrollView release];
    [_scrollImage release];
    [_backButton release];
    [_imageView release];
    [_btn1 release];
    [_bottomView release];
    [_topScrollView release];
    [_btn2 release];
    [_btn3 release];
    [_btn4 release];
    [super dealloc];
}
@end
