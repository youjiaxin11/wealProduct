

#import "BaseControl.h"
#import "ViewController.h"
@interface LoginView : BaseControl
@property (strong, nonatomic) IBOutlet UITextField *lgnInput;
@property (strong, nonatomic) IBOutlet UITextField *pwdInput;
@property (strong, nonatomic) IBOutlet UIButton *lgnBtn;
@property (strong, nonatomic) IBOutlet UIButton *rgtBtn;

@property (strong,nonatomic) NSString *userNameFromRegister;
@property (strong,nonatomic) NSString *passwordFromRegister;
@property (assign,nonatomic) BOOL fromRegister;
@end
