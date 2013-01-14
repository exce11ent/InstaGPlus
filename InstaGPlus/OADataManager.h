//
//  OADataManager.h
//  InstaGPlus
//
//  Created by MacUser1 on 1/10/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDataServiceGooglePhotos;
@class GDataFeedPhotoAlbum;
@class GDataFeedPhotoUser;
@class GTMOAuth2Authentication;

@interface OADataManager : NSObject

+(OADataManager*) sharedDataManager;
-(void) fetchPhotos;
-(void) setUserIdFromEmail:(NSString *)userEmail;

@property(nonatomic, retain) GDataServiceGooglePhotos *service;
@property(nonatomic, retain) GDataFeedPhotoUser *albumsFeed;
@property(nonatomic, retain) GDataFeedPhotoAlbum *photosFeed;
@property(nonatomic, retain) NSMutableDictionary *thumbnailDictionary;
@property(nonatomic, retain) NSString *userID;
@property(nonatomic, retain) NSMutableArray *allLinks;

@end
