//
//  StoresViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/19.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "StoresViewController.h"

@interface StoresViewController ()
    -(void)loadWebView;
@end

@implementation StoresViewController

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
    [self loadWebView];

}
-(void)loadWebView{
    // Do any additional setup after loading the view from its nib.
    //NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"stores" ofType:@"html" inDirectory:@"book"];
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSString *htmlFile = [manager.currentIssuePath stringByAppendingPathComponent:@"stores.html"];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    
    //NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"stores" ofType:@"html" inDirectory:@"book"]];
    NSURL *baseUrl = [NSURL fileURLWithPath:[manager.currentIssuePath stringByAppendingPathComponent:@"stores.html"]];
    
    [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [_closeButton release];
    [_prevButton release];
    [super dealloc];
}
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)webBack:(id)sender {
    [self loadWebView];
}
@end
