# LPHScan
ScanQRCode

![image](https://https://github.com/iosraven/LPHScan/IMG_ScanQRCode.PNG)
![image](https://https://github.com/iosraven/LPHScan/IMG_InputQRCode.PNG)
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
