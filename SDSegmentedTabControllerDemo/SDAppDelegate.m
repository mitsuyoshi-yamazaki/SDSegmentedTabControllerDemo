//
//  SDAppDelegate.m
//  SDSegmentedTabControllerDemo
//
//  Created by Yamazaki Mitsuyoshi on 3/2/14.
//  Copyright (c) 2014 Mitsuyoshi. All rights reserved.
//

#import "SDAppDelegate.h"

#import "SDSegmentedTabController.h"

@implementation SDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
	SDSegmentedTabController *segmentedTabController = [[SDSegmentedTabController alloc] initWithPosition:SDSegmentedTabPositionTop];
	
	segmentedTabController.title = @"DEMO";
	segmentedTabController.viewControllers = @[
											   [self childViewControllerWithTitle:@"View001" color:[UIColor magentaColor]],
											   [self childViewControllerWithTitle:@"View002" color:[UIColor brownColor]],
											   [self childViewControllerWithTitle:@"View003" color:[UIColor darkGrayColor]],
											   [self childViewControllerWithTitle:@"View004" color:[UIColor cyanColor]],
											   ];
	
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:segmentedTabController];
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (UIViewController *)childViewControllerWithTitle:(NSString *)title color:(UIColor *)color {
	
	UIViewController *viewController = [[UIViewController alloc] init];
	
	CGRect frame = viewController.view.bounds;
	frame.size.width -= 20.0f;
	frame.size.height -= 20.0f;
	
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.center = viewController.view.center;
	label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	label.backgroundColor = color;
	label.font = [UIFont boldSystemFontOfSize:60.0f];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.text = title;
	
	[viewController.view addSubview:label];
	viewController.segmentedTabItem = [[SDSegmentedTabItem alloc] initWithTitle:title];
	
	return viewController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
