//
//  OADataManager.m
//  InstaGPlus
//
//  Created by MacUser1 on 1/10/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import "OADataManager.h"
#import "GDataServiceGooglePhotos.h"
#import "GDataFeedPhotoAlbum.h"
#import "GDataEntryPhotoAlbum.h"
#import "GDataEntryPhoto.h"
#import "GDataFeedPhotoUser.h"
#import "GDataMediaThumbnail.h"
#import "EXConstants.h"

static OADataManager *_sharedManager = nil;

@implementation OADataManager

@synthesize service = _service;
@synthesize albumsFeed = _albumsFeed;
@synthesize photosFeed = _photosFeed;
@synthesize userID = _userID;
@synthesize allLinks = _allLinks;

+ (OADataManager *)sharedDataManager
{
    if (_sharedManager == nil) {
        _sharedManager = [[OADataManager alloc] init];
    }
    return _sharedManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.service = [[GDataServiceGooglePhotos alloc] init];
        self.service.shouldCacheResponseData = YES;
        _thumbnailDictionary = [[NSMutableDictionary alloc] init];
        self.allLinks = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) setUserIdFromEmail:(NSString *)userEmail {
    
    NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@"@"];
    NSArray *emailComponents = [userEmail componentsSeparatedByCharactersInSet:cSet];
    NSLog(@"UserID: %@", [emailComponents objectAtIndex:0]);
    [self setUserID:[emailComponents objectAtIndex:0]];

}

-(void) fetchPhotos {
    
    GDataServiceTicket *ticket;
    NSLog(@"Email before creating feedURL: %@", [self.service username]);
    NSURL *feedURL = [GDataServiceGooglePhotos photoFeedURLForUserID:self.userID
                                                             albumID:nil
                                                           albumName:nil
                                                             photoID:nil
                                                                kind:nil
                                                              access:nil];
    NSLog(@"feedURL: %@", feedURL);
    ticket = [_service fetchFeedWithURL:feedURL
                               delegate:self
                      didFinishSelector:@selector(albumListFetchTicket:finishedWithFeed:error:)];
    NSLog(@"ticket : %@", ticket);
}

- (void) getPhotosFromAlbum:(GDataEntryPhotoAlbum *) album {
   
    if (album) {
        NSURL *feedURL = [[album feedLink] URL];
        if (feedURL) {
            [self setPhotosFeed:nil];
            
            GDataServiceTicket *ticket;
            ticket = [_service fetchFeedWithURL:feedURL
                                       delegate:self
                              didFinishSelector:@selector(photosTicket:finishedWithFeed:error:)];
        }
    }
    
}

- (void)albumListFetchTicket:(GDataServiceTicket *)ticket
            finishedWithFeed:(GDataFeedPhotoUser *)feed
                       error:(NSError *)error {
    if (error == nil) {
        NSArray *entries = [feed entries];
        [self setAlbumsFeed:feed];
        
        NSLog(@"entries %i", [entries count]);
        if ([entries count] > 0) {
            
            for (int i = 0; i < [entries count]; i++) {
                GDataEntryPhotoAlbum *currentAlbum = [entries objectAtIndex:i];
                GDataTextConstruct *titleTextConstruct = [currentAlbum title];
                NSString *title = [titleTextConstruct stringValue];
                
                NSLog(@"title: %@ photosUsed:%@", title , [[currentAlbum photosUsed] stringValue]);
                [self getPhotosFromAlbum:currentAlbum];
                
            }
        } else {
            NSLog(@"No Albums");
        }
    } else {

    }
}


//- (void)getPhotosFromAlbumAtIndex:(int)index {
//    
//    NSArray *albums = [_albumsFeed entries];
//    if (!([albums count] > 0 && index > -1)) return;
//    GDataEntryPhotoAlbum *album = [albums objectAtIndex:index];
//    if (album) {
//        NSURL *feedURL = [[album feedLink] URL];
//        if (feedURL) {
//            [self setPhotosFeed:nil];
//            
//            GDataServiceTicket *ticket;
//            ticket = [_service fetchFeedWithURL:feedURL
//                                       delegate:self
//                              didFinishSelector:@selector(photosTicket:finishedWithFeed:error:)];
//        }
//    }
//}

- (void)photosTicket:(GDataServiceTicket *)ticket
    finishedWithFeed:(GDataFeedPhotoAlbum *)feed
               error:(NSError *)error {
    if (error == nil) {
        NSArray *entries = [feed entries];
        [self setPhotosFeed:feed];
        [self photoLinks];
        NSLog(@"LINKS: \n %@", [self allLinks]);
        if ([entries count] > 0) {
            
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_PHOTO_LINKS_FETCHED object:nil]];
 
        } else {
            NSLog(@"No Photos");
        }
    } else {
        
    }
}

- (void)photoLinks
{
    NSArray *photos = [_photosFeed entries];
    int photosCount = [photos count];
    for (int i = 0; i < photosCount; i++) {
        
        GDataEntryPhoto *photo = [photos objectAtIndex:i];
        GDataEntryContent *c = [photo content];
        [_allLinks addObject:c.sourceURI];
        
    }
}

@end
