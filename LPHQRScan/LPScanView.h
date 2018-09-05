#import <UIKit/UIKit.h>

typedef void(^ScanBlock)(NSString *scanString);

typedef void(^InputQRBlock)(void);

@protocol LPScanViewDelegate <NSObject>

-(void)getScanDataString:(NSString*)scanDataString;

@end


@interface LPScanView : UIView


@property (nonatomic,assign) id<LPScanViewDelegate> delegate;
@property (nonatomic,assign) int scanW; //扫描框的宽

- (void)startRunning; //开始扫描
- (void)stopRunning; //停止扫描



@property (nonatomic,copy) ScanBlock scanBlock;

@property (nonatomic,copy) InputQRBlock inputQRBlock;

@end
