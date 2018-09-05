#import "LPHScanVC.h"
#import "LPScanView.h"
#import "InputQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width


@interface LPHScanVC ()<LPScanViewDelegate>
{
    int line_tag;
    UIView *highlightView;
    NSString *scanMessage;
    BOOL isRequesting;
    BOOL isFlashLightOn; // 手电筒是否打开
}

// 手动输入码
@property (nonatomic,weak) UIButton *btnInput;
// 手电筒
@property (nonatomic,weak) UIButton *btnFlashLight;
// 手动输入码 Label
@property (nonatomic,weak) UILabel *lblInput;
// 手电筒 Label
@property (nonatomic,weak) UILabel *lblFlashLight;

@end

@implementation LPHScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"二维码扫描";
    
    isFlashLightOn = NO;
    
    LPScanView *scanV = [[LPScanView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    scanV.delegate = self;
    
    [self.view addSubview:scanV];

    [self addUIBtn];
}

/** 添加 手电筒、手动输入 按钮*/
- (void)addUIBtn
{
    // 手动输入码
    UIButton *btnHand = [[UIButton alloc] init];
    [btnHand setBackgroundImage:[UIImage imageNamed:@"Icon_Scan_hand.png"] forState:UIControlStateNormal];
    btnHand.contentMode = UIViewContentModeScaleAspectFit;
    [btnHand addTarget:self action:@selector(inputQRCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHand];
    _btnInput = btnHand;
    
    // 手电筒
    UIButton *btnFlashLight = [[UIButton alloc] init];
    [btnFlashLight setBackgroundImage:[UIImage imageNamed:@"Icon_Scan_flashLight.png"] forState:UIControlStateNormal];
    btnFlashLight.contentMode = UIViewContentModeScaleAspectFit;
    [btnFlashLight addTarget:self action:@selector(openFlashLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFlashLight];
    _btnFlashLight = btnFlashLight;
    
    // 手动输入码 Label
    UILabel *lblHand = [[UILabel alloc] init];
    lblHand.textAlignment = NSTextAlignmentCenter;
    lblHand.textColor = [UIColor whiteColor];
    lblHand.text = @"手动输入";
    [self.view addSubview:lblHand];
    _lblInput = lblHand;
    
    // 手电筒 Label
    UILabel *lblFlashLight = [[UILabel alloc] init];
    lblFlashLight.textAlignment = NSTextAlignmentCenter;
    lblFlashLight.textColor = [UIColor whiteColor];
    lblFlashLight.text = @"手电筒";
    [self.view addSubview:lblFlashLight];
    _lblFlashLight = lblFlashLight;
    
    
    float btnWidth = 80.0f;
    float btnHeight = 80.0f;
    float btnY = Main_Screen_Height - 180;
    
    // 手动输入码
    _btnInput.frame = CGRectMake((Main_Screen_Width/2 - btnWidth)/2, btnY, btnWidth,btnHeight);
    // 手电筒
    _btnFlashLight.frame = CGRectMake(Main_Screen_Width/2 + (Main_Screen_Width/2 - btnWidth)/2, btnY, btnWidth,btnHeight);
    
    float lblY = _btnInput.frame.size.height + _btnInput.frame.origin.y;
    // 手动输入码 Label
    _lblInput.frame = CGRectMake(0, lblY, Main_Screen_Width/2,40);
    // 手电筒 Label
    _lblFlashLight.frame = CGRectMake(Main_Screen_Width/2, lblY, Main_Screen_Width/2,40);
}

- (void)getScanDataString:(NSString*)scanDataString{
    
    if(self.scanBlock)
    {
        self.scanBlock(scanDataString);
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}




/** 手动输入二维码*/
- (void)inputQRCode{
    
    __weak typeof(self) weakSelf = self;
    
    InputQRCodeVC *vc = [[InputQRCodeVC alloc] init];

    vc.inputBlock = ^(NSString *string) {
      
       // [weakSelf getScanDataString:string];
        
        if(weakSelf.scanBlock)
        {
            weakSelf.scanBlock(string);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.navigationController pushViewController:vc animated:YES];

}

/** 打开手电筒*/
- (void)openFlashLight
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!isFlashLightOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                isFlashLightOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                isFlashLightOn = NO;
            }
            [device unlockForConfiguration];
        }else{
            
            NSLog(@"该设备没有闪光灯");
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
