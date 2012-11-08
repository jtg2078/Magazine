//
//  CodeSnippet.m
//  Magazine
//
//  Created by jason on 11/7/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "CodeSnippet.h"

@implementation CodeSnippet

/*
 [self.collectionView registerClass:[UICollectionViewCell class]
 forCellWithReuseIdentifier:@"MagazineCell"];
 */

/*
 [self executeBlock:^{
 
 [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
 //[self.collectionView reloadData];
 NSMutableArray *array = [NSMutableArray array];
 for(UICollectionViewCell *cell in self.collectionView.visibleCells)
 {
 NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
 [array addObject:indexPath];
 [cell setNeedsDisplay];
 }
 [self.collectionView reloadItemsAtIndexPaths:array];
 } withDelay:1.0f];
 */

/*
 [self executeBlock:^{
 
 [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
 //[self.collectionView reloadData];
 
 NSMutableArray *array = [NSMutableArray array];
 for(UICollectionViewCell *cell in self.collectionView.visibleCells)
 {
 NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
 [array addObject:indexPath];
 [cell setNeedsDisplay];
 }
 [self.collectionView reloadItemsAtIndexPaths:array];
 
 } withDelay:1.0f];
 */

//[self.collectionView reloadData];
//[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];

/*
 [self executeBlock:^{
 
 [self.collectionView invalidateIntrinsicContentSize];
 
 } withDelay:0.5f];
 */

//[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//[self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];

// adjust the size base on current flow layout
/*
 if(self.collectionView.collectionViewLayout == self.flowLayout)
 {
 cell.coverImageView.frame = CGRectMake(20, 15, 157, 210);
 cell.magazineName.frame = CGRectMake(191, 73, 73, 21);
 cell.issueTitle.frame = CGRectMake(191, 94, 73, 21);
 cell.downloadButton.frame = CGRectMake(191, 191, 124, 40);
 }
 else
 {
 cell.coverImageView.frame = CGRectMake(92, 20, 517, 761);
 cell.magazineName.frame = CGRectMake(92, 798, 73, 21);
 cell.issueTitle.frame = CGRectMake(92, 822, 73, 21);
 cell.downloadButton.frame = CGRectMake(493, 803, 124, 40);
 }
 */

/*
 if(self.collectionView.collectionViewLayout == self.flowLayout)
 {
 cell.coverImageView.frame = CGRectMake(20, 15, 157, 210);
 cell.magazineName.frame = CGRectMake(191, 73, 73, 21);
 cell.issueTitle.frame = CGRectMake(191, 94, 73, 21);
 //cell.viewButton.frame = CGRectMake(191, 143, 124, 40);
 //cell.deleteButton.frame = CGRectMake(191, 191, 124, 40);
 }
 else
 {
 cell.coverImageView.frame = CGRectMake(92, 20, 517, 761);
 cell.magazineName.frame = CGRectMake(92, 798, 73, 21);
 cell.issueTitle.frame = CGRectMake(92, 822, 73, 21);
 //cell.viewButton.frame = CGRectMake(363, 803, 124, 40);
 //cell.deleteButton.frame = CGRectMake(493, 803, 124, 40);
 }
 */

// adjust the size base on current flow layout
/*
 if(self.collectionView.collectionViewLayout == self.flowLayout)
 {
 cell.coverImageView.frame = CGRectMake(20, 15, 157, 210);
 cell.magazineName.frame = CGRectMake(191, 73, 73, 21);
 cell.issueTitle.frame = CGRectMake(191, 94, 73, 21);
 cell.viewButton.frame = CGRectMake(191, 143, 124, 40);
 cell.deleteButton.frame = CGRectMake(191, 191, 124, 40);
 }
 else
 {
 cell.coverImageView.frame = CGRectMake(92, 20, 517, 761);
 cell.magazineName.frame = CGRectMake(92, 798, 73, 21);
 cell.issueTitle.frame = CGRectMake(92, 822, 73, 21);
 cell.viewButton.frame = CGRectMake(363, 803, 124, 40);
 cell.deleteButton.frame = CGRectMake(493, 803, 124, 40);
 }
 */

@end
