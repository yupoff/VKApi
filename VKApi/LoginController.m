//
//  LoginController.m
//  VKApi
//
//  Created by Тимур Аюпов on 09.09.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "LoginController.h"
#import "ServerManager.h"

static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"newsControllerSegue";
static NSString *const TOKEN_KEY = @"5607601";
static NSArray *SCOPE = nil;

@interface LoginController () < ServerManagerDelegate >

@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SCOPE = @[ @"wall", @"friends" ];

    [[ServerManager sharedManager] setDelegate:self];
    [[ServerManager sharedManager] setClientId:TOKEN_KEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)authorizeAction:(UIButton *)sender
{
    [ServerManager authorizeUser:SCOPE];
}

- (void)startWorking
{
    [self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
}

#pragma mark - ServerManager delegate

- (void)presentViewController:(UIViewController *)controller
{
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}

- (void)authorizationComplete
{
    [self startWorking];
}

- (void)authorizationFailed
{
    //TODO: Обработка ошибки
}

@end
