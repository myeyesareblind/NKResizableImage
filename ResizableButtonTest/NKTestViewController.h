//
//  NKTestViewController.h
//  ResizableButtonTest
//
//  Created by myeyesareblind on 3/18/14.
//  Copyright (c) 2014 myeyesareblind. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NKDrawNinePartImageView, NKResizableButton;
@interface NKTestViewController : NSViewController

@property (readwrite) IBOutlet NKResizableButton*       resizableButton;
@property (readwrite) IBOutlet NKDrawNinePartImageView* ninePartImageView;

@end
