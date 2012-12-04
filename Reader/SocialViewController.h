//
//  SocialViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/20.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialViewController : GAITrackedViewController{
    NSArray *pageAry;
}
@property (retain, nonatomic) NSArray *pageAry;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *scrollImage;
-(id)initWithAry:(NSArray *)ary;
 -(void)linkWebSite:(id)sender;
@end
