//
//  VponAdmobCustomAd.m
//  iphone-vpon-sdk
//
//  Created by vpon on 13/4/23.
//  Copyright (c) 2013年 com.vpon. All rights reserved.
//

#import "VponMediationBanner.h"

@implementation VponMediationBanner

// Will be set by the AdMob SDK.
@synthesize delegate = _delegate;
@synthesize vponBannerAd = _vponBannerAd;
#pragma mark -
#pragma mark GADCustomEventBanner

-(void)dealloc
{
    if(nil != _delegate)
    {
        _delegate = nil;
    }
    if(nil != _vponBannerAd)
    {
        [_vponBannerAd setDelegate:nil];
        _vponBannerAd = nil;
    }
}

- (void)requestBannerAd:(GADAdSize)adSize parameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint origin =CGPointMake(0.0,0.0);
    NSString* strSizeType = NSStringFromGADAdSize(adSize);
    
    VponAdSize vponAdSize = VponAdSizeSmartBannerPortrait;
    if([strSizeType isEqualToString:@"kGADAdSizeBanner"])
        vponAdSize = VponAdSizeBanner;
    else if([strSizeType isEqualToString:@"kGADAdSizeFullBanner"])
        vponAdSize = VponAdSizeFullBanner;
    else if([strSizeType isEqualToString:@"kGADAdSizeLeaderboard"])
        vponAdSize = VponAdSizeLeaderboard;
    else if([strSizeType isEqualToString:@"kGADAdSizeSmartBannerLandscape"])
        vponAdSize = VponAdSizeSmartBannerLandscape;
    else if([strSizeType isEqualToString:@"kGADAdSizeMediumRectangle"])
        vponAdSize = VponAdSizeMediumRectangle;
    
    if(_vponBannerAd != nil)
    {
        [_vponBannerAd setDelegate:nil];
        _vponBannerAd = nil;
    }
    _vponBannerAd = [[VponBanner alloc] initWithAdSize:vponAdSize origin:origin];
    _vponBannerAd.strBannerId = serverParameter;
    _vponBannerAd.delegate = self;
    _vponBannerAd.platform = TW;
    [_vponBannerAd setAdAutoRefresh:NO];
    [_vponBannerAd setLocationOnOff:YES]; // 不使用定位功能
    [_vponBannerAd setRootViewController:window.rootViewController];
    [_vponBannerAd startGetAd:[self getTestIdentifiers]];
}

- (void)onVponGetAd:(UIView *)bannerView
{
    [bannerView removeFromSuperview];
    [self.delegate customEventBanner:self didReceiveAd:bannerView];
}

#pragma mark 通知拉取廣告成功pre-fetch完成
- (void)onVponAdReceived:(UIView *)bannerView
{
}
#pragma mark 通知拉取廣告失敗
- (void)onVponAdFailed:(UIView *)bannerView didFailToReceiveAdWithError:(NSError *)error
{
    [self.delegate customEventBanner:self didFailAd:error];
}
#pragma mark 通知開啟vpon廣告頁面
- (void)onVponPresent:(UIView *)bannerView
{
    [self.delegate customEventBannerWillPresentModal:self];
}
#pragma mark 通知關閉vpon廣告頁面
- (void)onVponDismiss:(UIView *)bannerView
{
    [self.delegate customEventBannerDidDismissModal:self];
}
#pragma mark 通知離開publisher application
- (void)onVponLeaveApplication:(UIView *)bannerView
{
    [self.delegate customEventBannerWillLeaveApplication:self];
}

-(NSArray*)getTestIdentifiers
{
    return [NSArray arrayWithObjects:
            // add your test Id
            nil];
}

@end