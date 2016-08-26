//
//  AutoCompletionTextFieldDataSource.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@class AutoCompletionTextField;
typedef void (^FetchCompletionBlock)(NSArray *items, NSString *textKey, NSString *textValue);

@protocol AutoCompletionTextFieldDataSource <NSObject>

@required
- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                 withCompletionBlock:(FetchCompletionBlock)completion;

@end
