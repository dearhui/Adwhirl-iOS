//
//  kuADViewDelegate.h
//  kuAD
//
//  Created by Aming on 2011/4/25.
//  Copyright 2011 __Kusogi__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol kuADDelegate;

@interface bannerViewDelegate : NSObject {
	
}
@end


@protocol kuADDelegate <NSObject>

- (void) kuADStatus:(BOOL)status;

@end

