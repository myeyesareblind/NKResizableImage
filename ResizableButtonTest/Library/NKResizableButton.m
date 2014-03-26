//
//  NKResizableButton.m
//  ResizableButtonTest
//
//  Created by myeyesareblind on 3/18/14.
//  Copyright (c) 2014 myeyesareblind. All rights reserved.
//

#import "NKResizableButton.h"
#import "NKResizableImage.h"

@interface NKResizableButton ()
{
    NKResizableImage* m_backgroundImage;
    NKResizableImage* m_highlightBackgroundImage;
}
@end

@implementation NKResizableButton

- (void)drawRect:(NSRect)dirtyRect
{
    NSButtonCell* buttonCell = self.cell;
    NKResizableImage* image = m_highlightBackgroundImage != nil && buttonCell.isHighlighted
        ? m_highlightBackgroundImage
        : m_backgroundImage;
    
    if (self.isFlipped)
    {
        NSAffineTransform*  theAffineTransform = [NSAffineTransform transform];
        [theAffineTransform scaleXBy:1.0 yBy:-1.0];
        [theAffineTransform translateXBy:0.0
                                     yBy:-self.frame.size.height];
        [theAffineTransform concat];
        [image drawInRect:self.bounds];
        [theAffineTransform invert];
        [theAffineTransform concat];
    }
    else
    {
        [image drawInRect:self.bounds];
    }
	[super drawRect:dirtyRect];
}

- (void)setBackgroundImage:(NKResizableImage *)backgroundImage
{
    m_backgroundImage = backgroundImage;
    [self setNeedsDisplay];
}

- (NKResizableImage*)backgroundImage { return m_backgroundImage; }

- (void)setHighlightedBackgroundImage:(NKResizableImage *)highlightedBackgroundImage
{
    m_highlightBackgroundImage = highlightedBackgroundImage;
    [self setNeedsDisplay];
}

- (NKResizableImage*)highlightedBackgroundImage { return m_highlightBackgroundImage; }
@end
