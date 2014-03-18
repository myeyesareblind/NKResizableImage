//
//  NKResizableButton.m
//  ResizableButtonTest
//
//  Created by myeyesareblind on 3/18/14.
//  Copyright (c) 2014 myeyesareblind. All rights reserved.
//

#import "NKResizableButton.h"
#import "NKResizableImage.m"
@interface NKResizableButton ()
{
    NKResizableImage* m_image;
}
@end

@implementation NKResizableButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (self.isFlipped)
    {
        NSAffineTransform*  theAffineTransform = [NSAffineTransform transform];
        [theAffineTransform scaleXBy:1.0 yBy:-1.0];
        [theAffineTransform translateXBy:0.0
                                     yBy:-self.frame.size.height];
        [theAffineTransform concat];
        [m_image drawInRect:self.bounds];
        [theAffineTransform invert];
        [theAffineTransform concat];
    }
    else
    {
        [m_image drawInRect:self.bounds];
    }
	[super drawRect:dirtyRect];
}

@end
