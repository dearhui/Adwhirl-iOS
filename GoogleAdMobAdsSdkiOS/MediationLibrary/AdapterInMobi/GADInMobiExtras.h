//
//  GADInMobiExtras.h
//

#import <Foundation/Foundation.h>
#import "GADAdNetworkExtras.h"
#import "IMCommonUtil.h"

@interface GADInMobiExtras : NSObject <GADAdNetworkExtras>

#pragma mark Optional Parameters for targeted advertising during an Ad Request
/**
 * User income in USD.
 */
@property (nonatomic, assign) NSUInteger income;
/**
 * Age of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, assign) NSUInteger age;
/**
 * Postal code of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, copy) NSString *postalCode;
/**
 * Area code of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, copy) NSString *areaCode;

#pragma mark Setting Contextual Information
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"offers sale shopping"
 */
@property (nonatomic, copy) NSString *keywords;
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"cars bikes racing"
 */
@property (nonatomic, copy) NSString *interests;
/**
 * Provide additional values to be passed in the ad request as key-value pair.
 */
@property (nonatomic, retain) NSDictionary *additionalParameters;

#pragma mark Setting User Location
/**
 * Provide user's city in the format "city-state-country" for
 * city-level targetting.
 */
- (void)setLocationWithCity:(NSString *)_city
                      state:(NSString *)_state
                    country:(NSString *)_country;

#pragma mark Setting User IDs
/**
 * User ids such as facebook, twitter, etc may be provided to deliver more
 * relevant ids.
 */
@property (nonatomic, copy) NSString *loginId;
/**
 * Useful for maintaining different sessions with same login id.
 */
@property (nonatomic, copy) NSString *sessionId;

#pragma mark Setting Device Id Mask
/**
 * Device Id Mask to give flexibility on what device ids to be excluded from
 * InMobi device id collection.
 */
@property (nonatomic, assign) IMDeviceIdMask deviceIdMask;

@end

