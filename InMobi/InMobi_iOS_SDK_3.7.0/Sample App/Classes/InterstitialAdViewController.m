//
//  InterstitialAdViewController.m
//  InMobiSampleApp_iPhone


#import "InterstitialAdViewController.h"
#import "InMobiSampleApp_iPhoneAppDelegate.h"

@implementation InterstitialAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

#pragma IMAdInterstitialDelegate methods


#pragma mark Display-Time Lifecycle Notifications

- (void)interstitialDidFinishRequest:(IMAdInterstitial *)ad {
    NSLog(@"interstitialDidFinishRequest");
    [showAd setEnabled:YES];
    [showAd setAlpha:1];
    [refreshAd setEnabled:YES];
    [refreshAd setAlpha:1];
}

- (void)interstitial:(IMAdInterstitial *)interstitial
didFailToReceiveAdWithError:(IMAdError *)error {
    NSLog(@"interstitial did fail with error=%@",[error localizedDescription]);
    NSLog(@"error code=%d",[error code]);
    [refreshAd setEnabled:YES];
    [refreshAd setAlpha:1];
    InMobiSampleApp_iPhoneAppDelegate *appDelegate = (InMobiSampleApp_iPhoneAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate animateAdStatusLabelWithMsg:[error localizedDescription]];
}

- (void)interstitialWillPresentScreen:(IMAdInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

- (void)interstitial:(IMAdInterstitial *)ad didFailToPresentScreenWithError:(IMAdError *)error {
    NSLog(@"interstitial failed to present screen.. error = %@",[error localizedDescription]);
    InMobiSampleApp_iPhoneAppDelegate *appDelegate = (InMobiSampleApp_iPhoneAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate animateAdStatusLabelWithMsg:[error localizedDescription]];
}

- (void)interstitialWillDismissScreen:(IMAdInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");  
}

- (void)interstitialDidDismissScreen:(IMAdInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

- (void)interstitialWillLeaveApplication:(IMAdInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Interstitial Ad";
    refreshAd = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[refreshAd setTitle:@"Refresh Interstitial" forState:UIControlStateNormal];
	[refreshAd setFrame:CGRectMake(60, 335, 200, 30)];
	[refreshAd addTarget:self action:@selector(refreshAd) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:refreshAd];
    
    showAd = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[showAd setTitle:@"Show Interstitial" forState:UIControlStateNormal];
	[showAd setFrame:CGRectMake(60, 280, 200, 30)];
	[showAd addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:showAd];
	[showAd setEnabled:NO];
    [showAd setAlpha:0];
    interstitialAd = [[IMAdInterstitial alloc] init];
    interstitialAd.delegate = self;
    interstitialAd.imAppId = INMOBI_APP_ID;
    [self refreshAd];
}

- (void)showAd {
    [interstitialAd presentFromRootViewController:self.navigationController animated:YES];
}

- (void)refreshAd {
    [showAd setEnabled:NO];
    [showAd setAlpha:0];
    [refreshAd setEnabled:NO];
    [refreshAd setAlpha:0];
    IMAdRequest *request = [IMAdRequest request];
    [interstitialAd loadRequest:request];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    interstitialAd.delegate = nil;
    [interstitialAd release]; interstitialAd = nil;
    [showAd release]; showAd = nil;
    [refreshAd release]; refreshAd = nil;
    [super dealloc];
}

@end
