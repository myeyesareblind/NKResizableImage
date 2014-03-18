#import "NKResizableImage.h"

@interface NSImage (Additions)
- (void)drawInRectCorrect:(NSRect)rect;
@end

const float NKResizableImageFraction = 1.0;

@implementation NSImage (Additions)

- (NSImage*)createImageFromRect:(NSRect)rct
{
    if (rct.size.width == 0
        || rct.size.height == 0)
    {
        return nil;
    }
    
    NSRect rctDest = rct;
    rctDest.origin.x = 0;
    rctDest.origin.y = 0;
    
    NSImage* img = [[NSImage alloc] initWithSize:rct.size];
    [img lockFocus];
    [self drawInRect:rctDest
            fromRect:rct
           operation:NSCompositeCopy
            fraction:1.0];
    [img unlockFocus];
    return img;
}

- (void)drawInRectCorrect:(NSRect)rect
{
    NSRect srcRect = NSMakeRect(0., 0., self.size.width, self.size.height);
    [self drawInRect:rect
            fromRect:srcRect
           operation:NSCompositeSourceOver
            fraction:NKResizableImageFraction];
}
@end

@interface NKResizableImage()
{
    NSImage* m_leftTop;
    NSImage* m_leftBot;
    NSImage* m_leftCenter;
    
    NSImage* m_centerTop;
    NSImage* m_centerCenter;
    NSImage* m_centerBot;
    
    NSImage* m_rightTop;
    NSImage* m_rightCenter;
    NSImage* m_rightBot;
}

- (void)loadNineImageWithImage:(NSImage*)image insets:(NSEdgeInsets)insets;

@end

@implementation NKResizableImage

- (id)initWithImage:(NSImage *)image edgeInset:(CGFloat)inset
{
    return [self initWithImage:image
                    edgeInsets:NSEdgeInsetsMake(inset, inset, inset, inset)];
}

- (id)initWithImage:(NSImage *)image edgeInsets:(NSEdgeInsets)insets
{
    self = [super init];
    if (self)
    {
        NSAssert(insets.top + insets.bottom + 1 < image.size.height
                 && insets.left + insets.right + 1 < image.size.width,
                 @"incorrect insets or image too small");
        [self loadNineImageWithImage:image
                              insets:insets];
    }
    return self;
}

- (void)loadNineImageWithImage:(NSImage*)image insets:(NSEdgeInsets)insets
{
    NSSize imgSize = image.size;
    
    NSInteger centerHeight = image.size.height - insets.top - insets.bottom;
    NSInteger centerWidth  = image.size.width - insets.left - insets.right;
    
    m_leftBot    = [image createImageFromRect:NSMakeRect(0, 0, insets.left, insets.bottom)];
    m_leftCenter = [image createImageFromRect:NSMakeRect(0, insets.bottom, insets.left, centerHeight)];
    m_leftTop    = [image createImageFromRect:NSMakeRect(0, image.size.height - insets.top, insets.left, insets.top)];
    
    m_centerBot  = [image createImageFromRect:NSMakeRect(insets.left, 0, centerWidth, insets.bottom)];
    m_centerCenter = [image createImageFromRect:NSMakeRect(insets.left, insets.bottom, centerWidth, centerHeight)];
    m_centerTop  = [image createImageFromRect:NSMakeRect(insets.left, image.size.height - insets.top, centerWidth, insets.top)];
    
    NSInteger rightOriginX = image.size.width - insets.right;
    m_rightBot   = [image createImageFromRect:NSMakeRect(rightOriginX, 0, insets.right, insets.bottom)];
    m_rightCenter = [image createImageFromRect:NSMakeRect(rightOriginX, insets.bottom, insets.right, centerHeight)];
    m_rightTop   = [image createImageFromRect:NSMakeRect(rightOriginX, imgSize.height - insets.top, insets.right, insets.top)];
}


- (void)drawInRect:(NSRect)drawRect
{
    NSSize drawSize = drawRect.size;
    NSInteger leftWidth  = m_leftCenter.size.width;
    NSInteger rightWidth = m_rightCenter.size.width;
    NSInteger botHeight  = MAX(m_rightBot.size.height, m_leftBot.size.height);
    NSInteger topHeight  = MAX(m_rightTop.size.height, m_leftTop.size.height);
    NSInteger centerHeight = MIN(drawSize.height - botHeight - topHeight + 2 * NKResizableImageFraction, drawSize.height);
    NSInteger centerOriginY = MAX(botHeight - NKResizableImageFraction, 0);
    NSInteger topOriginY = drawSize.height - topHeight;
    
    [m_leftBot drawInRectCorrect:(NSMakeRect(0, 0, leftWidth, botHeight))];
    [m_leftCenter drawInRectCorrect:(NSMakeRect(0, centerOriginY, leftWidth, centerHeight))];
    [m_leftTop drawInRectCorrect:(NSMakeRect(0, topOriginY, leftWidth, topHeight))];
    
    NSInteger centerOriginX = m_leftCenter.size.width - NKResizableImageFraction;
    NSInteger centerWidth = MIN(drawSize.width + 2 * NKResizableImageFraction - leftWidth - rightWidth, drawSize.width);
    [m_centerBot drawInRectCorrect:(NSMakeRect(centerOriginX, 0, centerWidth, botHeight))];
    [m_centerCenter drawInRectCorrect:(NSMakeRect(centerOriginX, centerOriginY, centerWidth, centerHeight))];
    [m_centerTop drawInRectCorrect:(NSMakeRect(centerOriginX, topOriginY, centerWidth, topHeight))];
    
    NSInteger rightOriginX = drawSize.width - rightWidth;
    [m_rightBot drawInRectCorrect:(NSMakeRect(rightOriginX, 0, rightWidth, botHeight))];
    [m_rightCenter drawInRectCorrect:(NSMakeRect(rightOriginX, centerOriginY, rightWidth, centerHeight))];
    [m_rightTop drawInRectCorrect:(NSMakeRect(rightOriginX, topOriginY, rightWidth, topHeight))];
}

@end
