//
//  MagazineCellSubscription.h
//  Magazine
//
//  Created by jason on 12/4/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagazineCellSubscriptionDelegate<NSObject>
@required
-(void)subscribeToMagazine;
@end

@interface MagazineCellSubscription : UICollectionViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) id<MagazineCellSubscriptionDelegate> delegate;

- (IBAction)myButtonPressed:(id)sender;


@end
