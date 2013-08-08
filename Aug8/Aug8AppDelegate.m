//
//  Aug8AppDelegate.m
//  Aug8
//
//  Created by david morton on 8/8/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "Aug8AppDelegate.h"
#import "TableViewController.h"
#import "Airport.h"

@implementation Aug8AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
	//UITableViewCellStyleSubtitle or UITableViewStylePlain
	TableViewController *tableViewController=[[TableViewController alloc] initWithStyle: UITableViewStylePlain];
	
	self.window.rootViewController =[[UINavigationController alloc] initWithRootViewController: tableViewController];
	
	//self.window.rootViewController = tableViewController;
	
	
	
	//*** START OF GETTING AIRPORT DATA ***
	_airports=[[NSMutableArray alloc] init];
	NSError *error = nil;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"airports" ofType:@"csv"];
	NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	
	NSArray *b =[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	
	if(error) NSLog(@"ERROR while loading from file: %@", error);
	else{
		
		for (NSUInteger j = 0; j < [b count]; ++j) {
			NSArray* foo = [b[j] componentsSeparatedByString: @","];
			if([foo count]==5 && [foo[4] length]>3 ){
				Airport *airport=[[Airport alloc] init];
				airport.code=foo[0];
				airport.country=foo[1];
				airport.city=foo[2];
				airport.stateProvince=foo[3];
				airport.name=[foo[4] capitalizedString];
				[_airports addObject:airport];
			}
		}
		
	}
	//*** END OF GETTING AIRPORT DATA ***

	tableViewController.title=@"Select Airport";
	tableViewController.airports=_airports;
	
    [self.window makeKeyAndVisible];
    return YES;
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
