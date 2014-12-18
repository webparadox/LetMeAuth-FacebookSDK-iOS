//
//  LMAFacebookSDKProvider.m
//  LetMeAuth-FacebookSDK-iOS
//
//  Created by Alexey Aleshkov on 10.10.13.
//  Copyright (c) 2013 Webparadox, LLC. All rights reserved.
//


#import "LMAFacebookSDKProvider.h"
#import <FacebookSDK/FacebookSDK.h>


@interface LMAFacebookSDKProvider ()

@property (copy, nonatomic) NSDictionary *configuration;
@property (strong, nonatomic) FBSession *session;

- (void)didAuthenticateWithData:(NSDictionary *)data;
- (void)didFailWithError:(NSError *)error;
- (void)didCancel;
- (void)finish;

@end


@implementation LMAFacebookSDKProvider

@synthesize providerDelegate = _providerDelegate;

- (id)initWithConfiguration:(NSDictionary *)configuration
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.configuration = configuration;
    NSString *applicationId = [self.configuration objectForKey:LMAFacebookSDKAppId];
    NSArray *permissions = [self.configuration objectForKey:LMAFacebookSDKPermissions];
    NSString *urlSchemeSuffix = [self.configuration objectForKey:LMAFacebookSDKURLSchemeSuffix];
    NSString *audience = [self.configuration objectForKey:LMAFacebookSDKAudience];
    FBSessionDefaultAudience defaultAudience = FBSessionDefaultAudienceNone;
    if ([audience isEqualToString:LMAFacebookSDKAudienceOnlyMe]) {
        defaultAudience = FBSessionDefaultAudienceOnlyMe;
    } else if ([audience isEqualToString:LMAFacebookSDKAudienceFriends]) {
        defaultAudience = FBSessionDefaultAudienceFriends;
    } else if ([audience isEqualToString:LMAFacebookSDKAudienceEveryone]) {
        defaultAudience = FBSessionDefaultAudienceEveryone;
    }

    self.session = [[FBSession alloc] initWithAppID:applicationId permissions:permissions defaultAudience:defaultAudience urlSchemeSuffix:urlSchemeSuffix tokenCacheStrategy:[FBSessionTokenCachingStrategy nullCacheInstance]];

    return self;
}

- (void)start
{
    __weak typeof(self)weakSelf = self;
    [self.session openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        __strong typeof(weakSelf)self = weakSelf;

        if (error) {
            [self didFailWithError:error];
            return;
        }
        if (!FB_ISSESSIONOPENWITHSTATE(status)) {
            // TODO: raise error
            return;
        }

        FBAccessTokenData *accessTokenData = session.accessTokenData;

        NSMutableDictionary *tokenResponse = [[NSMutableDictionary alloc] initWithCapacity:4];

        [tokenResponse setValue:accessTokenData.accessToken forKey:@"access_token"];
        [tokenResponse setValue:accessTokenData.permissions forKey:@"scope"];
        [tokenResponse setValue:accessTokenData.expirationDate forKey:@"expires"];

        [self didAuthenticateWithData:tokenResponse];
    }];
}

- (void)cancel
{
    [self.session close];
    [self didCancel];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
    return result;
}

- (void)handleDidBecomeActive
{
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
	[self didCancel];
}

#pragma mark Private methods

- (void)didAuthenticateWithData:(NSDictionary *)data
{
    [self.providerDelegate provider:self didAuthenticateWithData:data];
    [self finish];
}

- (void)didFailWithError:(NSError *)error
{
    [self.providerDelegate provider:self didFailWithError:error];
    [self finish];
}

- (void)didCancel
{
    [self.providerDelegate providerDidCancel:self];
    [self finish];
}

- (void)finish
{
    [self.session close];
    self.session = nil;
}

@end
