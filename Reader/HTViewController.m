//
//  HTViewController.m
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/7.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import "HTViewController.h"

@interface HTViewController ()

@end

@implementation HTViewController
@synthesize pageAry;
@synthesize buyingNoteCell;
@synthesize brandCell;



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
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pageAry count];
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

    
    
    
    static NSString *CellIdentifier = @"NoteCell";
    BuyingNoteCell *cell = (BuyingNoteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        [ [NSBundle mainBundle] loadNibNamed:@"BuyingNoteCell" owner:self options:nil];
        cell =buyingNoteCell;
        self.buyingNoteCell=nil;
    }

    NSDictionary *cellDic=[pageAry objectAtIndex:indexPath.row];
    MagazineManager *manager = [MagazineManager sharedInstance];

    //NSString *backFilename = [[NSBundle mainBundle] --pathForResource:[cellDic objectForKey:@"backImage"] ofType:nil inDirectory:@"book"];
    NSString *backFilename =  [manager.currentIssuePath stringByAppendingPathComponent:[cellDic objectForKey:@"backImage"]];
    UIImage *img = [UIImage imageWithContentsOfFile:backFilename];
    [cell.bImageView setImage:img];
    
    //NSString *filename = [[NSBundle mainBundle] --pathForResource:[cellDic objectForKey:@"file"] ofType:nil inDirectory:@"book"];
    NSString *filename = [manager.currentIssuePath stringByAppendingPathComponent:[cellDic objectForKey:@"file"]];
    [cell.scrollImage setImage:[UIImage imageWithContentsOfFile:filename]];
        cell.scrollView.contentSize=CGSizeMake(1338, 333);
    [cell.scrollView setContentOffset:CGPointMake(570, 0)];
    
    //NSString *infoFilename = [[NSBundle mainBundle] --pathForResource:[cellDic objectForKey:@"popImage"] ofType:nil inDirectory:@"book"];
    NSString *infoFilename = [manager.currentIssuePath stringByAppendingPathComponent:[cellDic objectForKey:@"popImage"]];
    [cell.infoImageButton setImage:[UIImage imageWithContentsOfFile:infoFilename] forState:UIControlStateNormal];
    
    [cell setScrollDelegate];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [super dealloc];
}
@end
