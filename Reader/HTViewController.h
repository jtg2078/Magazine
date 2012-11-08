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



@interface HTViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *pageAry;
}

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (assign, nonatomic) IBOutlet BuyingNoteCell *buyingNoteCell;
@property (assign, nonatomic) IBOutlet BrandCell *brandCell;

@property (retain, nonatomic) NSArray *pageAry;

-(id)initWithAry:(NSArray *)ary;
@end
