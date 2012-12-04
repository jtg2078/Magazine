//
//  ViewController.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "ViewController.h"
#import "MagazineFooterView.h"
#import "SVProgressHUD.h"
#import "SSZipArchive.h"
#import "RootViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // -------------------- google analytics --------------------
    
    self.trackedViewName = @"Bookcase";
    
    // -------------------- manager --------------------
    
    self.manager = [MagazineManager sharedInstance];
    self.manager.bookcaseDelegate = self;
    
    // -------------------- collection view --------------------
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_bookshelf.png"]];
    self.collectionView.backgroundView = bg;
    
    // -------------------- flow layout --------------------
    
    cellSizeWidth = 339;
    cellSizeHeight = 245;
    
    self.flowLayout.itemSize = CGSizeMake(cellSizeWidth, cellSizeHeight);
    self.flowLayout.minimumInteritemSpacing = 30;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // -------------------- page layout --------------------
    
    cellSizeWidth = 768 - 60;
    cellSizeHeight = 960 - 60;
    
    self.pageLayout = [[UICollectionViewFlowLayout alloc] init];
    self.pageLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.pageLayout.itemSize = CGSizeMake(cellSizeWidth, cellSizeHeight);
    self.pageLayout.minimumLineSpacing = 60;
    self.pageLayout.sectionInset = UIEdgeInsetsMake(0, 38, 0, 38);
    
    // -------------------- tool bar --------------------
    
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView_selected.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView.png"];
    
    // -------------------- app state --------------------
    
    self.viewMode = ViewModeGrid;
    self.library = [NKLibrary sharedLibrary];
    self.issuesPreparingForDownload = [NSMutableSet set];
    self.issuesIsUnzipping = [NSMutableSet set];
    
    // -------------------- loading catalog --------------------
    
    [SVProgressHUD showWithStatus:@"Getting catalog list..."];
    [self.manager getIssuesListSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"Success!"];
        [self.collectionView reloadData];
        
    } failure:^(NSString *reason, NSError *error) {
        [SVProgressHUD showErrorWithStatus:reason];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    [super viewWillDisappear:animated];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - user action

- (IBAction)gridViewBarButtonPressed:(id)sender
{
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView_selected.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView.png"];
    self.manager.isFlowLayout = YES;
    
    [self.collectionView setCollectionViewLayout:self.flowLayout animated:YES];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionView.backgroundView.alpha = 1.0f;
    }];
}

- (IBAction)pageViewBarButtonPressed:(id)sender
{
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView_selected.png"];
    self.manager.isFlowLayout = NO;
    
    [self.collectionView setCollectionViewLayout:self.pageLayout animated:YES];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if([self.manager numberOfIssues] + 1 >= 2)
    {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionView.backgroundView.alpha = 0.0f;
    }];
}

- (IBAction)subscribeBarButtonPressed:(id)sender
{
    [self handleSubscriptionButtonPressed];
}

- (void)handleSubscriptionButtonPressed
{
    [self.manager processSubscription];
}

- (void)gotoViewer:(NSIndexPath *)indexPath
{
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    NKIssue *issue = [self.library issueWithName:issueName];
    self.manager.currentIssuePath = [[self.manager downloadPathForIssue:issue] stringByAppendingPathComponent:@"book"];
    
    [self.manager setCurrentIssue:issueName];
    [self.manager markIssueRead:issueName];
    
    if(DEVELOPMENT_MODE == YES)
    {
        self.manager.currentIssuePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"book"];
        
        NSLog(@"path: %@", self.manager.currentIssuePath);
    }
    
    RootViewController *rvc = [[RootViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = [self.manager numberOfIssues];
    return num;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        MagazineCellSubscription *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MagazineCellSubscription"
                                                                       forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    NKIssue *issue = [self.library issueWithName:issueName];
    NSString *magazineName = @"團團誌";
    NSString *issueTitle = [self.manager titleOfIssueAtIndex:indexPath.row];
    
    if(issue.status == NKIssueContentStatusNone)
    {
        MagazineCellToDownload *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MagazineCellToDownload"
                                                                     forIndexPath:indexPath];
        cell.magazineName.text = magazineName;
        cell.issueTitle.text = issueTitle;
        cell.myIndexPath = indexPath;
        cell.delegate = self;
        
        if([self.issuesPreparingForDownload containsObject:indexPath] == YES)
            [cell.downloadButton setTitle:@"Preparing..." forState:UIControlStateNormal];
        else
            [cell.downloadButton setTitle:@"Download" forState:UIControlStateNormal];
        
        [self.manager setCoverOfIssueAtIndex:indexPath.row completionBlock:^(UIImage *img) {
            cell.coverImageView.image = img;
        }];
        
        return cell;
    }
    else if(issue.status == NKIssueContentStatusDownloading)
    {
        MagazineCellDownloading *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MagazineCellDownloading"
                                                                      forIndexPath:indexPath];
        cell.magazineName.text = magazineName;
        cell.issueTitle.text = issueTitle;
        cell.myIndexPath = indexPath;
        cell.delegate = self;
        
        if([self.issuesIsUnzipping containsObject:indexPath] == YES)
        {
            cell.progressLabel.text = @"Processing...";
            cell.cancelButton.enabled = NO;
        }
        else
        {
            cell.progressLabel.text = @"";
            cell.cancelButton.enabled = YES;
        }
        
        CGRect rect = cell.progressBarImageView.frame;
        rect.size.width = 0;
        cell.progressBarImageView.frame = rect;
        
        [self.manager setCoverOfIssueAtIndex:indexPath.row completionBlock:^(UIImage *img) {
            cell.coverImageView.image = img;
        }];
        
        return cell;
    }
    else if(issue.status == NKIssueContentStatusAvailable)
    {
        MagazineCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MagazineCell"
                                                           forIndexPath:indexPath];
        cell.magazineName.text = magazineName;
        cell.issueTitle.text = issueTitle;
        cell.myIndexPath = indexPath;
        cell.delegate = self;
        
        [self.manager setCoverOfIssueAtIndex:indexPath.row completionBlock:^(UIImage *img) {
            cell.coverImageView.image = img;
        }];
        
        return cell;
    }
    
    return nil;
}

