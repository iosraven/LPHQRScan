#import <UIKit/UIKit.h>


typedef void(^inputBlock)(NSString *string);

@interface InputQRCodeVC : UIViewController



@property (nonatomic,copy) inputBlock inputBlock;

@end
