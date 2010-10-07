//
//  ImageScrollView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import "XCGalleryInerScrollView.h"


@implementation XCGalleryInerScrollView

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return [self.subviews objectAtIndex:0];
}


-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
//		[self setUserInteractionEnabled:YES];
		self.delegate = self;
	}
	return self;
}


+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center {
	
    CGRect zoomRect;
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
	
    return zoomRect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	if ([touch tapCount] == 2) {
		CGRect zoomRect;
		if (self.zoomScale > 1.0) {
			zoomRect = self.bounds;
		} else {
			zoomRect = [XCGalleryInerScrollView zoomRectForScrollView:self
													withScale:2.0
												   withCenter:[touch locationInView:self]];
		}
		[self zoomToRect:zoomRect animated:YES];
	}
	
//		NSLog(@"offset: %@", NSStringFromCGPoint(self.contentOffset));
}

@end