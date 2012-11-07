//
//  MagazineCell.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagazineCellDelegate<NSObject>
@required
- (void)deleteIssue:(NSIndexPath *)indexPath;
- (void)viewIssue:(NSIndexPath *)indexPath;
@end

@interface MagazineCell : UICollectionViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *magazineName;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *viewButton;
@property (strong, nonatomic) NSIndexPath *myIndexPath;
@property (weak, nonatomic) id<MagazineCellDelegate> delegate;

- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)viewButtonPressed:(id)sender;

@end
