//
//  ViewController.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NewsstandKit/NewsstandKit.h>
#import "MagazineManager.h"
#import "MagazineCell.h"
#import "MagazineCellDownloading.h"
#import "MagazineCellToDownload.h"
#import "MagazineCellSubscription.h"


typedef enum{
    ViewModeGrid,
    ViewModePage,
}ViewMode;

@interface ViewController : GAITrackedViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MagazineCellDelegate, MagazineCellDownloadingDelegate, MagazineCellToDownloadDelegate, MagazineCellSubscriptionDelegate, MagazineManagerBookcaseDelegate>
{
    int cellSizeWidth;
    int cellSizeHeight;
}

@property (weak, nonatomic) MagazineManager *manager;
@property (weak, nonatomic) NKLibrary *library;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gridViewBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pageViewBarButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *pageLayout;
@property (assign, nonatomic) ViewMode viewMode;
@property (strong, nonatomic) NSMutableSet *issuesPreparingForDownload;
@property (strong, nonatomic) NSMutableSet *issuesIsUnzipping;

- (IBAction)gridViewBarButtonPressed:(id)sender;
- (IBAction)pageViewBarButtonPressed:(id)sender;
- (IBAction)subscribeBarButtonPressed:(id)sender;

@end
