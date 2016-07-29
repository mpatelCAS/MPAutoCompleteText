# MPAutoCompleteTextField

Repository for Autocomplete Textfield from API, Coredata as well Json response ,A framework which provides text field suggestions as a dropdown list. It is available with iOS 8 and later, Objective-C or Swift.

## Usage 

Clone this repository and Add this code to your class
This repository required this thing to run this project 
  
 -  **AutoCompleteFramework**
 -  **AFNetworking 3.0**

![Alt][screenshot1]

[screenshot1]:https://github.com/mpatelCAS/MPAutoCompleteText/blob/master/demo.png

```obj-c

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
          apiDataSource.requestURL = @"YOUR CUSTOM URL/";                     // Add your Custom url for get
          apiDataSource.api_type = APICallTypeGET;                             // For post use APICallTypePOST
          apiDataSource.requestParams = [[NSMutableDictionary alloc] init];    // Add your request parameters 
          apiDataSource.manager = manager;                                     // Add your necessory credentials for SessionManager       for this use AFHTTPSessionManager
         _apiTextField.suggestionsResultDataSource = apiDataSource;
         _apiTextField.suggestionsResultDelegate = self;
    }

    #pragma mark - Delegate

   - (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem {
   
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
