//
//  AdWhirlAdapterKuAd.h
//  adwhirlSDK
//
//  Created by Ming-Hui Ho on 12/4/6.
//  Copyright (c) 2012年 Octtel. All rights reserved.
//

#import "AdWhirlAdNetworkAdapter.h"
#import "kuADController.h"

#define kKuAdBannerSize320x48   CGRectMake(0, 0, 320, 48)

#ifdef USES_NEW_KUAD_LIB
@interface AdWhirlAdapterKuAd : AdWhirlAdNetworkAdapter <kuADDelegate>
#else
@interface AdWhirlAdapterKuAd : AdWhirlAdNetworkAdapter
#endif

+ (AdWhirlAdNetworkType)networkType;
- (SEL)delegatePublisherIdSelector;
- (NSString *)publisherId;

@end
