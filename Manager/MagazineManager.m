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

    }
    return self;
}

#pragma mark - main methods

- (void)getIssuesListSuccess:(void (^)())success
                    failure:(void (^)(NSString *reason, NSError *error))failure
{
    NSURL *catalogURL = [[NSBundle mainBundle] URLForResource:@"catalog" withExtension:@"plist"];
    self.issues = [[NSArray alloc] initWithContentsOfURL:catalogURL];
    self.ready = YES;
    [self addIssuesInNewsstand];
    
    if(success)
        success();
    /*
    AFPropertyListRequestOperation *op = [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dl.dropbox.com/u/60296373/Magazine/catalog.plist"]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList) {
        
        self.issues = [NSArray arrayWithArray:propertyList];
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
     */
}

- (void)addIssuesInNewsstand
{
    NKLibrary *nkLib = [NKLibrary sharedLibrary];
    [self.issues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSString *name = [(NSDictionary *)obj objectForKey:@"name"];
         NKIssue *nkIssue = [nkLib issueWithName:name];
         if(!nkIssue)
         {
             nkIssue = [nkLib addIssueWithName:name date:[(NSDictionary *)obj objectForKey:@"date"]];
         }
         
         NSLog(@"Issue: %@",nkIssue);
     }];
}

- (NSInteger)numberOfIssues
{
    if(self.ready && self.issues)
        return self.issues.count;
    else
        return 0;
}

- (NSDictionary *)issueAtIndex:(NSInteger)index
{
    return [self.issues objectAtIndex:index];
}

- (NSString *)titleOfIssueAtIndex:(NSInteger)index
{
    return [[self issueAtIndex:index] objectForKey:@"title"];
}

- (NSString *)nameOfIssueAtIndex:(NSInteger)index
{
    return [[self issueAtIndex:index] objectForKey:@"name"];
}

- (void)setCoverOfIssueAtIndex:(NSInteger)index
               completionBlock:(void(^)(UIImage *img))block
{
    NSURL *coverURL = [NSURL URLWithString:[[self issueAtIndex:index] objectForKey:@"Cover"]];
    NSString *coverFileName = [coverURL lastPathComponent];
    NSString *coverFilePath = [CacheDirectory stringByAppendingPathComponent:coverFileName];
    UIImage *image = [UIImage imageWithContentsOfFile:coverFilePath];
    image = [UIImage imageNamed:@"bookCover_large.png"];
    
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

- (UIImage *)coverImageForIssue:(NKIssue *)nkIssue
{
    NSString *name = nkIssue.name;
    for(NSDictionary *issueInfo in self.issues)
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

- (NSURL *)contentURLForIssueWithName:(NSString *)name
{
    NSURL *contentURL = nil;
    
    for(NSDictionary *issue in self.issues)
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
    //return [[nkIssue.contentURL path] stringByAppendingPathComponent:@"issue"];
    return [nkIssue.contentURL path];
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
