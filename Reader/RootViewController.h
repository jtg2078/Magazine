//
//  RootViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/10/23.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageJump.h"
#import "IndexCell.h"

@interface RootViewController : UIViewController<UIScrollViewDelegate,PageJump,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *pageAry;
    NSMutableArray *indexAry;
    int currentPage;
    NSMutableArray *historyAry;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIView *bgAlpha05;
@property (retain, nonatomic) IBOutlet UIView *indexView;
@property (retain, nonatomic) IBOutlet UIButton *dotButton;
@property (retain, nonatomic) IBOutlet UIButton *leftButton;
@property (retain, nonatomic) IBOutlet UIButton *rightButton;
@property (retain, nonatomic) IBOutlet UIView *preView;
@property (retain, nonatomic) IBOutlet UILabel *pageTitle;
@property (retain, nonatomic) IBOutlet UITextView *pageSubtitle;
@property (retain, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (retain, nonatomic) IBOutlet UIButton *indexButton;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSMutableArray *pageAry;
@property (retain, nonatomic) NSMutableArray *indexAry;
@property (retain, nonatomic) NSMutableArray *historyAry;
@property (assign, nonatomic) IBOutlet IndexCell *indexCell;
@property (retain, nonatomic) IBOutlet UIButton *historyButton;
@property (retain, nonatomic) IBOutlet UIButton *infoButton;
- (IBAction)prevPage:(id)sender;
- (IBAction)openStores:(id)sender;


- (void)touchDragInside:(id)sender withEvent:(UIEvent *)event;
- (IBAction)tapGesture:(id)sender;
- (IBAction)gotoPage:(id)sender;
- (IBAction)gotoLeft:(id)sender;
- (IBAction)gotoRight:(id)sender;
- (IBAction)showIndex:(id)sender;

@end
