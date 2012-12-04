//
//  SocialViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/20.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "SocialViewController.h"
#import "WebViewController.h"
#import "LinkBtn.h"

@interface SocialViewController ()

@end

@implementation SocialViewController
@synthesize pageAry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"FashionShowViewController" bundle:nil];
    if (self) {
        // Custom initialization
        pageAry=ary;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.trackedViewName = NSStringFromClass([self class]);
    NSDictionary *dic=[pageAry objectAtIndex:1];
    int pageWidth=[[dic objectForKey:@"width"] intValue];
    int pageHeight=[[dic objectForKey:@"height"] intValue];
    _scrollImage.frame=CGRectMake(0, 0, pageWidth, pageHeight);
    if(![[dic objectForKey:@"backImage"] isEqualToString:@""]){
        MagazineManager *manager = [MagazineManager sharedInstance];
        //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
        NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
        [_scrollImage setImage:[UIImage imageWithContentsOfFile:backFilename]];
    }
    _scrollView.contentSize=CGSizeMake(pageWidth, pageHeight);
    
    for (int i=2; i<[pageAry count]; i++) {
        
        NSDictionary *dic=[pageAry objectAtIndex:i];
        LinkBtn *linkBtn=[[[LinkBtn alloc] initWithFrame:CGRectMake([[dic objectForKey:@"x"] intValue], [[dic objectForKey:@"y"] intValue], 180, 40)] autorelease];
        linkBtn.urlStr=[dic objectForKey:@"link"];
        [_scrollView addSubview:linkBtn];
        
        [linkBtn addTarget:self action:@selector(linkWebSite:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    

}

-(void)linkWebSite:(LinkBtn *)sender{
    WebViewController *webSite=[[[WebViewController alloc] initWithUrl:sender.urlStr] autorelease];
    [self presentViewController:webSite animated:YES completion:nil];
    NSLog(@"%@",sender.urlStr);
    
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
