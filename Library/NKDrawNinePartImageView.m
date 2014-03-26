#import "NKDrawNinePartImageView.h"
#import "NKResizableImage.h"

@interface NKDrawNinePartImageView()
{
    NKResizableImage* m_image;
}
@end

@implementation NKDrawNinePartImageView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    [m_image drawInRect:self.bounds];
}

- (void)setImage:(NKResizableImage*)image
{
    m_image = image;
    [self setNeedsDisplay:YES];
}

- (NKResizableImage*)image
{
    return m_image;
}

@end
