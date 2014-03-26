//
//  NKResizableButton.h
//  ResizableButtonTest
//
//  Created by myeyesareblind on 3/18/14.
//  Copyright (c) 2014 myeyesareblind. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NKResizableImage;
@interface NKResizableButton : NSButton

@property (readwrite, nonatomic) NKResizableImage* backgroundImage;
@property (readwrite, nonatomic) NKResizableImage* highlightedBackgroundImage;

@end
