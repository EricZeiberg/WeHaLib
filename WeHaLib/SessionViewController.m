//
//  SessionViewController.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 8/2/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "SessionViewController.h"

@interface SessionViewController ()

@end

@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://lci.iii.com/iii/cas/login?service=https%3A%2F%2Flci-mt.iii.com%3A443%2Fiii%2Fencore%2Fj_acegi_cas_security_check"]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Do whatever you want here
    [self.loadingView setHidden:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *URLString = [[request URL] absoluteString];
    if ([URLString containsString:@"https://lci-mt.iii.com/iii/encore/"]) {
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            if ([[cookie name] containsString:@"JSESSIONID"]) {
                [defaults setObject:[cookie value] forKey:@"sessionId"];
                [defaults setBool:YES forKey:@"isLoggedIn"];
                break;
            }
        }
    }
    return YES;
}

- (IBAction)unwind:(UIStoryboardSegue *)unwindSegue
{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
