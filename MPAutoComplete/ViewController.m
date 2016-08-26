//
//  ViewController.m
//  MPAutoComplete
//
//  Created by Custom Apps on 7/22/16.
//  Copyright © 2016 Custom Apps. All rights reserved.
//

#import "ViewController.h"
#import "Private.h"
@import AutoCompletion;

@interface ViewController () <AutoCompletionTextFieldDelegate>

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *coreDataTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *jsonTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *apiTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AutoCompletionUIKitDynamicsAnimation *animation = [[AutoCompletionUIKitDynamicsAnimation alloc] init];
    
    CoreDataDataSource *coreDataDataSource = [[CoreDataDataSource alloc] init];
    _coreDataTextField.suggestionsResultDataSource = coreDataDataSource;
    _coreDataTextField.animationDelegate = animation;
    _coreDataTextField.suggestionsResultDelegate = self;
    
    JSONDataSource *jsonDataSource = [[JSONDataSource alloc] init];
    _jsonTextField.suggestionsResultDataSource = jsonDataSource;
    _jsonTextField.suggestionsResultDelegate = self;
    
    APIDataSource *apiDataSource = [[APIDataSource alloc] init];
  //  apiDataSource.requestURL = @"YOUR CUSTOM URL";                       // Add your Custom url
    apiDataSource.reqKey = @"name";         // your key
    apiDataSource.rvalue = @"product_id";   // Your responce value
    apiDataSource.api_type = APICallTypeGET;                             // For post use APICallTypePOST
    //apiDataSource.requestParams = [[NSMutableDictionary alloc] init];    // Add your request parameters
    //apiDataSource.manager = manager;                                     // Add your necessory credentials for SessionManager for this use AFHTTPSessionManager
    _apiTextField.suggestionsResultDataSource = apiDataSource;
    _apiTextField.suggestionsResultDelegate = self;
}

#pragma mark - Delegate

- (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem
{
    if ([textField isEqual:_coreDataTextField]) {
        Items *item = selectedItem;
        [textField setText:item.title];
    }
    else if ([textField isEqual:_jsonTextField] || [textField isEqual:_apiTextField]) {
        JSONItem *item = selectedItem;
        [textField setText:item.title];
    }
}

- (void)placeholderTextField:(UITextField *)placeholderTextField didSelectItem:(id)selectedItem {
    Items *item = selectedItem;
    [placeholderTextField setText:item.title];
}

@end
