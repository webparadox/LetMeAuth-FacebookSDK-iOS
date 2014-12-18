//
//  LMAFacebookSDKProvider.h
//  LetMeAuth-FacebookSDK-iOS
//
//  Created by Alexey Aleshkov on 10.10.13.
//  Copyright (c) 2013 Webparadox, LLC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <LetMeAuth/LetMeAuth.h>
#import "LMAFacebookSDKConstants.h"


/*
 Return

 LMAOAuth2AccessToken => NSString. Access token
 LMAOAuth2Scope => NSArray of NSString. Permissions
 LMAExpiresAt => NSDate. Expiration date
 */
@interface LMAFacebookSDKProvider : NSObject <LMAProvider>

@end
