# MPAutoCompleteTextField
Repository for Autocomplete Textfield from API, Coredata as well Json response you can manage it  

## Usage 

Clone this repository and Add this code to your class
This repository required this thing to run this project 
  
 -  **AutoCompleteFramework**
 -  **AFNetworking 3.0**

![Alt][screenshot1]

[screenshot1]: https://github.com/mpatelCAS/MPAutoCompleteTextField/blob/master/Simulator%20Screen%20Shot%20Jul%2026%2C%202016%2C%203.50.08%20PM.png

```obj-c

    #import "Private.h"  
    
    // TODO : <AutoCompletionTextFieldDelegate> Add this delegate to your class 

    AutoCompletionUIKitDynamicsAnimation *animation = [[AutoCompletionUIKitDynamicsAnimation alloc] init];
    
    CoreDataDataSource *coreDataDataSource = [[CoreDataDataSource alloc] init];
    _coreDataTextField.suggestionsResultDataSource = coreDataDataSource;
    _coreDataTextField.animationDelegate = animation;
    _coreDataTextField.suggestionsResultDelegate = self;
    
    JSONDataSource *jsonDataSource = [[JSONDataSource alloc] init];
    _jsonTextField.suggestionsResultDataSource = jsonDataSource;
    _jsonTextField.suggestionsResultDelegate = self;
    
    APIDataSource *apiDataSource = [[APIDataSource alloc] init];
    apiDataSource.requestURL = @"YOUR CUSTOM URL";                       // Add your Custom url
    apiDataSource.api_type = APICallTypeGET;                             // For post use APICallTypePOST
    apiDataSource.requestParams = [[NSMutableDictionary alloc] init];    // Add your request parameters 
    apiDataSource.manager = manager;                                     // Add your necessory credentials for SessionManager for this use AFHTTPSessionManager
    _apiTextField.suggestionsResultDataSource = apiDataSource;
    _apiTextField.suggestionsResultDelegate = self;


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
