//
//  MagazineCellToDownload.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MagazineCellToDownloadDelegate<NSObject>
@required
- (void)downloadIssue:(NSIndexPath *)indexPath;
@end

@interface MagazineCellToDownload : UICollectionViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *magazineName;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) NSIndexPath *myIndexPath;
@property (weak, nonatomic) id<MagazineCellToDownloadDelegate> delegate;

- (IBAction)downloadButtonPressed:(id)sender;

@end