/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    MagazineFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                        withReuseIdentifier:@"MagazineFooterView"
                                                                               forIndexPath:indexPath];
    return footerView;
}
 */

/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 200;
}
 */

#pragma mark - cell configuration


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
}

#pragma mark - UICollectionViewDelegateFlowLayout

/*
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(cellSizeWidth, cellSizeHeight);
    return size;
}
 */

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 20, 30, 20);
}
 */

#pragma mark - MagazineCellSubscriptionDelegate

- (void)subscribeToMagazine
{
    [self handleSubscriptionButtonPressed];
}

#pragma mark - MagazineCellDelegate

- (void)deleteIssue:(NSIndexPath *)indexPath
{
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    [self.manager removeDownloadedIssue:issueName];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

- (void)viewIssue:(NSIndexPath *)indexPath
{
    [SVProgressHUD showWithStatus:@"讀取中"];
    
    [self performSelector:@selector(gotoViewer:) withObject:indexPath afterDelay:0.5];
}

#pragma mark - MagazineCellDownloadingDelegate

- (void)pauseDownload:(NSIndexPath *)indexPath
{
    
}

- (void)cancelDownload:(NSIndexPath *)indexPath
{
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    [self.manager removeDownloadedIssue:issueName];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

#pragma mark - MagazineCellToDownloadDelegate

- (void)downloadIssue:(NSIndexPath *)indexPath
{
    if([self.manager checkAvailableDiskSpace] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"無法下載, 您的iPad可用空間不足"];
        return;
    }
    
    // Because it would take some noticable time before download progress reports in
    id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if([cell isKindOfClass:[MagazineCellToDownload class]] == YES)
    {
        MagazineCellToDownload *downloadCell = (MagazineCellToDownload *)cell;
        [downloadCell.downloadButton setTitle:@"Preparing..." forState:UIControlStateNormal];
    }
    
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    
    [self.manager downloadIssue:issueName
                      indexPath:indexPath];
    
    [self.issuesPreparingForDownload addObject:indexPath];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - MagazineManagerBookcaseDelegate

- (void)downloadingProgressForIndexPath:(NSIndexPath *)indexPath
                           didWriteData:(long long)bytesWritten
                      totalBytesWritten:(long long)totalBytesWritten
                     expectedTotalBytes:(long long)expectedTotalBytes
{
    id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if(cell == nil)
        return;
    
    if([cell isKindOfClass:[MagazineCellDownloading class]] == YES)
    {
        MagazineCellDownloading *downloadingCell = (MagazineCellDownloading *)cell;
        
        float percentage = 0;
        if(expectedTotalBytes)
            percentage = 1.f * totalBytesWritten / expectedTotalBytes;
        CGRect progressBarRect = downloadingCell.progressBarImageView.frame;
        progressBarRect.size.width = percentage * 117.0f;
        downloadingCell.progressBarImageView.frame = progressBarRect;
        
        float downloadedInMB = 1.f * totalBytesWritten / 1000000;
        float totalMB = 1.f * expectedTotalBytes / 1000000;
        
        NSString *downloadedInMBString = [NSString stringWithFormat:@"%.2f", downloadedInMB];
        NSString *totalMBString = [NSString stringWithFormat:@"%.2f", totalMB];
        
        downloadingCell.progressLabel.text = [NSString stringWithFormat:@" %@ MB / %@ MB", downloadedInMBString, totalMBString];
        
        if([downloadedInMBString isEqualToString:totalMBString] == YES)
        {
            downloadingCell.progressLabel.text = @"Processing...";
            [self.issuesIsUnzipping addObject:indexPath];
        }
    }
    else
    {
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
        // since the cell is already in downloading state, remove it from preparing download state
        [self.issuesPreparingForDownload removeObject:indexPath];
    }
}

- (void)downloadingResumedForIndexPath:(NSIndexPath *)indexPath
                     totalBytesWritten:(long long)totalBytesWritten
                    expectedTotalBytes:(long long)expectedTotalBytes
{
    
}

- (void)downloadingFinishedForIndexPath:(NSIndexPath *)indexPath
                                  issue:(NKIssue *)issue
                         destinationURL:(NSURL *)destinationURL
{
    id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if(cell == nil)
        return;
    
    if([cell isKindOfClass:[MagazineCellDownloading class]] == YES)
    {
        MagazineCellDownloading *downloadingCell = (MagazineCellDownloading *)cell;
        downloadingCell.progressLabel.text = @"Processing...";
        downloadingCell.cancelButton.enabled = NO;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *zipPath = [destinationURL path];
            NSString *destinationPath = [self.manager downloadPathForIssue:issue];
            
            [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                NSLog(@"Unzipping process is time out in background task mode: %@", destinationPath);
            }];
            
            [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
            
            // unzip completed, so remove it from the set
            [self.issuesIsUnzipping removeObject:indexPath];
            
            [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        });
    }
}

#pragma mark - misc

- (void)executeBlock:(void (^)())block withDelay:(NSTimeInterval)delayInSeconds
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(block)
            block();
    });
}

@end
