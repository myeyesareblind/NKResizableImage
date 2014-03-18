//
//  NKTestViewController.m
//  ResizableButtonTest
//
//  Created by myeyesareblind on 3/18/14.
//  Copyright (c) 2014 myeyesareblind. All rights reserved.
//

#import "NKTestViewController.h"
#import "NKDrawNinePartImageView.h"
#import "NKResizableImage.h"

@interface NKTestViewController ()

@end

@implementation NKTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    self.ninePartImageView.image = [[NKResizableImage alloc] initWithImage:[NSImage imageNamed:@"tile_panel.png"]
                                                                edgeInsets:NSEdgeInsetsMake(0,
                                                                                            44,
                                                                                            5,
                                                                                            5)];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"frame:%@", NSStringFromRect(self.ninePartImageView.frame));
    });
}

- (void)dealloc
{
    
}

@end
