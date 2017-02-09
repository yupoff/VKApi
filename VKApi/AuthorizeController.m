//
//  AuthorizeController.m
//  VKApi
//
//  Created by Тимур Аюпов on 11.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "AuthorizeController.h"
#import "AccessToken.h"

@interface AuthorizeController () <UIWebViewDelegate>
@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) AccessToken *accessToken;
@end

@implementation AuthorizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:r];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView = webView;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionDone:)];
    [self.navigationItem setLeftBarButtonItem:item animated:NO];
    
    NSString *urlString = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&redirect_uri=https://oauth.vk.com/blank.html&scope=%@&response_type=token&v=5.53&revoke=1",self.clientId, [self.scope componentsJoinedByString:@","]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    /*
     https://oauth.vk.com/authorize?
     client_id=1&
     display=page&
     redirect_uri=http://example.com/callback&
     scope=friends&
     response_type=token&
     v=5.53&
     state=123456
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.webView.delegate = nil;
}

- (void)actionDone:(UIBarButtonItem *)item
{
    [self.delegate authorizeCompleteWithToken:self.accessToken];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", [[request URL] host]);
    if ([[[request URL] path] isEqual:@"/blank.html"]) {
        self.accessToken = [[AccessToken alloc]init];
        NSString *token;
        NSInteger expiresIn;
        NSString *userId;
        NSString *query = [[request URL] description];
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                NSString *key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    token = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"])
                {
                    [[values lastObject] doubleValue];
                } else if ([key isEqualToString:@"user_id"])
                {
                    userId = [values lastObject];
                }
            }
        }
        if (token && userId && expiresIn > 0) {
            self.accessToken = [[AccessToken alloc] initWithAccessToken:token expiresIn:expiresIn userId:userId scope:self.scope];
        }
        [self actionDone:nil];
        return NO;
    }
    return YES;
}


@end
