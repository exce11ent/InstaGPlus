//
//  EXCollectionViewController.m
//  InstaGPlus
//
//  Created by MacUser1 on 1/9/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import "EXCollectionViewController.h"
#import "EXCollectionViewCell.h"
#import "EXConstants.h"
#import "UIImageView+AFNetworking.h"
#import "EXPhotoForFilteringViewController.h"

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onExtractedLinks:) name:NOTIFICATION_PHOTO_LINKS_FETCHED object:nil];
    _internalLinks = [@[@"https://lh6.googleusercontent.com/-Q9cBv74C5Go/T4Wtl0axWpI/AAAAAAAAAT0/__VY0229BlY/P1030431.jpg",
                      @"https://lh5.googleusercontent.com/-Z-sv_i4nAk4/T4WtS4FgKsI/AAAAAAAAATw/4kUFVBaTKmY/canon.jpg",
                      @"https://lh6.googleusercontent.com/-4PZMXSiDGSg/Tnoj1qttqnI/AAAAAAAAATo/ZWd7PWhqQTQ/P1030435.jpg",
                      @"https://lh4.googleusercontent.com/-dhDgz3BZVgE/TnjRga8OEUI/AAAAAAAAATk/h7omlJuntMs/%252521%252521avka.jpg",
                      @"https://lh5.googleusercontent.com/-h_5YFgJPAdM/T4WlJOBzOXI/AAAAAAAAATs/75LQK-P_eGs/reWalls.com-10257.jpg",
                      @"https://lh5.googleusercontent.com/-fhp5y9BYERg/UIT3FsACQBI/AAAAAAAAANQ/orYdbkLFVjo/337883-1920x1080.jpg",
                      @"https://lh4.googleusercontent.com/-UluX3x6I8e8/UIVMmzvryiI/AAAAAAAAAOE/YvAZGrqfLms/310361-1920x1080.jpg",
                      @"https://lh3.googleusercontent.com/-mNa-l4T9Gy4/UIVMuJeRmNI/AAAAAAAAAO0/RbEK80yUIbQ/315339-1920x1080.jpg",
                      @"https://lh5.googleusercontent.com/-p-8qO9TZqlk/UN4JVQlhM2I/AAAAAAAAASU/rcw_JXJfWvA/wallpaper-2532350.jpg",
                      @"https://lh6.googleusercontent.com/-uoYf9Q3Q-mg/UN4JbgFF_pI/AAAAAAAAATA/tQAtLitmKuc/379048-5700x4000.jpg",
                      @"https://lh3.googleusercontent.com/-2eagL1mXnuY/Tnois5dJ2YI/AAAAAAAAAEY/wJpl_y2vh1g/P1030414.jpg",
                      @"https://lh5.googleusercontent.com/-8FS1C-2b3cQ/Tnois93vN_I/AAAAAAAAAEc/vS52O7BHJTM/P1030416.jpg",
                      @"https://lh4.googleusercontent.com/-O44zsp0mThw/TnoivQ80pHI/AAAAAAAAAEg/-khA1Mw8mm0/P1030419.jpg",
                      @"https://lh5.googleusercontent.com/-jTxjwgetkdk/Tnoizr7gVjI/AAAAAAAAAEs/xAFJUpgY7y0/P1030426.jpg",
                      @"https://lh4.googleusercontent.com/-Yj972SjZ9Bw/TnoizImVKZI/AAAAAAAAAEo/bXokzDgCN9o/P1030427.jpg",
                      @"https://lh3.googleusercontent.com/-kTDsMhgwN48/TnoiyrAOs4I/AAAAAAAAAEk/9RI8hwtQKsE/P1030431%252520ava%252520edition.jpg",
                      @"https://lh3.googleusercontent.com/-EzTw2i_4V8I/Tnoi2DoEVcI/AAAAAAAAAEw/3Oigh299duI/P1030431.jpg",
                      @"https://lh3.googleusercontent.com/-_Lx6l1WlksA/Tnoi2VQXKWI/AAAAAAAAAE0/BJuqE5n8nvA/P1030435.jpg",
                      @"https://lh6.googleusercontent.com/-Q5HePkX7MWA/T42tIvwCvDI/AAAAAAAAAJ4/aaXRSKp0MOw/3887527_700b.jpg",
                      @"https://lh3.googleusercontent.com/-w5omQF4Pfc4/Tm_Qm2-EdBI/AAAAAAAAACY/61cD5U99uHI/reWalls.com-35841.jpg",
                      @"https://lh4.googleusercontent.com/-dIAx0a-UhU0/Tm_QoGZUolI/AAAAAAAAACg/vUQEmrwS3Ls/reWalls.com-46501.jpg",
                      @"https://lh6.googleusercontent.com/-tx9ViLuB7Us/Tm_Qn5CnfEI/AAAAAAAAACc/6bs1wfGrcj0/reWalls.com-46593.jpg",
                      @"https://lh5.googleusercontent.com/-Cwz8vXt9xNY/S2x5zMUA3pI/AAAAAAAAAAU/WHJR0QRdF9Q/%252521%252521avka.jpg"]mutableCopy];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLogin:(id)sender {
    
    static NSString *const kKeychainItemName = @"G+ Keychain";
    
    NSString *kMyClientID = @"357404287133-i9m6ej3bij4g15msmo0n96m337num4dm.apps.googleusercontent.com";  
    NSString *kMyClientSecret = @"Tp7VvqSpBXxPChjmjpZyqI2L"; 
    
    NSString *scope = [GTMOAuth2Authentication scopeWithStrings:
                       [GDataServiceGooglePhotos authorizationScope],
                       nil];
    
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
        NSLog(@"->Authenticated user email adress: %@", auth.userEmail);
        OADataManager * dataManager = [OADataManager sharedDataManager];
        [dataManager setUserIdFromEmail:auth.userEmail];
        [dataManager.service setAuthorizer:auth];
        [dataManager fetchPhotos];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [_internalLinks count];
    OADataManager *dataManager = [OADataManager sharedDataManager];
    return [[dataManager allLinks] count];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EXCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"collectionCell"
                                    forIndexPath:indexPath];
    
    int row = [indexPath row];
    OADataManager *dataManager = [OADataManager sharedDataManager];
    NSString *uri = [[dataManager allLinks] objectAtIndex:row];
    
//    NSString *uri = [_internalLinks objectAtIndex:row];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImageWithURL:[NSURL URLWithString:uri] placeholderImage:[UIImage imageNamed:@"nissan-small.jpg"]];
    myCell.currentImage.image = imageView.image;
    [myCell setBackgroundColor:[UIColor whiteColor]];
    return myCell;

}


- (void) onExtractedLinks:(NSNotification *)n {
    [self.collectionView reloadData];
    NSLog(@"NOTIFICATION RECEIVED");
}


//UICollectionViewDelegate methods

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    EXCollectionViewCell *cell;
//    cell = (EXCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
//    
//    UIImage *img;
//    img = cell.currentImage.image;
//    
//    [self performSegueWithIdentifier:@"showPhotoForFiltering" sender:img];
//    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
//        
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPhotoForFiltering"]){
        EXPhotoForFilteringViewController *newVC = segue.destinationViewController;
        EXCollectionViewCell *cvc = (EXCollectionViewCell *) sender;
        [newVC setPhotoForFiltering: cvc.currentImage.image];
    }
}



@end
