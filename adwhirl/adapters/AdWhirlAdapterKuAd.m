//
//  AdWhirlAdapterKuAd.m
//  adwhirlSDK
//
//  Created by Ming-Hui Ho on 12/4/6.
//  Copyright (c) 2012年 Octtel. All rights reserved.
//

#import "AdWhirlAdapterKuAd.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlView.h"
#import "AdWhirlLog.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"

@implementation AdWhirlAdapterKuAd

#pragma mark - AdWhirlAdNetworkRegistry
+ (void)load {
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:self];
}

+ (AdWhirlAdNetworkType)networkType {
    return AdWhirlAdNetworkTypeBrightRoll;  // !!!! 取代掉
}

#pragma mark - AdWhirlAdNetworkAdapter

#ifdef USES_NEW_KUAD_LIB

- (void)getAd {
    
    NSLog(@"KuadPid %@", [self publisherId]);
    
    _ad = [[[kuADController alloc] init] autorelease];
    [_ad setKuDelegate:self];
    
    _kuAdView = [_ad kuADId:[self publisherId]
                    adRect:kKuAdBannerSize320x48
        yourRootController:[adWhirlDelegate viewControllerForPresentingModalView]
       yourStatusBarHidden:NO];
    
    self.adNetworkView = [_kuAdView autorelease];
}

- (void)stopBeingDelegate {
    NSLog(@"KuAd stopBeingDelegate");
    if (self.adNetworkView != nil
        && [self.adNetworkView respondsToSelector:@selector(setDelegate:)]) {
        [self.adNetworkView performSelector:@selector(setDelegate:)
                                 withObject:nil];
    }
}

#else
- (void)getAd {
    kuADController *Kuad = [[[kuADController alloc] init] autorelease];
    
    self.adNetworkView = [Kuad kuADId:[self publisherId]
                              adRect:kKuAdBannerSize320x48
                  yourRootController:[adWhirlDelegate viewControllerForPresentingModalView]
                 yourStatusBarHidden:NO];
    [adWhirlView adapter:self didReceiveAdView:self.adNetworkView];
}

- (void)stopBeingDelegate {
#ifdef DEBUG
//   NSLog(@"KuAd stopBeingDelegate");
#endif
    if (self.adNetworkView != nil
        && [self.adNetworkView respondsToSelector:@selector(setDelegate:)]) {
        [self.adNetworkView performSelector:@selector(setDelegate:)
                                 withObject:nil];
    }
}

#endif

- (void)dealloc {
#ifdef DEBUG
//    NSLog(@"Kuad dealloc");
#endif
//    _ad = nil;
//    _kuAdView = nil;
//    [_kuAdView release];
//    [_ad release];
	[super dealloc];
}

#ifdef USES_NEW_KUAD_LIB
    #pragma mark - kuADDelegate
    - (void) kuADStatus:(BOOL)status
    {
        NSLog(@"kuADStatus %d", status);
        if (status) {
            [adWhirlView adapter:self didReceiveAdView:_kuAdView];
        }else {
    // KuAd 會連傳兩次事件，這邊就不再做處理        
    //        NSError *error = nil;
    //        [adWhirlView adapter:self didFailAd:error];
        }
    }
#endif

#pragma mark - pubId

- (SEL)delegatePublisherIdSelector {
    return @selector(brightRollAppId);
}

- (NSString *)publisherId {
    SEL delegateSelector = [self delegatePublisherIdSelector];
    
    if ((delegateSelector) &&
        ([adWhirlDelegate respondsToSelector:delegateSelector])) {
        return [adWhirlDelegate performSelector:delegateSelector];
    }
    
    return networkConfig.pubId;
}

@end
