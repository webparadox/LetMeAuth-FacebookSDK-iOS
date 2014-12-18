//
//  LMAFacebookSDKConstants.m
//  LetMeAuth-FacebookSDK-iOS
//
//  Created by Alexey Aleshkov on 18/12/14.
//  Copyright (c) 2014 Webparadox, LLC. All rights reserved.
//


//#import "LMAFacebookSDKConstants.h"
#import <LetMeAuth/LetMeAuth.h>


NSString *LMAFacebookSDKAppId = @"client_id";
NSString *LMAFacebookSDKPermissions = @"scope";
NSString *const LMAFacebookSDKURLSchemeSuffix = @"url_scheme";
NSString *const LMAFacebookSDKAudience = @"audience";
NSString *const LMAFacebookSDKAudienceOnlyMe = @"me";
NSString *const LMAFacebookSDKAudienceFriends = @"friends";
NSString *const LMAFacebookSDKAudienceEveryone = @"everyone";


__attribute__((constructor))
static void initializeConstants()
{
    LMAFacebookSDKAppId = LMAOAuth2ClientId;
    LMAFacebookSDKPermissions = LMAOAuth2Scope;
}
