//
//  YoutubeViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/5.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "YoutubeViewController.h"
#import "AppDelegate.h"

@interface YoutubeViewController ()

@end

@implementation YoutubeViewController
@synthesize myURL;


-(id)initWithUrl:(NSString *)url{
    
    self = [super initWithNibName:@"YoutubeViewController" bundle:nil];
    if (self) {
        myURL=url;
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
    
    //NSString *pathStr= [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //_url=[[NSString stringWithString:pathStr] retain];
    //<iframe width="640" height="480" src="http://www.youtube.com/embed/qelzu1wDCIU" frameborder="0" allowfullscreen></iframe>
    
    NSURL* url = [NSURL URLWithString:myURL];
    NSURLRequest* urlReq = [ NSURLRequest requestWithURL:url ];
    [_webView loadRequest: urlReq ];

    // Do any additional setup after loading the view from its nib.
}
- (BOOL)            webView: (UIWebView *) view
 shouldStartLoadWithRequest: (NSURLRequest *) req
             navigationType: (UIWebViewNavigationType) navType
{
    
    NSLog(@"%@",[[req URL] absoluteString]);
    return YES;
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
