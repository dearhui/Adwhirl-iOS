//
//  VponAdmobCustomAd.h
//  iphone-vpon-sdk
//
//  Created by vpon on 13/4/23.
//  Copyright (c) 2013年 com.vpon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADCustomEventBanner.h"
#import "GADCustomEventRequest.h"

#import "VponBanner.h"

@interface VponAdmobCustomAd : NSObject <GADCustomEventBanner,VponBannerDelegate>
{
    VponBanner*         vponBannerAd;
}
@property (nonatomic, retain) VponBanner*       vponBannerAd;
@end
