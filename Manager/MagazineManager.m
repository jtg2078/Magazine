//
//  MagazineManager.m
//  Magazine
//
//  Created by jason on 11/6/12.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "MagazineManager.h"
#import "AFNetworking.h"

@implementation MagazineManager

#pragma mark - define

#define CacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        _isFlowLayout = YES;

    }
    return self;
}

#pragma mark - issue info methods

- (NSDictionary *)issueAtIndex:(NSInteger)index
{
    return [self.issueArray objectAtIndex:index];
}

- (NSString *)titleOfIssueAtIndex:(NSInteger)index
{
    return [[self issueAtIndex:index] objectForKey:@"title"];
}

- (NSString *)nameOfIssueAtIndex:(NSInteger)index
{
    return [[self issueAtIndex:index] objectForKey:@"name"];
}

- (NSURL *)contentURLForIssueWithName:(NSString *)name
{
    NSURL *contentURL = nil;
    
    for(NSDictionary *issue in self.issueArray)
    {
        NSString *aName = [issue objectForKey:@"name"];
        if([aName isEqualToString:name])
        {
            contentURL = [NSURL URLWithString:[issue objectForKey:@"content"]];
            break;
        }
    }
    
    NSLog(@"Content URL for issue with name %@ is %@", name, contentURL);
    
    return contentURL;
}

- (NSString *)downloadPathForIssue:(NKIssue *)nkIssue
{
    return [nkIssue.contentURL path];
}

- (UIImage *)coverImageForIssue:(NKIssue *)nkIssue
{
    NSString *name = nkIssue.name;
    for(NSDictionary *issueInfo in self.issueArray)
    {
        if([name isEqualToString:[issueInfo objectForKey:@"name"]])
        {
            NSString *coverPath = [issueInfo objectForKey:@"cover"];
            NSString *coverName = [coverPath lastPathComponent];
            NSString *coverFilePath = [CacheDirectory stringByAppendingPathComponent:coverName];
            UIImage *image = [UIImage imageWithContentsOfFile:coverFilePath];
            return image;
        }
    }
    
    return nil;
}

- (void)setCoverOfIssueAtIndex:(NSInteger)index
               completionBlock:(void(^)(UIImage *img))block
{
    NSURL *coverURL = [NSURL URLWithString:[[self issueAtIndex:index] objectForKey:@"Cover"]];
    NSString *coverFileName = [coverURL lastPathComponent];
    NSString *coverFilePath = [CacheDirectory stringByAppendingPathComponent:coverFileName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:coverFilePath];
    
    if(DEVELOPMENT_MODE == YES)
    {
        image = [UIImage imageNamed:@"bookCover_large.png"];
    }
    
    if(image)
    {
        if(block)
            block(image);
    }
    else
    {
        AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:coverURL] success:^(UIImage *image) {
            
            NSData *imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:coverFilePath atomically:YES];
            
            if(block)
                block(image);
        }];
        
        [op start];
    }
}

#pragma mark - main methods

- (void)getIssuesListSuccess:(void (^)())success
                     failure:(void (^)(NSString *reason, NSError *error))failure
{
    if(DEVELOPMENT_MODE)
    {
        NSURL *catalogURL = [[NSBundle mainBundle] URLForResource:@"catalog" withExtension:@"plist"];
        self.issueArray = [[NSArray alloc] initWithContentsOfURL:catalogURL];
        self.ready = YES;
        [self addIssuesInNewsstand];
        
        if(success)
            success();
    }
    else
    {
        //線上版書架內容--plist
        
        AFPropertyListRequestOperation *op = [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dl.dropbox.com/u/60296373/Magazine/catalog.plist"]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList) {
            
            self.issueArray = [NSArray arrayWithArray:propertyList];
            self.ready = YES;
            [self addIssuesInNewsstand];
            
            if(success)
                success();
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList) {
            
            self.ready = NO;
            if(failure)
                failure(@"Unable to retrieve catalog plist", error);
        }];
        
        [op start];
    }
}

- (void)addIssuesInNewsstand
{
    NKLibrary *nkLib = [NKLibrary sharedLibrary];
    [self.issueArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSString *name = [(NSDictionary *)obj objectForKey:@"name"];
         NKIssue *nkIssue = [nkLib issueWithName:name];
         if(!nkIssue)
         {
             nkIssue = [nkLib addIssueWithName:name date:[(NSDictionary *)obj objectForKey:@"date"]];
             
             // so this is a new issue (so far)
             // update the newsstand app icon and add "new" badge to it
             NSString *newsstandIconImageUrl = [(NSDictionary *)obj objectForKey:@"newsstandIcon"];
             if(newsstandIconImageUrl)
             {
                 AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newsstandIconImageUrl]] success:^(UIImage *image) {
                     if(image)
                     {
                         [[UIApplication sharedApplication] setNewsstandIconImage:image];
                         [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
                     }
                 }];
                 
                 [op start];
             }
             
             [self saveLatestIssue:name];
         }
         
         NSLog(@"Issue: %@",nkIssue);
     }];
}

