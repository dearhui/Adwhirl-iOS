//
//  InMobiSampleApp_iPhoneAppDelegate.m
//  InMobiSampleApp_iPhone
//

//

#import "InMobiSampleApp_iPhoneAppDelegate.h"
#import "RootViewController.h"
#import "IMCommonUtil.h"

@implementation InMobiSampleApp_iPhoneAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    NSLog(@"sdk version:%@",[IMCommonUtil getReleaseVersion]);
    [IMCommonUtil setLogLevel:IMLogLevelTypeDebug];
    // Override point for customization after application launch.
	viewController = [[RootViewController alloc]initWithStyle:UITableViewStylePlain];
	navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    // Add the view controller's view to the window and display.
    window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    CGRect screen = [UIScreen mainScreen].bounds;
    imAdStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (screen.size.height/2) -40, screen.size.width, 80)];
    [imAdStatusLabel setBackgroundColor:[UIColor clearColor]];
    [imAdStatusLabel setFont:[UIFont systemFontOfSize:15]];
    [imAdStatusLabel setNumberOfLines:5];
    [imAdStatusLabel setTextAlignment:UITextAlignmentCenter];
    [imAdStatusLabel setTextColor:[UIColor blackColor]];
    [imAdStatusLabel setAlpha:0];
    [window addSubview:imAdStatusLabel];
    return YES;
}

- (void)animationFinished {
    imAdStatusLabel.text = nil;
}

- (void)startFadeAnimation {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    imAdStatusLabel.alpha = 0;
    [UIView commitAnimations];
}

- (void)animateAdStatusLabelWithMsg:(NSString *)msg {
    imAdStatusLabel.text = msg;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDidStopSelector:@selector(startFadeAnimation)];    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    imAdStatusLabel.alpha = 1;
    [UIView commitAnimations];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
    [viewController release];
    [window release];
    [imAdStatusLabel release];
    [super dealloc];
}


@end