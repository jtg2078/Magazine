//
//  BuyingNoteCell.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/7.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyingNoteCell : UITableViewCell<UIScrollViewDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UIImageView *bImageView;
@property (retain, nonatomic) IBOutlet UIImageView *scrollImage;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIButton *infoImageButton;
@property (retain, nonatomic) IBOutlet UIButton *infoButton;
- (IBAction)openInfo:(id)sender;
-(void)popImageDisplay:(BOOL)show;
-(void)setScrollDelegate;
@end
