//
//  AdWhirlAdapterVpon.m
//  adwhirlSDK
//
//  Created by Ming-Hui Ho on 12/4/6.
//  Copyright (c) 2012年 Octtel. All rights reserved.
//

#import "AdWhirlAdapterVpon.h"
#import "AdWhirlAdNetworkConfig.h"
#import "AdWhirlView.h"
#import "AdWhirlLog.h"
#import "AdWhirlAdNetworkAdapter+Helpers.h"
#import "AdWhirlAdNetworkRegistry.h"

@implementation AdWhirlAdapterVpon

#pragma mark - AdWhirlAdNetworkRegistry
+ (void)load {
    [[AdWhirlAdNetworkRegistry sharedRegistry] registerClass:self];
}

+ (AdWhirlAdNetworkType)networkType {
#if 1
    return AdWhirlAdNetworkTypeAdOnTW;
#else
    return AdWhirlAdNetworkTypeInMobi;  // !!!! 取代掉
#endif
}

#pragma mark - 
- (void)getAd {
    [VponAdOn initializationPlatform:TW];
    [[VponAdOn sharedInstance] setIsVponLogo:YES];
    
    UIViewController *display = [[VponAdOn sharedInstance] adwhirlRequestDelegate:self licenseKey:[self publisherId] size:ADON_SIZE_320x48];
    
    self.adNetworkView = display.view;
}

- (void)stopBeingDelegate {
#ifdef DEBUG
//    NSLog(@"Vpon stopBeingDelegate");
#endif
//    if (self.adNetworkView != nil
//        && [self.adNetworkView respondsToSelector:@selector(setDelegate:)]) {
//        [self.adNetworkView performSelector:@selector(setDelegate:)
//                                 withObject:nil];
//    }
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - VponAdOnDelegate
- (void)clickAd:(UIViewController *)bannerView valid:(BOOL)isValid withLicenseKey:(NSString *)adLicenseKey {
#ifdef DEBUG    
    if (isValid == YES) 
    {
        NSLog(@"Vpon廣告有效點擊:%@:%@",bannerView ,adLicenseKey);        
    } else {
        NSLog(@"Vpon廣告無效點擊 也許已經點擊過了:%@:%@",bannerView ,adLicenseKey);
    }
#endif
}

// 回傳Vpon廣告抓取成功
- (void)onClickAd:(UIViewController *)bannerView withValid:(BOOL)isValid withLicenseKey:(NSString *)adLicenseKey
{
    if (isValid == YES)
    {
        NSLog(@"Vpon廣告有效點擊:%@:%@",bannerView ,adLicenseKey);
    } else {
        NSLog(@"Vpon廣告無效點擊 也許已經點擊過了:%@:%@",bannerView ,adLicenseKey);
    }
}

- (void)onRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey {
    #ifdef DEBUG
        NSLog(@"Vpon廣告抓取成功:%@:%@",bannerView ,licenseKey);
    #endif
    
    [adWhirlView adapter:self didReceiveAdView:bannerView.view];
}
- (void)onFailedToRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey {
    #ifdef DEBUG
        NSLog(@"Vpon廣告抓取失敗:%@:%@",bannerView ,licenseKey);
    #endif
    
    [adWhirlView adapter:self didFailAd:nil];
}


#pragma mark - pubId

- (SEL)delegatePublisherIdSelector {
    return @selector(inMobiAppID);  // !!! 取代掉
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
