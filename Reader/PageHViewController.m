//
//  PageHViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/6.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "PageHViewController.h"

@interface PageHViewController ()

@end

@implementation PageHViewController

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
        
        if([[dic objectForKey:@"type"] isEqualToString:@"imageH"]){
            
            imageView=[[[UIImageView alloc] initWithFrame:CGRectMake(totalWidth, 0, pageWidth, pageHeight)] autorelease];
            
            totalHeight=pageHeight;
            totalWidth=totalWidth+pageWidth;
            
            [imageView setImage:image];
            [_scrollView addSubview:imageView];
            
        }
        
    }
    _scrollView.pagingEnabled=NO;
    _scrollView.frame=CGRectMake(0,1024-totalHeight-70, 768, totalHeight);
    _scrollView.contentSize=CGSizeMake(totalWidth, totalHeight);
    
}

#pragma mark - scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_scrollView release];
    [_pageNoView release];
    [_currentPageNo release];
    [_nextPageNo release];
    [_backImage release];
    [super dealloc];
}

@end
