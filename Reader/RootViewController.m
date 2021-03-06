//
//  RootViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/10/23.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "RootViewController.h"
#import "PageViewController.h"

#import "PageHViewController.h"
#import "HTViewController.h"
#import "CamperMapViewController.h"
#import "FashionShowViewController.h"
#import "StoresViewController.h"
#import "SocialViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"


@interface RootViewController ()
    -(void)hideTopBottomView;
    -(void)gotoCurrentPage:(int)page;

    -(void)topViewDisplay:(BOOL)show;
    -(void)bottomViewDisplay:(BOOL)show;
    -(void)indexViewDisplay:(BOOL)show;
    -(void)preViewDisplay:(BOOL)show;

@end

@implementation RootViewController
@synthesize pageAry;
@synthesize indexAry;
@synthesize indexCell;
@synthesize historyAry;
@synthesize vcArray = _vcArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc {
    _scrollView.delegate = nil;
    [_scrollView release];
    [_topView release];
    [_bottomView release];
    [_dotButton release];
    [_thumbImageView release];
    [_leftButton release];
    [_rightButton release];
    [_preView release];
    [_pageTitle release];
    [_pageSubtitle release];
    [_bgAlpha05 release];
    [_indexView release];
    [_indexButton release];
    [_myTableView release];
    [_historyButton release];
    [_infoButton release];
    [_vcArray release];
    [historyAry release];
    [indexCell release];
    [indexAry release];
    [pageAry release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"main viewer controller";
    
    [self hideTopBottomView];
    _preView.alpha=0;
    [_bgAlpha05 setHidden:YES];
    _indexView.frame=CGRectMake(-427,45, 427, 979);
    
    [_dotButton addTarget:self action:@selector(touchDragInside:withEvent:)
     forControlEvents:UIControlEventTouchDragInside];
    
    self.vcArray = [NSMutableArray array];
    
    //載入書本內容
    
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSString *path =  [manager.currentIssuePath stringByAppendingPathComponent:@"book.plist"];
    
    /*
     NSString *path = [[NSBundle mainBundle] --pathForResource:@"book" ofType:@"plist" inDirectory:@"book"];
     */
    
    NSMutableDictionary *dic=[[[NSMutableDictionary alloc] initWithContentsOfFile:path] autorelease];
    self.pageAry=[dic objectForKey:@"page"];
 
    
    _scrollView.contentSize=CGSizeMake(768*[pageAry count], 1024);
    
    
    
    for (int i=0; i<[pageAry count]; i++) {
        NSString *type=[[[pageAry objectAtIndex:i] objectAtIndex:0] objectForKey:@"type"];
        NSLog(@"%d:%@",i,type);
        if([type isEqualToString:@"image"]){
            PageViewController *page=[[PageViewController alloc] initWithAry:[pageAry objectAtIndex:i]];
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            page.jumpDelegate=self;
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];
            
        }else if([type isEqualToString:@"imageH"]){
            PageHViewController *page=[[PageHViewController alloc] initWithAry:[pageAry objectAtIndex:i]];
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            page.jumpDelegate=self;
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];
            
        }else if([type isEqualToString:@"BuyingNote"] || [type isEqualToString:@"NewBrand"] || [type isEqualToString:@"TrandLook"] || [type isEqualToString:@"SeasonNews"] || [type isEqualToString:@"AD"]){
            HTViewController *page=[[HTViewController alloc] initWithAry:[pageAry objectAtIndex:i]];
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];
            
        }else if([type isEqualToString:@"CamperMap"]){
            CamperMapViewController *page=[[CamperMapViewController alloc] initWithAry:[pageAry objectAtIndex:i]] ;
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];

        }else if([type isEqualToString:@"FashionShow"]){
            FashionShowViewController *page=[[FashionShowViewController alloc] initWithAry:[pageAry objectAtIndex:i]] ;
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];
            
        }else if([type isEqualToString:@"BackCover"]){
            SocialViewController *page=[[SocialViewController alloc] initWithAry:[pageAry objectAtIndex:i]];
            page.view.frame=CGRectMake(768*i, 0, 768, 1024);
            [_scrollView addSubview:page.view];
            
            [self.vcArray addObject:page];
            [page release];
        }
    }
    
    //載入index 內容
    
    //NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist" inDirectory:@"book"];
    NSString *indexPath = [manager.currentIssuePath stringByAppendingPathComponent:@"index.plist"];
    NSMutableDictionary *indexDic=[[[NSMutableDictionary alloc] initWithContentsOfFile:indexPath] autorelease];
    self.indexAry=[indexDic objectForKey:@"page"];

    // Do any additional setup after loading the view from its nib.
    
    historyAry=[[[NSMutableArray alloc] init] retain];
    [historyAry insertObject:[NSNumber numberWithInt:0] atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@"讀取中"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD dismiss];
}

