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
#import "NKResizableButton.h"

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
    self.ninePartImageView.image = [[NKResizableImage alloc] initWithImage:[NSImage imageNamed:@"tile_panel"]
                                                                edgeInsets:NSEdgeInsetsMake(50,
                                                                                            44,
                                                                                            5,
                                                                                            5)];
    self.resizableButton.backgroundImage = [[NKResizableImage alloc] initWithImage:[NSImage imageNamed:@"button"]
                                                                         edgeInset:20];
    
    self.resizableButton.highlightedBackgroundImage = [[NKResizableImage alloc] initWithImage:[NSImage imageNamed:@"button_hl"]
                                                                                    edgeInset:20];
}

- (void)dealloc
{
    
}

@end
