/*
 
 调用说明：
 1. 在找到项目.plist，右击Open As -> Source Code,添加如下两句代码：
        <key>NSCameraUsageDescription</key>
        <string>二维码扫描</string>
 
 2. 在调用的文件引入 #import "LPHScanVC.h"
 
 3. 调用示例：
 
    LPHScanVC *vc = [[LPHScanVC alloc]init];
 
    vc.scanBlock = ^(NSString *strScan) {
 
        NSLog(@"扫描到的二维码是：%@",strScan);
    };
 
    [self.navigationController pushViewController:vc animated:YES];
 
 */

#import "ExampleVC.h"
#import "LPHScanVC.h"

@interface ExampleVC ()

@end

@implementation ExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 250, 100)];
    [btn setTitle:@"扫描" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)scanQRCode
{
    LPHScanVC *vc = [[LPHScanVC alloc]init];
    
    vc.scanBlock = ^(NSString *strScan) {
        
        NSLog(@"扫描到的二维码是：%@",strScan);
    };
    
    [self.navigationController pushViewController:vc animated:YES];
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
