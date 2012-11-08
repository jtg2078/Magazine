//
//  WebViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/2.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "WebViewController.h"
#import "YoutubeViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize pageAry;
@synthesize jumpDelegate;
@synthesize myUrl;


-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        // Custom initialization
        pageAry=ary;
    }
    return self;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dic=[pageAry objectAtIndex:0];
    
    //NSString *htmlFile = [[NSBundle mainBundle] --pathForResource:[dic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    
    MagazineManager *manager = [MagazineManager sharedInstance];
    
    NSString *htmlFile = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"file"]];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    
    //NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] --pathForResource:@"fashionshow_women" ofType:@"html" inDirectory:@"book"]];
    
    NSString *urlPath = [manager.currentIssuePath stringByAppendingPathComponent:@"fashionshow_women.html"];
    NSURL *baseUrl = [NSURL fileURLWithPath:urlPath];
    
    [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];
    [self.view addSubview:_webView];
    
    //UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 1024*i, 768, 1024)];
    //[imageView setImage:image];
    //[_scrollView addSubview:imageView];
    

    // Do any additional setup after loading the view from its nib.
}

- (BOOL)            webView: (UIWebView *) view
 shouldStartLoadWithRequest: (NSURLRequest *) req
             navigationType: (UIWebViewNavigationType) navType
{
    
    //NSLog(@"contentHeight:%f",contentHeight);
    NSLog(@"%@",[[req URL] host]);
    myUrl=[[req URL] host];
    NSString *hostStr=[[req URL] host];
    if([hostStr isEqualToString:@"www.youtube.com"] || [hostStr isEqualToString:@"player.vimeo.com"]){
        YoutubeViewController *youtube=[[YoutubeViewController alloc] initWithUrl:[[req URL] absoluteString]];
        [self presentViewController:youtube animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //NSLog(@"webViewDidStartLoad:%@",_url);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError:%@",error.description);
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
@end
