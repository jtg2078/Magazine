//
//  SeasonNewsCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/11.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface SeasonNewsCell : BaseCell{
    
}
@property (retain, nonatomic) IBOutlet UIImageView *bImageView;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property(strong,nonatomic) NSDictionary *myDic;
- (IBAction)playMovie:(id)sender;
-(void)update:(NSDictionary *)dic;
@end
