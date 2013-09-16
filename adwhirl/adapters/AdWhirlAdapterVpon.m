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
#import "VponBanner.h"

@interface AdWhirlAdapterVpon () <VponBannerDelegate>
   @property (nonatomic, strong) VponBanner *vponBannerAd;
@end

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
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint origin =CGPointMake(0.0,0.0);
    
    if(_vponBannerAd != nil)
    {
        [_vponBannerAd setDelegate:nil];
        _vponBannerAd = nil;
    }
    _vponBannerAd = [[VponBanner alloc] initWithAdSize:VponAdSizeBanner origin:origin];
    _vponBannerAd.strBannerId = [self publisherId];
    _vponBannerAd.delegate = self;
    _vponBannerAd.platform = TW;
    [_vponBannerAd setAdAutoRefresh:NO];
    [_vponBannerAd setRootViewController:window.rootViewController];
    [_vponBannerAd startGetAd:[self getTestIdentifiers]];
}

-(NSArray*)getTestIdentifiers
{
    return [NSArray arrayWithObjects:
            // add your test Id
            nil];
}

- (void)stopBeingDelegate {

}

#pragma mark - VponBannerDelegate
- (void)onVponGetAd:(UIView *)bannerView
{
    [bannerView removeFromSuperview];
    [adWhirlView adapter:self didReceiveAdView:bannerView];
}

#pragma mark 通知拉取廣告成功pre-fetch完成
- (void)onVponAdReceived:(UIView *)bannerView
{
//    [adWhirlView adapter:self didReceiveAdView:bannerView];
}
#pragma mark 通知拉取廣告失敗
- (void)onVponAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error
{
    [adWhirlView adapter:self didFailAd:error];
}
#pragma mark 通知開啟vpon廣告頁面
- (void)onVponPresent:(UIView *)bannerView
{
//    [self.delegate customEventBannerWillPresentModal:self];
}
#pragma mark 通知關閉vpon廣告頁面
- (void)onVponDismiss:(UIView *)bannerView
{
//    [self.delegate customEventBannerDidDismissModal:self];
}
#pragma mark 通知離開publisher application
- (void)onVponLeaveApplication:(UIView *)bannerView
{
//    [self.delegate customEventBannerWillLeaveApplication:self];
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
