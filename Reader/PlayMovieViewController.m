//
//  PlayMovieViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/15.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "PlayMovieViewController.h"


@interface PlayMovieViewController ()

@end

@implementation PlayMovieViewController
@synthesize theMovie;
@synthesize myDic;

-(id)initWithData:(NSDictionary *)dic{
    self = [super initWithNibName:@"PlayMovieViewController" bundle:nil];
    if (self) {
        myDic=dic;
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
    MagazineManager *manager = [MagazineManager sharedInstance];
    //NSString *path = [[NSBundle mainBundle] pathForResource:[myDic objectForKey:@"videoUrl"] ofType:nil inDirectory:@"book"];
    NSString *path = [manager.currentIssuePath stringByAppendingPathComponent:[myDic objectForKey:@"videoUrl"]];
	theMovie=[[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
	;
	theMovie.scalingMode=MPMovieScalingModeAspectFit;
	[[theMovie view] setFrame: [_movieView bounds]];
	[_movieView addSubview:[theMovie view]];
	[theMovie play];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_movieView release];
    [super dealloc];
}
- (IBAction)close:(id)sender {
    [theMovie stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
