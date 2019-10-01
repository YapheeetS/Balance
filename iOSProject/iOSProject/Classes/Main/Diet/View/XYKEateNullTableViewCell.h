//
//  XYKEateNullTableViewCell.h
//  xyk
//
//

#import <UIKit/UIKit.h>
typedef void(^noEateClickAdd) (NSString *title);
@interface XYKEateNullTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *qkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (nonatomic,copy)noEateClickAdd nofontclickAdd;
@end
