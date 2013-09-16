//
//  AdWhirlAdapterVpon.h
//  adwhirlSDK
//
//  Created by Ming-Hui Ho on 12/4/6.
//  Copyright (c) 2012年 Octtel. All rights reserved.
//

#import "AdWhirlAdNetworkAdapter.h"

@interface AdWhirlAdapterVpon : AdWhirlAdNetworkAdapter

+ (AdWhirlAdNetworkType)networkType;
- (SEL)delegatePublisherIdSelector;
- (NSString *)publisherId;

@end
