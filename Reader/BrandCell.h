//
//  BrandCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/8.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface BrandCell : BaseCell{
    NSDictionary *myDic;
    UIScrollView *scrollview;
    
}
@property (retain, nonatomic) NSDictionary *myDic;
@property (retain, nonatomic) IBOutlet UIImageView *bImageView;
@property (retain, nonatomic) IBOutlet UIButton *infoButton;
@property (assign, nonatomic) UIScrollView *scrollview;

- (IBAction)popDisplay:(id)sender;
-(void)update:(NSDictionary *)dic;
-(void)closePopDisplay:(id)sender;
@end