-(void)page:(int) jumpNo{
    CGPoint point=CGPointMake(jumpNo*768, 0);
    [_scrollView setContentOffset:point animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (IBAction)londPress:(id)sender {
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{   
                         _topView.frame = CGRectMake(0, 0, 768, 53);
                         
                     }
     
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:1.0
                                               delay: 1.0
                          
                                             options:UIViewAnimationOptionCurveEaseOut
                          
                                          animations:^{
                                              
                                              _topView.alpha = 1.0;
                                              
                                          }
                          
                                          completion:nil];}
    
                         ];
}
   */


- (IBAction)prevPage:(id)sender {
    if ([historyAry count]>1) {
        [historyAry removeLastObject];
        currentPage=[[historyAry lastObject] intValue];
        [self gotoCurrentPage:currentPage];
    }

    
}

- (IBAction)openStores:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    StoresViewController *stores=[[[StoresViewController alloc] initWithNibName:@"StoresViewController" bundle:nil] autorelease];
    [appDelegate presentViewController:stores animated:YES];
}

- (void)touchDragInside:(id)sender withEvent:(UIEvent *)event{
    
    if (_preView.alpha==0) {
        _preView.alpha=1;
    }
    
    // get the touch
	UITouch *touch = [[event touchesForView:sender] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:sender];
	CGPoint location = [touch locationInView:sender];
	CGFloat delta_x = location.x - previousLocation.x;
    
    float _dotButtonX=_dotButton.center.x + delta_x;
    
    if(_dotButtonX<104){
        _dotButtonX=104;
    }
    if (_dotButtonX>664) {
         _dotButtonX=664;
    }
    
	// move button
	_dotButton.center = CGPointMake(_dotButtonX,_dotButton.center.y);
    
    
    int jumpPageNo=round((_dotButton.center.x-104)/560*([pageAry count]-1));
    MagazineManager *manager = [MagazineManager sharedInstance];
    NSDictionary *dic=[[pageAry objectAtIndex:jumpPageNo] objectAtIndex:0];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"thumb"] ofType:nil inDirectory:@"book"];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[dic objectForKey:@"thumb"]];
    UIImage *image=[UIImage imageWithContentsOfFile:filename];
    [_thumbImageView setImage:image];
    
    _pageTitle.text=[dic objectForKey:@"title"];
    _pageSubtitle.text=[dic objectForKey:@"subtitle"];
}

- (IBAction)tapGesture:(id)sender {
    CGPoint point=_topView.frame.origin;
    if (point.y>=0) {
        [self topViewDisplay:NO];
        [self bottomViewDisplay:NO];
        [self indexViewDisplay:NO];
        [_bgAlpha05 setHidden:YES];
    }else{
        [self topViewDisplay:YES];
        [self bottomViewDisplay:YES];
    }
}

- (IBAction)gotoPage:(id)sender {
    
    currentPage=round((_dotButton.center.x-104)/560*([pageAry count]-1));
    [self gotoCurrentPage:currentPage];
    [historyAry insertObject:[NSNumber numberWithInt:currentPage] atIndex:[historyAry count]];

}

- (IBAction)gotoLeft:(id)sender {
    if (currentPage>1) {
        currentPage=currentPage-1;
        [self gotoCurrentPage:currentPage];
        [historyAry insertObject:[NSNumber numberWithInt:currentPage] atIndex:[historyAry count]];
    }

}

- (IBAction)gotoRight:(id)sender {
    if (currentPage<([pageAry count]-1)) {
        currentPage=currentPage+1;
        [self gotoCurrentPage:currentPage];
        [historyAry insertObject:[NSNumber numberWithInt:currentPage] atIndex:[historyAry count]];
    }

}

