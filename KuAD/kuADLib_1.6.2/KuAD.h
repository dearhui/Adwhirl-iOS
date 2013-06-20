//
//  KuAD.h
//  kuADLib
//
//  Created by ven wu on 12/6/11.
//  Copyright (c) 2012年 __kuSOGI__. All rights reserved.
//

#import <UIKit/UIKit.h>

//--------------------------
//----- 新版kuAD -----
//--------------------------
@protocol KuADDelegate;
@interface KuAD : UIViewController
@property (nonatomic, assign) id <KuADDelegate> delegate;

//--------------------------
//MMC預先加入kuAD
//--------------------------
- (UIView*) mmcWithKuAD:(NSString *)APID adRect:(CGRect)frame yourRootController:(UIViewController *)yourRootController yourStatusBarHidden:(BOOL)yourstatusBarHidden;

//--------------------------
//MMC預先加入其他廣告
//--------------------------
- (UIView*) mmcWithOtherAD:(UIView*)adView youRootController:(UIViewController *)yourRootController adRect:(CGRect)frame;

//--------------------------
//當App啟動時呼叫
//--------------------------
- (void) appStart;

//--------------------------
//當App恢復到前景的時候呼叫
//--------------------------
- (void) kuADDidBecomeActive:(UIApplication *)application;

//--------------------------
//當App被點擊時呼叫
//--------------------------
- (void) onTouchWithEvent:(UIEvent *)event;

@end
@protocol KuADDelegate <NSObject>
@optional
- (void) KuADStatus:(BOOL)status;
@end


//--------------------------
//使用MMC開發者，需把自身App的windows換成這個
//--------------------------
@interface KuWindows : UIWindow
- (id)initWithFrame:(CGRect)frame withYourController:(UIViewController*)yourController_;
@end
