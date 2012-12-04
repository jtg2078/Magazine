//
//  PageViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/10/23.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController
@synthesize pageAry;
@synthesize jumpDelegate;

-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"PageViewController" bundle:nil];
    if (self) {
        // Custom initialization
        pageAry=ary;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = NSStringFromClass([self class]);
    int totalHeight=0;
    int totalWidth=0;
    
    if([pageAry count]<=1){
        [_pageNoView setHidden:YES];
        _currentPageNo.text=@"01";
        _currentPageNo.text=@"02";
    }else{
         [_pageNoView setHidden:NO];
    }
    MagazineManager *manager = [MagazineManager sharedInstance];
    for (int i=0; i<[pageAry count]; i++) {
        NSDictionary *dic=[pageAry objectAtIndex:i];
        
        if(![[dic objectForKey:@"backImage"] isEqualToString:@""]){
            //NSString *backFilename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
            NSString *backFilename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"backImage"]];
            [_backImage setImage:[UIImage imageWithContentsOfFile:backFilename]];
        }
        
        //NSString *filename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
        NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"file"]];
        UIImage *image=[UIImage imageWithContentsOfFile:filename];
        
        int pageWidth=[[dic objectForKey:@"width"] intValue];
        int pageHeight=[[dic objectForKey:@"height"] intValue];
        
        UIImageView *imageView;
        
        if([[dic objectForKey:@"type"] isEqualToString:@"image"]){
            
            imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, totalHeight, pageWidth, pageHeight)] autorelease];
            totalHeight=totalHeight+pageHeight;
            totalWidth=pageWidth;
            [imageView setImage:image];
            
            if (pageHeight>1024) {
                 [_scrollView setPagingEnabled:NO];
            }
            
            [_scrollView addSubview:imageView];
        
        }
    }
    _scrollView.contentSize=CGSizeMake(totalWidth, totalHeight);
    
}

#pragma mark - scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=[scrollView contentOffset];
    int cPageNo=floor(point.y/1024)+1;
    _currentPageNo.text=[NSString stringWithFormat:@"0%d",cPageNo];
    if (cPageNo==[pageAry count]) {
        [_nextPageNo setHidden:YES];
    }else{
         [_nextPageNo setHidden:NO];
        _nextPageNo.text=[NSString stringWithFormat:@"0%d",cPageNo+1];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _scrollView.delegate = nil;
    [_scrollView release];
    [_pageNoView release];
    [_currentPageNo release];
    [_nextPageNo release];
    [_backImage release];
    [super dealloc];
}
@end