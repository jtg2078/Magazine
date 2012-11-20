//
//  FashionShowViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/15.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "FashionShowViewController.h"
#import "YoutubeViewController.h"
#import "VideoBtn.h"

@interface FashionShowViewController ()
   
@end

@implementation FashionShowViewController
@synthesize pageAry;


-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"FashionShowViewController" bundle:nil];
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
    // Do any additional setup after loading the view from its nib.
    NSDictionary *dic=[pageAry objectAtIndex:1];
    int pageWidth=[[dic objectForKey:@"width"] intValue];
    int pageHeight=[[dic objectForKey:@"height"] intValue];
    _scrollImage.frame=CGRectMake(0, 0, pageWidth, pageHeight);
    if(![[dic objectForKey:@"backImage"] isEqualToString:@""]){
        //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
        MagazineManager *manager = [MagazineManager sharedInstance];
        NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
        [_scrollImage setImage:[UIImage imageWithContentsOfFile:backFilename]];
    }
    _scrollView.contentSize=CGSizeMake(pageWidth, pageHeight);
    
    for (int i=2; i<[pageAry count]; i++) {
        
         NSDictionary *dic=[pageAry objectAtIndex:i];
        VideoBtn *videoBt=[[[VideoBtn alloc] initWithFrame:CGRectMake([[dic objectForKey:@"x"] intValue]-27, [[dic objectForKey:@"y"] intValue]-32, 54, 65)] autorelease];
        videoBt.videoUrl=[dic objectForKey:@"videoUrl"];
        [_scrollView addSubview:videoBt];
        
        [videoBt addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        

    }

}
-(void)playVideo:(VideoBtn *)sender{
    YoutubeViewController *youtube=[[[YoutubeViewController alloc] initWithUrl:sender.videoUrl] autorelease];
    [self presentViewController:youtube animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_scrollView release];
    [_scrollImage release];
    [super dealloc];
}
@end
