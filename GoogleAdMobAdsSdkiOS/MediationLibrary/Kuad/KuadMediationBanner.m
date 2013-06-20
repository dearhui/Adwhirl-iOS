//
//  KuadMediationBanner.m
//  iLoveWretch
//
//  Created by Ming Hui Ho on 13/6/20.
//  Copyright (c) 2013年 dearhui.com. All rights reserved.
//

#import "KuadMediationBanner.h"
#import "IWAppDelegate.h"
#import "kuADController.h"

@implementation KuadMediationBanner
@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request
{
    kuADController *Kuad = [[kuADController alloc] init];
    
    UIView *adBannerView = [Kuad kuADId:serverParameter
                               adRect:CGRectMake(0, 0, 320, 48)
                   yourRootController:[self viewControllerForPresentingModalView]
                  yourStatusBarHidden:NO];

    [self.delegate customEventBanner:self didReceiveAd:adBannerView];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return [(IWAppDelegate *)[[UIApplication sharedApplication] delegate] splitViewController];
    else
        return [(IWAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController];
}
@end
