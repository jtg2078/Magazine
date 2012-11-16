//
//  MagazineCellDownloading.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagazineCellDownloadingDelegate<NSObject>
@required
- (void)pauseDownload:(NSIndexPath *)indexPath;
- (void)cancelDownload:(NSIndexPath *)indexPath;
@end

@interface MagazineCellDownloading : UICollectionViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *magazineName;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UIImageView *progressBarBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *progressBarImageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) NSIndexPath *myIndexPath;
@property (weak, nonatomic) id<MagazineCellDownloadingDelegate> delegate;

- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
