#import <Foundation/Foundation.h>

@interface NKResizableImage : NSObject

- (id)initWithImage:(NSImage *)image edgeInsets:(NSEdgeInsets)insets;
- (id)initWithImage:(NSImage *)image edgeInset:(CGFloat)inset;

- (void)drawInRect:(NSRect)drawRect;

@end
