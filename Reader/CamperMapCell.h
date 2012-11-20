//
//  CamperMapCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/14.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface CamperMapCell : BaseCell{
    
}
@property (retain, nonatomic) IBOutlet UIImageView *bImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *scrollImage;
-(void)update:(NSDictionary *)dic;

@end
