//
//  XYKEateHeardViewCell.h
//  xyk
//
//

#import <UIKit/UIKit.h>
typedef void (^clickToWeak)(void);
typedef void (^clickToBack)(void);

@interface XYKEateHeardViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *eatLabel;
@property (weak, nonatomic) IBOutlet UILabel *xhLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelTop;


@property(nonatomic,copy)clickToWeak clickToWeak;

@property(nonatomic,copy)clickToBack clickToBack;

@end
