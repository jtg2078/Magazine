//
//  WebViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/2.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageJump.h"

@interface WebViewController : UIViewController<UIWebViewDelegate>{
    NSArray *pageAry;
    id<PageJump> jumpDelegate;
    
    NSString *myUrl;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSArray *pageAry;
@property (retain, nonatomic) id<PageJump> jumpDelegate;
@property (retain, nonatomic) NSString *myUrl;

-(id)initWithAry:(NSArray *)ary;

@end
