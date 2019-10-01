//
//  XYKEateTableViewCell.h
//  xyk
//
//

#import <UIKit/UIKit.h>
typedef void(^clickadd)(NSString *title);

@interface XYKEateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *qkLabel;
@property (weak, nonatomic) IBOutlet UILabel *eateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jykLabel;
@property (nonatomic,copy)clickadd clickadd;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@end
