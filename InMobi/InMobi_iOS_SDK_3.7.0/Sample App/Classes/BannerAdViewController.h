//
//  InMobiSampleApp_iPhoneViewController.h
//  InMobiSampleApp_iPhone
//

//

#import <UIKit/UIKit.h>
#import "IMAdView.h"
#import "IMAdDelegate.h"
#import "IMAdRequest.h"
#import "IMAdError.h"

@interface BannerAdViewController : UIViewController <IMAdDelegate> {

	IMAdView *inmobiAdView;
    
}

- (void)loadInMobiAd;
@end

