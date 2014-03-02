//
//  SDSegmentedTabController.h
//  SDSegmentedTabControllerDemo
//
//  Created by Yamazaki Mitsuyoshi on 3/2/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDSegmentedControl.h"

typedef enum {
	SDSegmentedTabPositionTop,
	SDSegmentedTabPositionBottom,
}SDSegmentedTabPositions;

@interface SDSegmentedTabController : UIViewController

@property (nonatomic, readonly) SDSegmentedControl *segmentedControl;
@property (nonatomic, readonly) SDSegmentedTabPositions position;
@property (nonatomic, copy) NSArray *viewControllers;

- (id)initWithPosition:(SDSegmentedTabPositions)position;

@end

@interface SDSegmentedTabItem : NSObject

@property (nonatomic, readonly) NSString *title;
- (id)initWithTitle:(NSString *)title;
@end

@interface UIViewController (SDSegmentedTabController)

- (SDSegmentedTabController *)segmentedTabController;
- (void)setSegmentedTabItem:(SDSegmentedTabItem *)item;
- (SDSegmentedTabItem *)segmentedTabItem;
@end
