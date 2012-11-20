//
//  StoresViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/19.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresViewController : UIViewController<UIWebViewDelegate>{
    
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *prevButton;
- (IBAction)close:(id)sender;
- (IBAction)webBack:(id)sender;

@end