- (NSInteger)numberOfIssues
{
    if(self.ready && self.issueArray)
        return self.issueArray.count;
    else
        return 0;
}

- (void)removeDownloadedIssue:(NSString *)issueName
{
    NKLibrary *nkLib = [NKLibrary sharedLibrary];
    NKIssue *issue = [nkLib issueWithName:issueName];
    if (issue)
    {
        [[NKLibrary sharedLibrary] removeIssue:issue];
        
        // now we need to add the removed issue(s) meta data from plist back to nk library
        [self addIssuesInNewsstand];
    }
}

- (void)downloadIssue:(NSString *)issueName
           indexPath:(NSIndexPath *)indexPath
{
    NKLibrary *library = [NKLibrary sharedLibrary];
    
    NKIssue *issue = [library issueWithName:issueName];
    NSURL *downloadURL = [self contentURLForIssueWithName:issue.name];
    
    if(!downloadURL)
        return;
    
    NKAssetDownload *assetDownload = [issue addAssetWithRequest:[NSURLRequest requestWithURL:downloadURL]];
    
    [assetDownload setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:indexPath.row], @"indexPathRow",
                                [NSNumber numberWithInt:indexPath.section], @"indexPathSection",nil]];
    
    [assetDownload downloadWithDelegate:self];
}

- (void)resumeAnyFailedDownload
{
    // resume any failed downloads
    NKLibrary *nkLib = [NKLibrary sharedLibrary];
    for(NKAssetDownload *asset in [nkLib downloadingAssets])
    {
        [asset downloadWithDelegate:self];
    }
}

- (void)setCurrentIssue:(NSString *)issueName
{
    NKLibrary *library = [NKLibrary sharedLibrary];
    NKIssue *nkIssue = [library issueWithName:issueName];
    
    if(nkIssue)
        library.currentlyReadingIssue = nkIssue;
}

- (void)saveLatestIssue:(NSString *)issueName
{
    if(issueName)
    {
        [[NSUserDefaults standardUserDefaults] setValue:issueName forKey:@"latestIssueName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)markIssueRead:(NSString *)issueName
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *latestIssue = [df stringForKey:@"latestIssueName"];
    
    if(issueName && latestIssue && [issueName isEqualToString:latestIssue] == YES)
    {
         [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    }
}

#pragma mark - NSURLConnectionDownloadDelegate

- (void)connection:(NSURLConnection *)connection
      didWriteData:(long long)bytesWritten
 totalBytesWritten:(long long)totalBytesWritten
expectedTotalBytes:(long long)expectedTotalBytes
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    
    NSNumber *row = [assetDownload.userInfo objectForKey:@"indexPathRow"];
    NSNumber *section = [assetDownload.userInfo objectForKey:@"indexPathSection"];
    
    if(row && section)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row.intValue
                                                    inSection:section.intValue];
        
        if(self.bookcaseDelegate)
           [self.bookcaseDelegate downloadingProgressForIndexPath:indexPath
                                                     didWriteData:bytesWritten
                                                totalBytesWritten:totalBytesWritten
                                               expectedTotalBytes:expectedTotalBytes];
    }
}

- (void)connectionDidResumeDownloading:(NSURLConnection *)connection
                     totalBytesWritten:(long long)totalBytesWritten
                    expectedTotalBytes:(long long)expectedTotalBytes
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    
    NSNumber *row = [assetDownload.userInfo objectForKey:@"indexPathRow"];
    NSNumber *section = [assetDownload.userInfo objectForKey:@"indexPathSection"];
    
    if(row && section)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row.intValue
                                                    inSection:section.intValue];
        
        if(self.bookcaseDelegate)
            [self.bookcaseDelegate downloadingResumedForIndexPath:indexPath
                                                totalBytesWritten:totalBytesWritten
                                               expectedTotalBytes:expectedTotalBytes];
    }
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection
                        destinationURL:(NSURL *)destinationURL
{
    NKAssetDownload *assetDownload = connection.newsstandAssetDownload;
    NKIssue *issue = assetDownload.issue;
    NSNumber *row = [assetDownload.userInfo objectForKey:@"indexPathRow"];
    NSNumber *section = [assetDownload.userInfo objectForKey:@"indexPathSection"];
    
    if(row && section)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row.intValue
                                                    inSection:section.intValue];
        
        if(self.bookcaseDelegate)
            [self.bookcaseDelegate downloadingFinishedForIndexPath:indexPath
                                                             issue:issue
                                                    destinationURL:destinationURL];
    }
}

#pragma mark - singleton implementation code

static MagazineManager *singletonManager = nil;
+ (MagazineManager *)sharedInstance {
    
    static dispatch_once_t pred;
    static MagazineManager *manager;
    
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (singletonManager == nil) {
            singletonManager = [super allocWithZone:zone];
            return singletonManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
