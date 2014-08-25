#import "RelayrUser.h"          // Header
#import "RelayrUser_Setup.h"    // Private extension
#import "RLAWebService.h"       // Relayr.framework (Web)

static NSString* const kCodingToken = @"tok";
static NSString* const kCodingID = @"uid";
static NSString* const kCodingName = @"nam";
static NSString* const kCodingEmail = @"ema";
static NSString* const kCodingApps = @"app";
static NSString* const kCodingTransmitters = @"tra";
static NSString* const kCodingDevices = @"dev";
static NSString* const kCodingBookmarks = @"bok";
static NSString* const kCodingPublishers = @"pub";

@implementation RelayrUser

#pragma mark - Public API

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(instancetype)initWithToken:(NSString*)token
{
    if (!token.length) { return nil; }
    
    self = [super init];
    if (self)
    {
        _token = token;
        _webService = [[RLAWebService alloc] initWithUser:self];
    }
    return self;
}

- (void)queryCloudForUserInfo:(void (^)(NSError* error, NSString* previousName, NSString* previousEmail))completion
{
    __weak RelayrUser* weakSelf = self;
    
    [_webService requestUserInfo:^(NSError *error, NSString *name, NSString *email) {
        if (error) { if (completion) { completion(error, nil, nil); } }
        
        __strong RelayrUser* strongSelf = weakSelf;
        NSString* pName = strongSelf.name;      strongSelf.name = name;
        NSString* pEmail = strongSelf.email;    strongSelf.email = email;
        if (completion) { completion(nil, pName, pEmail); }
    }];
}

// TODO: Fill up
- (void)queryCloudForIoTs:(void (^)(NSError* error, BOOL isThereChanges))completion
{
    
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [self initWithToken:[decoder decodeObjectForKey:kCodingToken]];
    if (self)
    {
        _uid = [decoder decodeObjectForKey:kCodingID];
        _name = [decoder decodeObjectForKey:kCodingName];
        _email = [decoder decodeObjectForKey:kCodingEmail];
        _apps = [decoder decodeObjectForKey:kCodingApps];
        _transmitter = [decoder decodeObjectForKey:kCodingTransmitters];
        _devices = [decoder decodeObjectForKey:kCodingDevices];
        _devicesBookmarked = [decoder decodeObjectForKey:kCodingDevices];
        _publishers = [decoder decodeObjectForKey:kCodingPublishers];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:_token forKey:kCodingToken];
    [coder encodeObject:_uid forKey:kCodingID];
    [coder encodeObject:_name forKey:kCodingName];
    [coder encodeObject:_email forKey:kCodingEmail];
    [coder encodeObject:_apps forKey:kCodingApps];
    [coder encodeObject:_transmitter forKey:kCodingTransmitters];
    [coder encodeObject:_devices forKey:kCodingDevices];
    [coder encodeObject:_devicesBookmarked forKey:kCodingBookmarks];
    [coder encodeObject:_publishers forKey:kCodingPublishers];
}

@end
