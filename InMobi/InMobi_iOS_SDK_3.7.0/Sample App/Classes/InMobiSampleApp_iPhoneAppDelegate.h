//
//  InMobiSampleApp_iPhoneAppDelegate.h
//  InMobiSampleApp_iPhone
//
//

#import <UIKit/UIKit.h>

#define INMOBI_APP_ID       @"a6c9966a66884d11ae6e443ddea8d393"

@class RootViewController;

@interface InMobiSampleApp_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootViewController *viewController;
	UINavigationController *navigationController;
    UILabel *imAdStatusLabel;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void)animationFinished;
- (void)startFadeAnimation;
- (void)animateAdStatusLabelWithMsg:(NSString *)msg;
@end

