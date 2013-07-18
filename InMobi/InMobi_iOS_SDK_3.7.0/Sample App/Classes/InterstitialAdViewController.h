//
//  InterstitialAdViewController.h
//  InMobiSampleApp_iPhone


#import <UIKit/UIKit.h>
#import "IMAdInterstitial.h"
#import "IMAdInterstitialDelegate.h"
#import "IMAdRequest.h"
#import "IMAdError.h"

@interface InterstitialAdViewController : UIViewController <IMAdInterstitialDelegate> {
    IMAdInterstitial *interstitialAd;
    UIButton *refreshAd,*showAd;
}

- (void)refreshAd;
- (void)showAd;
@end
