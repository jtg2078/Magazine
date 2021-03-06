//
//  PageHViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/6.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageJump.h"

@interface PageHViewController : GAITrackedViewController<UIScrollViewDelegate> {
    NSArray *pageAry;
    id<PageJump> jumpDelegate;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) NSArray *pageAry;
@property (assign, nonatomic) id<PageJump> jumpDelegate;
@property (retain, nonatomic) IBOutlet UIView *pageNoView;
@property (retain, nonatomic) IBOutlet UILabel *currentPageNo;
@property (retain, nonatomic) IBOutlet UILabel *nextPageNo;
@property (retain, nonatomic) IBOutlet UIImageView *backImage;

-(id)initWithAry:(NSArray *)ary;
@end
