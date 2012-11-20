//
//  YoutubeViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/5.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YoutubeViewController : UIViewController<UIWebViewDelegate>{
    
    NSString *myURL;
    
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (retain, nonatomic) NSString *myURL;


-(id)initWithUrl:(NSString *)url;

- (IBAction)close:(id)sender;

@end
