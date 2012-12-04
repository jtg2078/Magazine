//
//  CamperMapViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/14.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CamperMapViewController : GAITrackedViewController{
    NSArray *pageAry;
}

@property (retain, nonatomic) NSArray *pageAry;
@property (retain, nonatomic) IBOutlet UIImageView *backImage;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *scrollImage;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property (retain, nonatomic) IBOutlet UIScrollView *topScrollView;

- (IBAction)backTop:(id)sender;
- (IBAction)goPage:(id)sender;
-(id)initWithAry:(NSArray *)ary;
@end
