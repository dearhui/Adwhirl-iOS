//
//  InMobiSampleApp_iPhoneViewController.m
//  InMobiSampleApp_iPhone
//
//
#import "BannerAdViewController.h"
#import "InMobiSampleApp_iPhoneAppDelegate.h"
#import "InMobiSampleApp_iPhoneAppDelegate.h"


@implementation BannerAdViewController
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Banner Ad";
	inmobiAdView = [[IMAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 48) imAppId:INMOBI_APP_ID imAdSize:IM_UNIT_320x48];
    inmobiAdView.delegate = self;
    
    IMAdRequest *request = [IMAdRequest request];
    /**
     * additional targeting parameters. these are optional
     */
    request.gender = kIMGenderMale;
    request.education = kIMEducationBachelorsDegree;
    // etc ..
    inmobiAdView.imAdRequest = request;
    [self.view addSubview:inmobiAdView];
    [inmobiAdView loadIMAdRequest];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(85, 350, 150, 30)];
    [button setTitle:@"Refresh Ad" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadInMobiAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)close {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)loadInMobiAd {
	NSLog(@"load new inmobi ad");
	[inmobiAdView loadIMAdRequest];
}

#pragma mark InMobiAdDelegate methods

- (void)adViewDidFinishRequest:(IMAdView *)view {
    NSLog(@"<<<<<ad request completed>>>>>");
}

- (void)adView:(IMAdView *)view didFailRequestWithError:(IMAdError *)error {
    NSLog(@"<<<< ad request failed.>>>, error=%@",[error localizedDescription]);
    NSLog(@"error code=%d",[error code]);
    InMobiSampleApp_iPhoneAppDelegate *appDelegate = (InMobiSampleApp_iPhoneAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate animateAdStatusLabelWithMsg:[error localizedDescription]];
}

- (void)adViewDidDismissScreen:(IMAdView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillDismissScreen:(IMAdView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewWillPresentScreen:(IMAdView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

- (void)adViewWillLeaveApplication:(IMAdView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[inmobiAdView setDelegate:nil];
	[inmobiAdView release]; inmobiAdView = nil;
    [super dealloc];
}

@end
