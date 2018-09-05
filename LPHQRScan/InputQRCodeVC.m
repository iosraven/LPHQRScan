#import "InputQRCodeVC.h"

@interface InputQRCodeVC ()

@property (nonatomic,weak) IBOutlet UITextField *txt;

@property (nonatomic,weak) IBOutlet UIButton *btn;



@end

@implementation InputQRCodeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"手动输入二维码";
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];

    [self.view addGestureRecognizer:singleTap];

    [self.txt becomeFirstResponder];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.txt resignFirstResponder];
}


- (IBAction)btnInput:(id)sender
{
    if(self.inputBlock)
    {
        self.inputBlock(self.txt.text);
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
