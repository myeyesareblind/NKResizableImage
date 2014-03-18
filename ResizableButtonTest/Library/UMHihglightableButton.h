#import <Cocoa/Cocoa.h>
#import "UMHoverButton.h"

extern NSString* const kUMHihglightableButton_ClickImage_KeyPath;
extern NSString* const kUMHihglightableButton_HoverImage_KeyPath;
extern NSString* const kUMHihglightableButton_NormalImage_KeyPath;
extern NSString* const kUMHihglightableButton_Image_Inset;


@interface UMHihglightableButton : UMHoverButton
// Set those images or use keyPathes in xib
// image_resize_inset = (NSNumber)5
// click_image = (NSString)image_name
// hover_image = (NSString)image_name
// normal_image = (NSString)image_name
-(void)setClickImage:(NSImage*)clickImage withResizableInset:(double)resizableInset;
-(void)setHoverImage:(NSImage*)clickImage withResizableInset:(double)resizableInset;
-(void)setNormalImage:(NSImage*)clickImage withResizableInset:(double)resizableInset;

@end
