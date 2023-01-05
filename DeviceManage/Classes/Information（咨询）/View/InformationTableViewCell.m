//
//  InformationTableViewCell.m
//  DeviceManage
//
//  Created by sjl on 2019/12/5.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "InformationTableViewCell.h"

//1. 咨询标题图片控件的Rect信息
//图片长和宽都为80
#define InformationTitleImgWidth 80
#define InformationTitleImgHeight 80
//图片的左上角x坐标
#define InformationTitleImgX 10
//图片的左上角y坐标
#define InformationTitleImgY 10

//2. 咨询标题Logo图片控件的Rect信息
//图片长和宽都为20
#define InformationTitleLogoImgWidth 20
#define InformationTitleLogoHeight 20
//图片的左上角x坐标
#define InformationTitleLogoImgX 95
//图片的左上角y坐标
#define InformationTitleLogoImgY 15

//3. 咨询标题文本控件的Rect信息
//文本控件的宽度
#define InformationTitleLabWidth ScreenWidth * 2/3
#define InformationTitleLabHeight 50
#define InformationTitleLabX 120
#define InformationTitleLabY 10

//4. 咨询创建时间Logo图片控件的Rect信息
//图片长和宽都为20
#define InformationCreateTimeLogoImgWidth 20
#define InformationCreateTimeLogoImgHeight 20
//图片的左上角x坐标
#define InformationCreateTimeLogoImgX 95
//图片的左上角y坐标
#define InformationCreateTimeLogoImgY 65

//5. 咨询创建时间文本控件的Rect信息
#define InformationCreateTimeLabWidth ScreenWidth/3
#define InformationCreateTimeLabHeight 30
#define InformationCreateTimeLabX 120
#define InformationCreateTimeLabY 60


@implementation InformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.设置cell视图背景为白色
        self.backgroundColor=UIColor.whiteColor;
        //2.给informationTitleImg控件属性创建对象
        _informationTitleImg=[[UIImageView alloc]initWithFrame:CGRectMake(InformationTitleImgX, InformationTitleImgY, InformationTitleImgWidth, InformationTitleImgHeight)];
        //image属性不能为null，因此必须新建图片对象进行赋值，但是图片内容可以随意
        _informationTitleImg.image=[UIImage imageNamed:@"infoTitleImg"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_informationTitleImg];
        //3.创建一个咨询标题Logo图片，这张图片是不变的，所以不需要建立控件属性
        UIImageView *informationTitleLogoImg=[[UIImageView alloc]initWithFrame:CGRectMake(InformationTitleLogoImgX, InformationTitleLogoImgY, InformationTitleLogoImgWidth, InformationTitleLogoHeight)];
        informationTitleLogoImg.image=[UIImage imageNamed:@"infoTitleLogo"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:informationTitleLogoImg];
        //4.给informationTitleLab控件属性创建对象
        _informationTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(InformationTitleLabX, InformationTitleLabY, InformationTitleLabWidth, InformationTitleLabHeight)];
        _informationTitleLab.font =[UIFont systemFontOfSize:17];
        _informationTitleLab.text=@"惠普打印机特价销售";
        _informationTitleLab.numberOfLines=0;
        _informationTitleLab.textColor = UIColor.orangeColor;
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_informationTitleLab];
        //5.创建一个咨询创建时间Logo图片，这张图片是不变的，所以不需要建立控件属性
        UIImageView *_informationCreateTimeLogoImg=[[UIImageView alloc]initWithFrame:CGRectMake(95, 65, 20, 20)];
        _informationCreateTimeLogoImg.image=[UIImage imageNamed:@"infoCreateTimeLogo"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_informationCreateTimeLogoImg];
        //6.给informationCreateTimeLab控件属性创建对象
        _informationCreateTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(InformationCreateTimeLabX, InformationCreateTimeLabY, InformationCreateTimeLabWidth, InformationCreateTimeLabHeight)];
        _informationCreateTimeLab.font =[UIFont systemFontOfSize:17];
        _informationCreateTimeLab.text=@"¥2600";
        _informationCreateTimeLab.textColor = UIColor.blackColor;
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_informationCreateTimeLab];
    }
    return self;
}

-(void)setUpCell:(Information *)model{
    //字符串截取
    NSString *baseurl=[BASE_URL substringToIndex:([BASE_URL length]-14)];
    //字符串拼接
    NSString *imgStr=[NSString stringWithFormat:@"%@%@", baseurl,model.InformationImage];
    //加载网络图片
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgStr]];
    //根据提取的咨询标题图片网址，设置informationTitleImg控件的image属性，显示咨询标题图片
    _informationTitleImg.image = [UIImage imageWithData: imageData];
    //通过识别</x>将string字符串转换为array数组
    NSArray *array=[model.InformationContent componentsSeparatedByString:@"</x>"];
    //array中第一个就是咨询标题，再将<x>替换成空字符串得到咨询标题
    NSString *infoTitle=[array[0] stringByReplacingOccurrencesOfString:@"<x>" withString:@""];
    //根据提取的咨询标题，设置informationTitleLab控件的text属性，显示咨询标题
    _informationTitleLab.text=infoTitle;
    //根据model.InformationCreateTime，设置_informationCreateTimeLab控件的text属性，显示咨询创建时间
    _informationCreateTimeLab.text=model.InformationCreateTime;
}

@end
