//
//  HTViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/7.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyingNoteCell.h"
#import "BrandCell.h"
#import "PageCell.h"
#import "SeasonNewsCell.h"
#import "CamperMapCell.h"




@interface HTViewController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *pageAry;
    NSArray *typeAry;
    NSString *type;
}

@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (assign, nonatomic) IBOutlet BuyingNoteCell *buyingNoteCell;
@property (assign, nonatomic) IBOutlet BrandCell *brandCell;
@property (assign, nonatomic) IBOutlet PageCell *pageCell;
@property (assign, nonatomic) IBOutlet SeasonNewsCell *seasonNewsCell;
@property (assign, nonatomic) IBOutlet CamperMapCell *camperCell;



@property (retain, nonatomic) IBOutlet UIView *pageNoView;
@property (retain, nonatomic) IBOutlet UILabel *currentPageNo;
@property (retain, nonatomic) IBOutlet UILabel *nextPageNo;

@property (retain, nonatomic) NSArray *pageAry;
@property (retain, nonatomic) NSArray *typeAry;
@property (retain, nonatomic) NSString *type;


-(id)initWithAry:(NSArray *)ary;
@end
