//
//  MagazineManager.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NewsstandKit/NewsstandKit.h>


@protocol MagazineManagerBookcaseDelegate<NSObject>
@required
- (void)downloadingProgressForIndexPath:(NSIndexPath *)indexPath
                           didWriteData:(long long)bytesWritten
                      totalBytesWritten:(long long)totalBytesWritten
                     expectedTotalBytes:(long long)expectedTotalBytes;
- (void)downloadingResumedForIndexPath:(NSIndexPath *)indexPath
         totalBytesWritten:(long long)totalBytesWritten
        expectedTotalBytes:(long long)expectedTotalBytes;
- (void)downloadingFinishedForIndexPath:(NSIndexPath *)indexPath
                                  issue:(NKIssue *)issue
                         destinationURL:(NSURL *)destinationURL;
@end

@interface MagazineManager : NSObject <NSURLConnectionDownloadDelegate, SKProductsRequestDelegate, SKRequestDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    BOOL subscriptionProcessing;
}

@property (strong, nonatomic) NSArray *issueArray;
@property (assign, nonatomic) BOOL ready;
@property (strong, nonatomic) NSString *currentIssuePath;
@property (assign, nonatomic) BOOL isFlowLayout;
@property (weak, nonatomic) id<MagazineManagerBookcaseDelegate> bookcaseDelegate;

+ (MagazineManager *)sharedInstance;

- (void)addIssuesInNewsstand;
- (void)getIssuesListSuccess:(void (^)())success
                     failure:(void (^)(NSString *reason, NSError *error))failure;
- (NSInteger)numberOfIssues;
- (NSString *)titleOfIssueAtIndex:(NSInteger)index;
- (NSString *)nameOfIssueAtIndex:(NSInteger)index;
- (void)setCoverOfIssueAtIndex:(NSInteger)index completionBlock:(void(^)(UIImage *img))block;
- (NSURL *)contentURLForIssueWithName:(NSString *)name;
- (NSString *)downloadPathForIssue:(NKIssue *)nkIssue;
- (UIImage *)coverImageForIssue:(NKIssue *)nkIssue;
- (void)removeDownloadedIssue:(NSString *)issueName;

- (void)downloadIssue:(NSString *)issueName
            indexPath:(NSIndexPath *)indexPath;
- (void)resumeAnyFailedDownload;

- (void)setCurrentIssue:(NSString *)issueName;

- (void)saveLatestIssue:(NSString *)issueName;
- (void)markIssueRead:(NSString *)issueName;

- (void)processSubscription;

@end
