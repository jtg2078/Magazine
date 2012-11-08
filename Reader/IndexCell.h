//
//  IndexCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/4.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCell : UITableViewCell{
    int pageNo;
}

@property (retain, nonatomic) IBOutlet UIImageView *cellImageView;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UITextView *subtitle;
@property (assign, nonatomic) int pageNo;
@end
