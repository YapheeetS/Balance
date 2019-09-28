//
//  NSString+Extension.h
//  EasyFlowerFind
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

// 计算高度
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//字典或数组序列化
+(NSString *)strEcodingWith:(id)obj;

//工具
-(BOOL)isValidateEmail;

//是否是手机号码
+(BOOL)isValidatePhone:(NSString *)phone;

/** 身份证号全校验 */
+(BOOL)verifyIDCardNumber:(NSString *)IDCardNumber;

//字母.数字.下划线组成的密码
+(BOOL)isPassword:(NSString *)password;

+(BOOL)isIDStr:(NSString *)idStr;

+(BOOL)isHZ:(NSString *)string;

+(BOOL)isEnglish:(NSString *)string;

+(BOOL)isNum:(NSString *)string;

+(BOOL)isPureInt:(NSString*)string;

+(BOOL)isPureFloat:(NSString*)string;

+(BOOL)isEmoji:(NSString *)string;

//是否全部空格
+(BOOL)isEmpty:(NSString *)string;

//integer类型转字符串
+(NSString *)fromInteger:(NSInteger)integer;

// 是否含有emoji表情
+(BOOL)emojiInSoftBankUnicode:(short)code;

+(BOOL)emojiInUnicode:(short)code;

//中文长度判读和截取
-(NSUInteger)lengthOfBytesUsingChineseCheck;

-(NSString *)subChineseStringToIndex:(NSUInteger)to;

//获取设备ID
+(NSString *)deviceUUIDString;

// 获取APP版本号
+(NSString *)APPVersionCode;

/**
 根据字体的属性计算高度
 
 @param font 字体
 @param maxSize 最大的 Size
 @param string 字符串
 @return 字体的 Size
 */
+(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string;

/**
 时间戳转 格式化时间
 
 @param strTime 时间戳字符串
 @param Format 需要格式化的字符串
 @return 返回格式化后的时间
 */
+(NSString *)timeStamp:(NSString *)strTime type:(NSString *)Format;

/**
 设置行间距

 @param text 文字
 @param lbl 要设置的label
 @param lineSpacing 要设置的lineSpacing
 */
+(void)setLineSpacingWithText:(NSString *)text label:(UILabel *)lbl lineSpacing:(NSInteger)lineSpacing size:(CGSize)size;

/** 设置 range 范围内的文字 **/
+(void)setLineSpacingWithText:(NSString *)text label:(UILabel *)lbl lineSpacing:(NSInteger)lineSpacing size:(CGSize)size range:(NSRange)range;

/**
 * 计算文字高度，可以处理计算带行间距的
 */
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing text:(NSString *)text;

/**
 *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 */
+(BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing text:(NSString *)text;

/**
 具体时间

 @param interval 时间戳
 @return 字符串
 */
+(NSString *)stringWithDateIntervalFromBase:(unsigned long long)interval;

/**
 转换为字符串

 @param value 要转换的值
 @return 返回转换后的字符串
 */
+(NSString *)conversionToStringWithValue:(id)value;

/**
 判断某个时间是否处于当天内
 
 @param date 某个时间
 */
+(BOOL)isTodayWithDate:(NSDate *)date;

// !!!: 判断 date 是否在3天内
+(BOOL)isWithin5Days:(NSDate *)date;

// !!!: 判断 date 是否在指定天内
+(BOOL)isinDays:(NSDate *)date day:(NSInteger)day;

- (BOOL)empty;
- (BOOL)notEmpty;
- (BOOL)isCellPhone;

/**
 字符串进行Url编码
 @return 返会字符串
 */
-(NSString *)URLEncodedString;


/**
 字符串进行Url解码
 
 @return 返回加密前的串
 */
-(NSString *)decodeFromPercentEscapeString;

-(CGFloat)calculationStringSize:(CGFloat)width andWithTextFont:(UIFont *)font;

//数字转换成一二三四
+(NSString *)converChinaNum:(NSUInteger)tag;

//当前app版本
+(NSString *)currendAppVersion;

//获取缓存文件的大小
+(NSString *)sizeForCache;

//获取设备型号信息
+ (NSString *)platform;

@end
