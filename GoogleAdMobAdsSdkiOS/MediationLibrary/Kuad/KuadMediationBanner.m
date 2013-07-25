//
//  KuadMediationBanner.m
//  iLoveWretch
//
//  Created by Ming Hui Ho on 13/6/20.
//  Copyright (c) 2013年 dearhui.com. All rights reserved.
//

#import "KuadMediationBanner.h"
#import "KuAD.h"

@interface KuadMediationBanner() <KuADDelegate>
    @property (nonatomic, strong) KuAD *kuAdViewController;
    @property (nonatomic, strong) UIView *kuadView;
@end

@implementation KuadMediationBanner
@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request
{
    self.kuAdViewController = [[KuAD alloc] init];
	[self.kuAdViewController setDelegate:self];
    self.kuadView = [self.kuAdViewController mmcWithKuAD:serverParameter
                                                  adRect:CGRectMake(0, 0, 320, 48)
                                      yourRootController:[self viewControllerForPresentingModalView]
                                     yourStatusBarHidden:NO];
#ifdef DEBUG
    NSLog(@"mediation get :%@, %@", serverLabel, serverParameter);
#endif
}


#pragma mark - kuADDelegate
- (void) KuADStatus:(BOOL)status
{
    if (status) {
        [self.delegate customEventBanner:self didReceiveAd:self.kuadView];
    }else {
        
    }
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [self getRootViewController];
}

// https://github.com/arashpayan/appirater
#pragma mark - method from appirater
- (id)getRootViewController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topMostViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

- (UIViewController *) topMostViewController: (UIViewController *) controller {
	BOOL isPresenting = NO;
	do {
		// this path is called only on iOS 6+, so -presentedViewController is fine here.
		UIViewController *presented = [controller presentedViewController];
		isPresenting = presented != nil;
		if(presented != nil) {
			controller = presented;
		}
		
	} while (isPresenting);
	
	return controller;
}

@end
