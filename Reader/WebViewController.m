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
@synthesize myURL;


-(id)initWithUrl:(NSString *)url{
    
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        myURL=url;
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
    
    self.trackedViewName = NSStringFromClass([self class]);
    
    NSURL* url = [NSURL URLWithString:myURL];
    NSURLRequest* urlReq = [ NSURLRequest requestWithURL:url ];
    [_webView loadRequest: urlReq ];
}

- (BOOL)            webView: (UIWebView *) view
 shouldStartLoadWithRequest: (NSURLRequest *) req
             navigationType: (UIWebViewNavigationType) navType
{
    
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
    [_closeButton release];
    [super dealloc];
}
- (IBAction)close:(id)sender {
    [_webView loadHTMLString:@"x" baseURL:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

