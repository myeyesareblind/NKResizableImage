#import "UMHihglightableButton.h"
#import "ImagePanel.h"


NSString* const kUMHihglightableButton_ClickImage_KeyPath = @"click_image";
NSString* const kUMHihglightableButton_HoverImage_KeyPath = @"hover_image";
NSString* const kUMHihglightableButton_NormalImage_KeyPath = @"normal_image";
NSString* const kUMHihglightableButton_Image_Inset = @"image_resize_inset";


@interface UMHihglightableButton ()

@property (readwrite) double      imageInset;
@property (readwrite) ImagePanel* clickImage;
@property (readwrite) ImagePanel* hoverImage;
@property (readwrite) ImagePanel* normalImage;

@end

@implementation UMHihglightableButton
@synthesize
clickImage = _clickImage,
hoverImage = _hoverImage,
normalImage = _normalImage,
imageInset = _imageInset;

- (void)drawRect:(NSRect)dirtyRect
{
    ImagePanel* currentImage = nil;
    if (self.disabled)
    {
        currentImage = self.normalImage;
    }
    else if ([self.cell isHighlighted])
    {
        currentImage = self.clickImage;
    }
    else if (self.mouseOver)
    {
        currentImage = self.hoverImage;
    }
    else
    {
        currentImage = self.normalImage;
    }
    
    if (self.isFlipped)
    {
        NSAffineTransform*  theAffineTransform = [NSAffineTransform transform];
        [theAffineTransform scaleXBy:1.0 yBy:-1.0];
        [theAffineTransform translateXBy:0.0
                                     yBy:-self.frame.size.height];
        [theAffineTransform concat];
        [currentImage drawInRect:self.bounds];
        [theAffineTransform invert];
        [theAffineTransform concat];
    }
    else
    {
        [currentImage drawInRect:self.bounds];
    }
	[super drawRect:dirtyRect];
}

-(void)updateWithMouseIsOver:(BOOL)mouseOver
{
    [self setNeedsDisplay:YES];
}

-(void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:kUMHihglightableButton_Image_Inset])
    {
        NSNumber* number = value;
        NSAssert([number isKindOfClass:[NSNumber class]], @"incorrect type in xib");
        self.imageInset = number.intValue;
        
        return ;
    }
    
    if ([keyPath isEqualToString:kUMHihglightableButton_ClickImage_KeyPath])
    {
        NSImage* clickImage = [NSImage imageNamed:value];
        [self setClickImage:clickImage withResizableInset:self.imageInset];
        if (!self.clickImage)
        {
            DLog(@"no image found named %@", value);
        }
        return ;
    }
    if ([keyPath isEqualToString:kUMHihglightableButton_HoverImage_KeyPath])
    {
        NSImage* hoverImage = [NSImage imageNamed:value];
        [self setHoverImage:hoverImage withResizableInset:self.imageInset];
        if (!self.hoverImage)
        {
            DLog(@"no image found named %@", value);
        }
        return ;
    }
    if ([keyPath isEqualToString:kUMHihglightableButton_NormalImage_KeyPath])
    {
        NSImage* normalImage = [NSImage imageNamed:value];
        [self setNormalImage:normalImage withResizableInset:self.imageInset];
        if (!self.normalImage)
        {
            DLog(@"no image found named %@", value);
        }
        return ;
    }
    [super setValue:value forKeyPath:keyPath];
}

-(void)setClickImage:(NSImage*)clickImage withResizableInset:(double)resizableInset
{
    self.clickImage = [[ImagePanel alloc] initWithInset:resizableInset image:clickImage];
}

-(void)setHoverImage:(NSImage*)hoverImage withResizableInset:(double)resizableInset
{
    self.hoverImage = [[ImagePanel alloc] initWithInset:resizableInset image:hoverImage];
}

-(void)setNormalImage:(NSImage*)normalImage withResizableInset:(double)resizableInset
{
    self.normalImage = [[ImagePanel alloc] initWithInset:resizableInset image:normalImage];
}

@end
