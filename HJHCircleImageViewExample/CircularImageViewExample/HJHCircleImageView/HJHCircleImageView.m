//
//  HJHCircleImageView.m
//  CircleImageView
//
//  Created by Jonghwan Hyeon on 7/4/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "HJHCircleImageView.h"

@implementation HJHCircleImageView

- (void)awakeFromNib
{
    self.image = [self renderImage:self.image];
    self.highlightedImage = [self renderImage:self.highlightedImage];
}

- (void)setImage:(UIImage *)image
{
    [super setImage:[self renderImage:image]];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    [super setHighlightedImage:[self renderImage:highlightedImage]];
}

- (UIColor *)circleBorderColor {
    if (!_circleBorderColor) {
        _circleBorderColor = [UIColor blackColor];
    }
    
    return _circleBorderColor;
}

- (UIImage *)renderImage:(UIImage *)image
{
    if (!image) return nil;
    
    CGFloat length = MIN(image.size.width, image.size.height);
    CGRect frame = CGRectMake(0.0, 0.0, length, length);
    CGRect bounds = CGRectMake(-((image.size.width - length) / 2), -((image.size.height - length) / 2),
                               image.size.width, image.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(length, length));

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:length / 2];
    [bezierPath addClip];
    
    if (self.circleBackgroundColor) {
        [self.circleBackgroundColor setFill];
        [bezierPath fill];
    }
    
    [image drawInRect:bounds];
    
    if (self.circleBorderWidth > 0.0) {
        [self.circleBorderColor setStroke];
        bezierPath.lineWidth = self.circleBorderWidth * 2; // to stroke exactly self.borderWidth insdie
        [bezierPath stroke];
    }
    
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return renderedImage;
}

@end
