//
//  KuadMediationBanner.m
//  iLoveWretch
//
//  Created by Ming Hui Ho on 13/6/20.
//  Copyright (c) 2013年 dearhui.com. All rights reserved.
//

#import "KuadMediationBanner.h"
#import "IWAppDelegate.h"
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return [(IWAppDelegate *)[[UIApplication sharedApplication] delegate] splitViewController];
    else
        return [(IWAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController];
}

@end
