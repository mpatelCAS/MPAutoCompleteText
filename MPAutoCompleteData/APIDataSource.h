//
//  APIDataSource.h
//  AutoCompletion
//

@import AutoCompletion;
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface RequestObject : NSObject

@end

@interface APIDataSource : NSObject<AutoCompletionTextFieldDataSource>

typedef NS_ENUM(NSInteger, APICallType) {
    APICallTypeGET,
    APICallTypePOST
};

@property APICallType api_type;

@property (nonatomic,retain) AFHTTPSessionManager *manager;

@property (nonatomic,retain) NSString *requestURL;

@property (nonatomic,retain) NSString *reqKey;

@property (nonatomic,retain) NSString *rvalue;

@property (nonatomic,retain) NSMutableDictionary *requestParams;

@end