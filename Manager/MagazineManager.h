//
//  MagazineManager.h
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NewsstandKit/NewsstandKit.h>

@interface MagazineManager : NSObject
{
    
}

@property (strong, nonatomic) NSArray *issues;
@property (assign, nonatomic) BOOL ready;
@property (strong, nonatomic) NSString *currentIssuePath;
@property (assign, nonatomic) BOOL isFlowLayout;

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

@end
