




#import <UIKit/UIKit.h>

typedef void(^LPHScanBlock)(NSString *strScan);


@interface LPHScanVC : UIViewController



/** 扫描Block*/
@property (nonatomic,copy) LPHScanBlock scanBlock;


@end
