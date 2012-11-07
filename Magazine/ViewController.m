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
    
    // -------------------- cell view --------------------
    
    /*
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"MagazineCell"];
     */
    
    // -------------------- collection view --------------------
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_bookshelf.png"]];
    self.collectionView.backgroundView = bg;
    
    // -------------------- tool bar --------------------
    
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView_selected.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView.png"];
    
    // -------------------- app state --------------------
    
    self.viewMode = ViewModeGrid;
    self.manager = [MagazineManager sharedInstance];
    self.library = [NKLibrary sharedLibrary];
    self.issuesPreparingForDownload = [NSMutableSet set];
    
    // -------------------- loading catalog --------------------
    
    [SVProgressHUD showWithStatus:@"Getting catalog list..."];
    [self.manager getIssuesListSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"Success!"];
        [self.collectionView reloadData];
    } failure:^(NSString *reason, NSError *error) {
        [SVProgressHUD showErrorWithStatus:reason];
    }];
}

#pragma mark - user action

- (IBAction)gridViewBarButtonPressed:(id)sender
{
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView_selected.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView.png"];
}

- (IBAction)pageViewBarButtonPressed:(id)sender
{
    self.gridViewBarButton.image = [UIImage imageNamed:@"btn_gridView.png"];
    self.pageViewBarButton.image = [UIImage imageNamed:@"btn_pageView_selected.png"];
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
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    NKIssue *issue = [self.library issueWithName:issueName];
    NSString *magazineName = @"團團雜誌";
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

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(339, 245);
    return size;
}

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 20, 30, 20);
}
 */

#pragma mark - MagazineCellDelegate

- (void)deleteIssue:(NSIndexPath *)indexPath
{
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    [self.manager removeDownloadedIssue:issueName];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

- (void)viewIssue:(NSIndexPath *)indexPath
{
    
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
    NSString *issueName = [self.manager nameOfIssueAtIndex:indexPath.row];
    NKIssue *issue = [self.library issueWithName:issueName];
    NSURL *downloadURL = [self.manager contentURLForIssueWithName:issue.name];
    
    if(!downloadURL)
        return;
    
    NKAssetDownload *assetDownload = [issue addAssetWithRequest:[NSURLRequest requestWithURL:downloadURL]];
    
    [assetDownload setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:indexPath.row], @"indexPathRow",
                                [NSNumber numberWithInt:indexPath.section], @"indexPathSection",nil]];
    [assetDownload downloadWithDelegate:self];
    
    [self.issuesPreparingForDownload addObject:indexPath];
    
    
}

#pragma mark - NSURLConnectionDownloadDelegate

- (void)connection:(NSURLConnection *)connection
      didWriteData:(long long)bytesWritten
 totalBytesWritten:(long long)totalBytesWritten
expectedTotalBytes:(long long)expectedTotalBytes
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[assetDownload.userInfo objectForKey:@"indexPathRow"] intValue] inSection:[[assetDownload.userInfo objectForKey:@"indexPathSection"] intValue]];
    
    id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
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
        
        downloadingCell.progressLabel.text = [NSString stringWithFormat:@" %.2f MB / %.2f MB", downloadedInMB, totalMB];
    }
    else
    {
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
        // since the cell is already in downloading state, remove it from preparing download state
        [self.issuesPreparingForDownload removeObject:indexPath];
    }
}

- (void)connectionDidResumeDownloading:(NSURLConnection *)connection
                     totalBytesWritten:(long long)totalBytesWritten
                    expectedTotalBytes:(long long)expectedTotalBytes
{
    
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection
                        destinationURL:(NSURL *)destinationURL
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[assetDownload.userInfo objectForKey:@"indexPathRow"] intValue] inSection:[[assetDownload.userInfo objectForKey:@"indexPathSection"] intValue]];
    
    NSString *zipPath = [destinationURL path];
    NSString *destinationPath = [self.manager downloadPathForIssue:issue];
    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
    
    id cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[MagazineCellDownloading class]] == YES)
    {
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}

@end
