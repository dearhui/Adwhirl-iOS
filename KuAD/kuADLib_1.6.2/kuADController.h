//
//  kuADController.h
//  kuADLib
//
//  Created by ven wu on 12/6/20.
//  Copyright (c) 2012年 __kuSOGI__. All rights reserved.
//

#import <UIKit/UIKit.h>

//--------------------------
//----- 舊版kuAD -----
//--------------------------
@protocol kuADDelegate;
@interface kuADController : UIViewController
{
    id <kuADDelegate> kuDelegate;
}
@property (nonatomic, assign) id <kuADDelegate> kuDelegate;

//--------------------------
//有ViewContorller
//--------------------------
- (UIView*) kuADId:(NSString *)APID adRect:(CGRect)frame yourRootController:(UIViewController *)yourRootController yourStatusBarHidden:(BOOL)yourstatusBarHidden;

//--------------------------
//無ViewContorller
//--------------------------
- (UIView*) kuADId:(NSString *)APID adRect:(CGRect)frame rootView:(UIView *)rootview yourStatusBarHidden:(BOOL)yourstatusBarHidden;

//--------------------------
//當App啟動時呼叫
//--------------------------
- (void) appStart;

//--------------------------
//當App恢復到前景的時候呼叫
//--------------------------
- (void) kuADDidBecomeActive:(UIApplication *)application;

@end
@protocol kuADDelegate <NSObject>
- (void) kuADStatus:(BOOL)status;
@end

