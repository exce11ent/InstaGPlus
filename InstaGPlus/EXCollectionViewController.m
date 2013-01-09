//
//  EXCollectionViewController.m
//  InstaGPlus
//
//  Created by MacUser1 on 1/9/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import "EXCollectionViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"

@interface EXCollectionViewController ()

@end

@implementation EXCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLogin:(id)sender {
    
    static NSString *const kKeychainItemName = @"G+ Keychain";
    
    NSString *kMyClientID = @"357404287133-i9m6ej3bij4g15msmo0n96m337num4dm.apps.googleusercontent.com";     // pre-assigned by service
    NSString *kMyClientSecret = @"Tp7VvqSpBXxPChjmjpZyqI2L"; // pre-assigned by service
    
    NSString *scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API
    
    GTMOAuth2ViewControllerTouch *viewController;
    SEL finishedSel = @selector(viewController:finishedWithAuth:error:);
    viewController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                 clientID:kMyClientID
                                                             clientSecret:kMyClientSecret
                                                         keychainItemName:kKeychainItemName
                                                                 delegate:self
                                                         finishedSelector:finishedSel];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed
    } else {
        NSLog(@"Authentication succeeded");
    }
}
@end
