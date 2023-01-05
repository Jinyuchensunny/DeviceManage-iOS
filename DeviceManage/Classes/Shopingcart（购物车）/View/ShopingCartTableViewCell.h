#import <UIKit/UIKit.h>
#import "Shopingcart.h"

NS_ASSUME_NONNULL_BEGIN

//单元格委托协议
@protocol ShopingCartTableViewCellDelegate <NSObject>
-(void)howtochange;   //减少和增加设备数量导致的购物车中该款设备总价格的变化
-(void)howtochoose;   //选中和不选中导致的购物车中该款设备总价格的变化
@end

//单元格视图类
@interface ShopingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;        //设备选中按钮
@property (weak, nonatomic) IBOutlet UIImageView *deviceImg;   //设备图片
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLab;   //设备名称标签
@property (weak, nonatomic) IBOutlet UILabel *devicePriceLab;    //设备价格标签
@property (weak, nonatomic) IBOutlet UILabel *shoppingNumLab;  //设备购买数量标签

- (IBAction)chooseDevice:(id)sender;//是否选中设备
- (IBAction)subDevice:(id)sender;//减少设备购买数量按钮
- (IBAction)addDevice:(id)sender;//增加设备购买数量按钮

//视图View对应的模型Model
@property (retain,nonatomic)Shopingcart *model;

//协议对象属性，这个对象用于接受传入的实现该协议的对象（即ShopingCartTableView类，在该对象中将重载协议接口方法howtochange）
@property (weak, nonatomic) id<ShopingCartTableViewCellDelegate> delegate;

@end
NS_ASSUME_NONNULL_END
