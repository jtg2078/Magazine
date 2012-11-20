//
//  PageCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/10.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface PageCell : BaseCell{
    
}
@property (retain, nonatomic) IBOutlet UIImageView *bImageView;

-(void)update:(NSDictionary *)dic;
@end
