//
//  PlayMovieViewController.h
//  MsyamingEbook
//
//  Created by tsai kevin on 12/11/15.
//  Copyright (c) 2012年 tsai kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayMovieViewController : GAITrackedViewController{
    MPMoviePlayerController *theMovie;
    NSDictionary *myDic;
}
@property (retain, nonatomic) MPMoviePlayerController *theMovie;
@property (retain, nonatomic) IBOutlet UIView *movieView;
@property (retain, nonatomic) NSDictionary *myDic;

- (IBAction)close:(id)sender;
-(id)initWithData:(NSDictionary *)dic;
@end
