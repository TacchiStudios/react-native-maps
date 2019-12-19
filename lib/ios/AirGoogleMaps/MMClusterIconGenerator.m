//
//  MMClusterIconGenerator.m
//  AirMaps
//
//  Created by Mark McFarlane on 2019/12/17.
//  Copyright © 2019 Christopher. All rights reserved.
//

#import "MMClusterIconGenerator.h"

#define UIColorFromHEX(hexValue)                                         \
  [UIColor colorWithRed:((CGFloat)((hexValue & 0xff0000) >> 16)) / 255.0 \
                  green:((CGFloat)((hexValue & 0x00ff00) >> 8)) / 255.0  \
                   blue:((CGFloat)((hexValue & 0x0000ff) >> 0)) / 255.0  \
                  alpha:1.0]

// Default bucket background colors when no background images are set.
static NSArray<UIColor *> *kGMUBucketBackgroundColors;

@implementation MMClusterIconGenerator {
  NSCache *_iconCache;
}

- (instancetype)init {
  if ((self = [super init]) != nil) {
    _iconCache = [[NSCache alloc] init];
  }
  return self;
}

- (UIImage *)iconForSize:(NSUInteger)size {
  NSString *text;
    
  text = [NSString stringWithFormat:@"%ld", (unsigned long)size];

  UIImage *image = [UIImage imageNamed:@"clusterPin"];

  UIImage *icon = [_iconCache objectForKey:text];
  if (icon != nil) {
    return icon;
  }
    
    CGFloat scale = 1;
    if (size > 999) {
//        scale = 1.1; // Gets clipped. Find out why
    } else if (size < 100 && size > 9) {
        scale = 0.8;
    } else if (size <= 9) {
        scale = 0.6;
    }
    
  UIFont *font = [UIFont boldSystemFontOfSize:15];
  CGSize imageSize = image.size;
  UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    CGRect imageRect = CGRectMake(0, 0, imageSize.width * scale, imageSize.height * scale);
  [image drawInRect:imageRect];
  CGRect rect = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);

  NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  NSDictionary *attributes = @{
    NSFontAttributeName : font,
    NSParagraphStyleAttributeName : paragraphStyle,
    NSForegroundColorAttributeName : [UIColor whiteColor]
  };
  CGSize textSize = [text sizeWithAttributes:attributes];
  CGRect textRect = CGRectInset(rect, (rect.size.width - textSize.width) / 2,
                                (rect.size.height - textSize.height) / 2 -
                                (10 * scale));
  [text drawInRect:CGRectIntegral(textRect) withAttributes:attributes];

  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  [_iconCache setObject:newImage forKey:text];
  return newImage;
}

@end
