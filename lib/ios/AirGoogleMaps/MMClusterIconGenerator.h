//
//  MMClusterIconGenerator.h
//  AirMaps
//
//  Created by Mark McFarlane on 2019/12/17.
//  Copyright © 2019 Christopher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>
#import <Google-Maps-iOS-Utils/GMUClusterIconGenerator.h>

NS_ASSUME_NONNULL_BEGIN

/**
* This class places clusters into range-based buckets of size to avoid having too many distinct
* cluster icons. For example a small cluster of 1 to 9 items will have a icon with a text label
* of 1 to 9. Whereas clusters with a size of 100 to 199 items will be placed in the 100+ bucket
* and have the '100+' icon shown.
* This caches already generated icons for performance reasons.
*/
@interface MMClusterIconGenerator : NSObject<GMUClusterIconGenerator>

/**
 * Initializes the object with default buckets and auto generated background images.
 */
- (instancetype)init;

/**
 * Generates an icon with the given size.
 */
- (UIImage *)iconForSize:(NSUInteger)size;

@end

NS_ASSUME_NONNULL_END
