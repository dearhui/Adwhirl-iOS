//
//  kuADController.h
//  kuAD
//
//  Created by aming on 2011/4/25.
//  Copyright 2011 __kusogi__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface kuADController : UIViewController {
	
}

- (UIView*) kuADId:(NSString *)APID adRect:(CGRect)frame yourRootController:(UIViewController *)yourRootController yourStatusBarHidden:(BOOL)yourstatusBarHidden;
- (UIView*) kuADId:(NSString *)APID adRect:(CGRect)frame rootView:(UIView *)rootview yourStatusBarHidden:(BOOL)yourstatusBarHidden;


@end



