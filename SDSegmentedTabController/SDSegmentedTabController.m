//
//  SDSegmentedTabController.h
//  SDSegmentedTabControllerDemo
//
//  Created by Yamazaki Mitsuyoshi on 3/2/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "SDSegmentedTabController.h"

@interface SDSegmentedTabController ()

@property (nonatomic, readonly) UIView *contentView;

- (void)didChangeSelectedIndex:(id)sender;

@end

@implementation SDSegmentedTabController

@synthesize segmentedControl = _segmentedControl;
@synthesize contentView = _contentView;
@synthesize position = _position;
@synthesize viewControllers = _viewControllers;

- (id)initWithPosition:(SDSegmentedTabPositions)position {
	
	self = [super init];
	if (self) {
		_position = position;
		[self view];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	self.view.backgroundColor = [UIColor whiteColor];

	[self.view addSubview:self.segmentedControl];
	[self.view addSubview:self.contentView];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Appearance and Rotation Methods
#pragma mark iOS6
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
	return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods {
	return YES;
}

#pragma mark iOS5
- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return YES;
}

#pragma mark - Accessor
- (SDSegmentedControl *)segmentedControl {
	
	if (_segmentedControl == nil) {
		
		CGRect frame = self.view.bounds;
		frame.size.height = 43.0f;
		
		UIViewAutoresizing autoresizing;
		
		switch (self.position) {
			case SDSegmentedTabPositionTop:
				autoresizing = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
				break;
				
			case SDSegmentedTabPositionBottom:
				frame.origin.y = self.view.bounds.size.height - frame.size.height;

				autoresizing = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
				break;
				
			default:
				break;
		}
		
		_segmentedControl = [[SDSegmentedControl alloc] initWithItems:@[]];
		_segmentedControl.frame = frame;
		_segmentedControl.backgroundColor = [UIColor whiteColor];
		_segmentedControl.arrowSize = 0.0f;
		
		_segmentedControl.autoresizingMask = autoresizing;
		[_segmentedControl addTarget:self action:@selector(didChangeSelectedIndex:) forControlEvents:UIControlEventValueChanged];		
	}
	return _segmentedControl;
}

- (UIView *)contentView {
	
	if (_contentView == nil) {
		
		CGRect frame = self.view.bounds;
		switch (self.position) {
			case SDSegmentedTabPositionTop:
				frame.origin.y = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
				frame.size.height -= frame.origin.y;
				break;
				
			case SDSegmentedTabPositionBottom:
				frame.size.height -= self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height;
				break;
				
			default:
				break;
		}
		
		_contentView = [[UIView alloc] initWithFrame:frame];
		_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_contentView.clipsToBounds = YES;
	}
	return _contentView;
}

- (void)setViewControllers:(NSArray *)viewControllers {
	
	CGRect childViewFrame = self.contentView.bounds;
	[self.segmentedControl removeAllSegments];
	NSInteger index = 0;
	
	for (UIViewController *controller in viewControllers) {
		[controller.view removeFromSuperview];
		[controller removeFromParentViewController];
		[controller willMoveToParentViewController:self];
		
		controller.view.frame = childViewFrame;
		
		[self addChildViewController:controller];
		[controller didMoveToParentViewController:self];
		
		if (controller.segmentedTabItem) {
			[self.segmentedControl insertSegmentWithTitle:controller.segmentedTabItem.title atIndex:index animated:NO];
		}
		else {
			[self.segmentedControl insertSegmentWithTitle:@" " atIndex:index animated:NO];
		}
		
		index++;
	}
	
	_viewControllers = viewControllers.copy;
		
	self.segmentedControl.selectedSegmentIndex = 0;
	[self didChangeSelectedIndex:self.segmentedControl];
	
	// TODO: Inherit the previous selected view
	
	//	self.selectedIndex = 0;
	//	self.tabBar.selectedIndex = 0;
}

#pragma mark - 
- (void)didChangeSelectedIndex:(id)sender {

	[self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	NSInteger selectedIndex = self.segmentedControl.selectedSegmentIndex;
	UIViewController *viewController = self.viewControllers[selectedIndex];
	
	viewController.view.frame = self.contentView.bounds;
	[self.contentView addSubview:viewController.view];
}

@end

@implementation SDSegmentedTabItem

@synthesize title = _title;

- (id)initWithTitle:(NSString *)title {
	self = [super init];
	if (self) {
		_title = title.copy;
	}
	return self;
}

@end

@implementation UIViewController (SDSegmentedTabController)

- (SDSegmentedTabController *)segmentedTabController {
	
	for (UIViewController *viewController = self.parentViewController; viewController != nil; viewController = viewController.parentViewController) {
		if ([viewController isKindOfClass:[SDSegmentedTabController class]]) {
			return (SDSegmentedTabController *)viewController;
		}
	}
	return nil;
}

- (void)setSegmentedTabItem:(SDSegmentedTabItem *)item {
	self.tabBarItem = (id)item;
}

- (SDSegmentedTabItem *)segmentedTabItem {
	if ([self.tabBarItem isKindOfClass:[SDSegmentedTabItem class]]) {
		return (SDSegmentedTabItem *)self.tabBarItem;
	}
	return nil;
}

@end
