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
#import "KuAD.h"

@interface AdWhirlAdapterKuAd() <KuADDelegate>
    @property (nonatomic, strong) KuAD *kuAdViewController;
    @property (nonatomic, strong) UIView *kuadView;
@end

@implementation AdWhirlAdapterKuAd

#pragma mark - AdWhirlAdNetworkRegistry
+ (void)load {
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:self];
}

+ (AdWhirlAdNetworkType)networkType {
#if 0
    return AdWhirlAdNetworkTypeBrightRoll;  // !!!! 取代掉
#else
    return AdWhirlAdNetworkTypeGreyStripe;
#endif
}

#pragma mark - AdWhirlAdNetworkAdapter
- (void)getAd {
    self.kuAdViewController = [[KuAD alloc] init];
	[self.kuAdViewController setDelegate:self];
    self.kuadView = [self.kuAdViewController mmcWithKuAD:[self publisherId]
                                                  adRect:CGRectMake(0, 0, 320, 48)
                                      yourRootController:[adWhirlDelegate viewControllerForPresentingModalView]
                                     yourStatusBarHidden:NO];
    
//    [self.kuAdViewController appStart];
}

- (void)stopBeingDelegate {
    if (self.adNetworkView != nil
        && [self.adNetworkView respondsToSelector:@selector(setDelegate:)])
    {
        [self.adNetworkView performSelector:@selector(setDelegate:)
                                 withObject:nil];
        [self.kuAdViewController setDelegate:nil];
    }
}

#pragma mark - kuADDelegate
- (void) KuADStatus:(BOOL)status
{
    if (status) {
        [adWhirlView adapter:self didReceiveAdView:self.kuadView];
    }else {
        #ifdef DEBUG
            NSLog(@"kuADStatus %d", status);
        #endif
    }
}

#pragma mark - pubId

- (SEL)delegatePublisherIdSelector {
    return @selector(brightRollAppId);
}

- (NSString *)publisherId {
    return networkConfig.pubId;
}

@end
