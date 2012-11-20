//
//  HTViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/7.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "HTViewController.h"
#import "BaseCell.h"

@interface HTViewController ()

@end

@implementation HTViewController
@synthesize pageAry;
@synthesize buyingNoteCell;
@synthesize brandCell;
@synthesize pageCell;
@synthesize seasonNewsCell;
@synthesize camperCell;
@synthesize typeAry;
@synthesize type;

-(id)initWithAry:(NSArray *)ary{
    
    self = [super initWithNibName:@"HTViewController" bundle:nil];
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
    NSDictionary *cellDic=[pageAry objectAtIndex:0];
    type=[cellDic objectForKey:@"type"];
    
    if([pageAry count]<=2){
        [_pageNoView setHidden:YES];
    }else{
        [_pageNoView setHidden:NO];
        _currentPageNo.text=@"01";
        
        if([pageAry count]>10){
            _nextPageNo.text=[NSString stringWithFormat:@"%d",[pageAry count]-1];
        }else{
            _nextPageNo.text=[NSString stringWithFormat:@"0%d",[pageAry count]-1];
        }
    }
    // Do any additional setup after loading the view from its nib.
}
  

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pageAry count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    NSDictionary *cellDic=[pageAry objectAtIndex:indexPath.row+1];
        
    if([type isEqualToString:@"BuyingNote" ]){

        cell = (BuyingNoteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [ [NSBundle mainBundle] loadNibNamed:@"BuyingNoteCell" owner:self options:nil];
            cell =buyingNoteCell;
            self.buyingNoteCell=nil;
        }
       
        
    }else if([type isEqualToString:@"NewBrand"]){
        
        cell = (BrandCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [ [NSBundle mainBundle] loadNibNamed:@"BrandCell" owner:self options:nil];
            cell =brandCell;
            self.brandCell=nil;
        }
        
    }else if([type isEqualToString:@"TrandLook"] || [type isEqualToString:@"AD"]){
        
        cell = (PageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [ [NSBundle mainBundle] loadNibNamed:@"PageCell" owner:self options:nil];
            cell =pageCell;
            self.pageCell=nil;
        }
        
    }else if([type isEqualToString:@"SeasonNews"] ){
        
        cell = (SeasonNewsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [ [NSBundle mainBundle] loadNibNamed:@"SeasonNewsCell" owner:self options:nil];
            cell =seasonNewsCell;
            self.seasonNewsCell=nil;
        }
        
    }else if([type isEqualToString:@"CamperMap"] ){
        
        cell = (CamperMapCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [ [NSBundle mainBundle] loadNibNamed:@"CamperMapCell" owner:self options:nil];
            cell =camperCell;
            self.camperCell=nil;
        }
        
    }
    
    [cell update:cellDic];
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
    /*
    NSDictionary *dic=[indexAry objectAtIndex:indexPath.row];
    int jumpNo=[[dic objectForKey:@"pageNo"] intValue];
    [self gotoCurrentPage:jumpNo];
    
    [self topViewDisplay:NO];
    [self bottomViewDisplay:NO];
    [self indexViewDisplay:NO];
    [self preViewDisplay:NO];
    [_bgAlpha05 setHidden:YES];
     */
    
}
#pragma mark - scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=[scrollView contentOffset];
    int cPageNo=floor(point.y/1024)+1;
    //int nPageNo=cPageNo+1;
    if (cPageNo<10) {
        _currentPageNo.text=[NSString stringWithFormat:@"0%d",cPageNo];
    }else{
        _currentPageNo.text=[NSString stringWithFormat:@"%d",cPageNo];
    }

    
    
    if([pageAry count]>10){
        _nextPageNo.text=[NSString stringWithFormat:@"%d",[pageAry count]-1];
    }else{
        _nextPageNo.text=[NSString stringWithFormat:@"0%d",[pageAry count]-1];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [_pageNoView release];
    [_currentPageNo release];
    [_nextPageNo release];
    [super dealloc];
}
@end
