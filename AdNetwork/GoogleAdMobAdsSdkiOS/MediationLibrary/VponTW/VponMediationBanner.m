//
//  VponMediationBanner.m
//  PixnetPhotoHelper
//
//  Created by Ming Hui Ho on 12/12/12.
//  Copyright (c) 2012年 Ming Hui Ho. All rights reserved.
//

#import "VponMediationBanner.h"
#import "VponAdOn.h"
#import "AdOnPlatform.h"
#import "GADRequestError.h"

@interface VponMediationBanner() <VponAdOnDelegate>

@end

@implementation VponMediationBanner
@synthesize delegate;

#pragma mark - GADCustomEventBanner
- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request
{
#ifdef DEBUG
    NSLog(@"VponMediation parameter:%@, label:%@", serverParameter, serverLabel);
#endif
    
    [VponAdOn initializationPlatform:TW];
    [[VponAdOn sharedInstance] setIsVponLogo:YES];
    
    [[VponAdOn sharedInstance] adwhirlRequestDelegate:self licenseKey:serverParameter size:ADON_SIZE_320x48];
}

#pragma mark - VponAdOnDelegate
// 回傳Vpon廣告抓取成功
- (void)onClickAd:(UIViewController *)bannerView withValid:(BOOL)isValid withLicenseKey:(NSString *)adLicenseKey
{
#ifdef DEBUG
    if (isValid == YES)
    {
        NSLog(@"Vpon廣告有效點擊:%@:%@",bannerView ,adLicenseKey);
    } else {
        NSLog(@"Vpon廣告無效點擊 也許已經點擊過了:%@:%@",bannerView ,adLicenseKey);
    }
#endif
}

- (void)onRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey {
#ifdef DEBUG
    NSLog(@"Vpon廣告抓取成功:%@:%@",bannerView ,licenseKey);
#endif
    
    [self.delegate customEventBanner:self didReceiveAd:bannerView.view];
}
- (void)onFailedToRecevieAd:(UIViewController *)bannerView withLicenseKey:(NSString *)licenseKey {
#ifdef DEBUG
    NSLog(@"Vpon廣告抓取失敗:%@:%@",bannerView ,licenseKey);
#endif
    
    NSError *error = nil;
    error = [[NSError alloc] initWithDomain:kGADErrorDomain code:kGADErrorMediationDataError userInfo:nil];
    [self.delegate customEventBanner:self didFailAd:error];
}

@end
