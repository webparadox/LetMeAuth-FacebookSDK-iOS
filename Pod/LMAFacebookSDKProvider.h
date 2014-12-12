//
//  LMAFacebookSDKProvider.h
//  LetMeAuth-FacebookSDK-iOS
//
//  Created by Alexey Aleshkov on 10.10.13.
//  Copyright (c) 2013 Webparadox, LLC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <LetMeAuth/LetMeAuth.h>


extern NSString *const LMAFacebookSDKAppId;
extern NSString *const LMAFacebookSDKPermissions;
extern NSString *const LMAFacebookSDKURLSchemeSuffix;
extern NSString *const LMAFacebookSDKAudience;
extern NSString *const LMAFacebookSDKAudienceOnlyMe;
extern NSString *const LMAFacebookSDKAudienceFriends;
extern NSString *const LMAFacebookSDKAudienceEveryone;

/*
 Return

 @"access_token" => NSString. Access token
 @"scope" => NSArray of NSString. Permissions
 @"expires" => NSDate. Expiration date
 */
@interface LMAFacebookSDKProvider : NSObject <LMAProvider>

@end