- (IBAction)showIndex:(id)sender {
    
    if ([_bgAlpha05 isHidden]) {
        [self indexViewDisplay:YES];
        [self bottomViewDisplay:NO];
    }else{
        [self indexViewDisplay:NO];
    }
    [_bgAlpha05 setHidden:![_bgAlpha05 isHidden]];
}

- (IBAction)gotoBookShelf:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)gotoCurrentPage:(int)page{
    
    float dis=(560*page)/([pageAry count]-1)+104;
    
    _dotButton.center=CGPointMake(dis,_dotButton.center.y);
    
    CGPoint pagePoint=CGPointMake(page*768, 0);
    [_scrollView setContentOffset:pagePoint animated:YES];
    
    [self indexViewDisplay:NO];
    [self preViewDisplay:NO];
    [_bgAlpha05 setHidden:YES];


}


-(void)hideTopBottomView{
    _topView.frame=CGRectMake(0, -53, 768, 53);
    _bottomView.frame=CGRectMake(0,1024, 768, 53);
}

-(void)topViewDisplay:(BOOL)show{
    int viewY=-53;
    if (show) {
        viewY=0;
    }
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _topView.frame = CGRectMake(0, viewY, 768, 53);
                     }
                     completion:nil
     
     ];
}
-(void)bottomViewDisplay:(BOOL)show{
    int viewY=1024;
    
    if (show) {
        viewY=971;
    }
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _bottomView.frame = CGRectMake(0, viewY, 768, 53);
                     }
                     completion:nil
     
     ];
}
-(void)indexViewDisplay:(BOOL)show{
    int viewX=-427;
    
    if (show) {
        viewX=0;
    }
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _indexView.frame = CGRectMake(viewX,45, 427, 979);
                     }
                     completion:nil
     
     ];
}
-(void)preViewDisplay:(BOOL)show{
    int alpha=0;
    if (show) {
        alpha=1;
    }
    [UIView animateWithDuration:0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_preView setAlpha:alpha];
                     }
                     completion:nil
     
     ];
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([_bgAlpha05 isHidden]){
        [self topViewDisplay:NO];
        [self bottomViewDisplay:NO];
        [self indexViewDisplay:NO];
        [self preViewDisplay:NO];
        [_bgAlpha05 setHidden:YES];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentPage=floor(_scrollView.contentOffset.x/768);
    float dis=(560*currentPage)/([pageAry count]-1)+104;
    _dotButton.center=CGPointMake(dis,_dotButton.center.y);
    [historyAry insertObject:[NSNumber numberWithInt:currentPage] atIndex:[historyAry count]];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidEndScrollingAnimation");
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [indexAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
     */
    
    static NSString *CellIdentifier = @"indexCell";
    IndexCell* cell = (IndexCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"IndexCell" owner:self options:nil];
        cell =indexCell;
        self.indexCell = nil;
    }
    
    NSDictionary *cellDic=[indexAry objectAtIndex:indexPath.row];
    MagazineManager *manager = [MagazineManager sharedInstance];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:[cellDic objectForKey:@"file"] ofType:nil inDirectory:@"book/indexImages"];
    NSString *filename = [[manager.currentIssuePath stringByAppendingPathComponent:@"indexImages"] stringByAppendingPathComponent:[cellDic objectForKey:@"file"]];
    UIImage *cellImage=[UIImage imageWithContentsOfFile:filename];
    //UIImageView *cellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(25, 25, 70, 70)];
    [cell.cellImageView setImage:cellImage];
    
    cell.title.text=[cellDic objectForKey:@"title"];
    cell.subtitle.text=[cellDic objectForKey:@"subtitle"];
    cell.pageNo=[[cellDic objectForKey:@"pageNo"] intValue];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic=[indexAry objectAtIndex:indexPath.row];
    int jumpNo=[[dic objectForKey:@"pageNo"] intValue];
    currentPage=jumpNo;
    [historyAry insertObject:[NSNumber numberWithInt:currentPage] atIndex:[historyAry count]];
    [self gotoCurrentPage:jumpNo];
    
    
    [self topViewDisplay:NO];
    [self bottomViewDisplay:NO];
    [self indexViewDisplay:NO];
    [self preViewDisplay:NO];
    [_bgAlpha05 setHidden:YES];
    
}
@end
