//
//  NSString+Extension.m
//  EasyFlowerFind
//
//

#import "NSString+Extension.h"
#import "sys/utsname.h"
@implementation NSString (Extension)

#pragma mark - 尺寸计算
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{ NSFontAttributeName: font };
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 字典或数组序列化

+ (NSString *)strEcodingWith:(id)obj {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark - 工具方法
//是否是邮箱
- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//是否是手机号码
+ (BOOL)isValidatePhone:(NSString *)phone {
    NSString *regex = @"^1+\\d{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phone];
}

// 身份证号全校验
+ (BOOL)verifyIDCardNumber:(NSString *)IDCardNumber {
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd, @"[0-9]{3}[0-9Xx]"];

    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber]) {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10, 1)].intValue) * 7
        + ([IDCardNumber substringWithRange:NSMakeRange(1, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11, 1)].intValue) * 9
        + ([IDCardNumber substringWithRange:NSMakeRange(2, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12, 1)].intValue) * 10
        + ([IDCardNumber substringWithRange:NSMakeRange(3, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13, 1)].intValue) * 5
        + ([IDCardNumber substringWithRange:NSMakeRange(4, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14, 1)].intValue) * 8
        + ([IDCardNumber substringWithRange:NSMakeRange(5, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15, 1)].intValue) * 4
        + ([IDCardNumber substringWithRange:NSMakeRange(6, 1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16, 1)].intValue) * 2
        + [IDCardNumber substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [IDCardNumber substringWithRange:NSMakeRange(8, 1)].intValue * 6
        + [IDCardNumber substringWithRange:NSMakeRange(9, 1)].intValue * 3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder, 1)];// 判断校验位
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17, 1)] uppercaseString]];
}

//字母.数字.下划线组成的密码
+ (BOOL)isPassword:(NSString *)password {
    NSString *regex = @"^[a-zA-Z0-9_]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:password];
}

//字母.数字.下划线组成的id
+ (BOOL)isIDStr:(NSString *)idStr {
    NSString *regex = @"^[a-zA-Z0-9_]{0,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:idStr];
}

//是否是纯汉字
+ (BOOL)isHZ:(NSString *)string {
    NSString *regex = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

//是否是纯英文+数字
+ (BOOL)isEnglish:(NSString *)string {
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

//是否是纯数字
+ (BOOL)isNum:(NSString *)string {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

//是否整数
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//是否小数
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isEmoji:(NSString *)string {
    for (NSInteger i = 0; i < string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        NSInteger subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (subStringLength == 0) {
            str = [string substringWithRange:NSMakeRange(i, 2)];
            subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            i++;
        }
        NSInteger subLength = [string numberForNormalLenght:subStringLength];
        if (subLength == 3) {
            return YES;
        }
    }
    return NO;
}

//是否全部是空格
+ (BOOL)isEmpty:(NSString *)string {
    if (!string) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [string stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

//integer类型转字符串
+ (NSString *)fromInteger:(NSInteger)integer {
    return [NSString stringWithFormat:@"%li", (long)integer];
}

- (NSInteger)numberForNormalLenght:(NSInteger)subStringLength {
    switch (subStringLength) {
        case 1:
            return 1;
            break;

        case 3:
            return 1;
            break;

        case 4:
            return 3;
            break;

        default:
            return 1;
            break;
    }
}

// 是否含有emoji表情

+ (BOOL)emojiInSoftBankUnicode:(short)code {
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}

+ (BOOL)emojiInUnicode:(short)code {
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}

#pragma mark - 中文字符串检查或截取

- (NSUInteger)lengthOfBytesUsingChineseCheck {
    NSUInteger length = 0;
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        NSInteger subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (subStringLength == 0) {
            str = [self substringWithRange:NSMakeRange(i, 2)];
            subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            i++;
        }
        length += [self numberForNormalLenght:subStringLength];
    }
    return length;
}

- (NSString *)subChineseStringToIndex:(NSUInteger)to {
    NSAssert(to < [self lengthOfBytesUsingChineseCheck], @"已经超过给定的长度");
    NSInteger length = to;
    NSInteger trueTo = 0;
    if (to == 0) {
        return [self substringToIndex:0];
    }
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        NSInteger subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (subStringLength == 0) {
            str = [self substringWithRange:NSMakeRange(i, 2)];
            subStringLength = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            i++;
        }
        length -= [self numberForNormalLenght:subStringLength];
        if (length == 0) {
            trueTo = i + 1;
            break;
        } else if (length == -1) {// 卡半个情况
            // 区分是emoji表情还是中文字符
            if (subStringLength == 3) {
                // 中文
                trueTo = i;
            } else {
                // emoji
                trueTo = i - 1;
            }
            break;
        }
    }
    return [self substringToIndex:trueTo];
}

//获取设备ID
+ (NSString *)deviceUUIDString {
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)APPVersionCode {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[@"CFBundleShortVersionString"];
}

+ (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string {
    NSDictionary *attrs = @{ NSFontAttributeName: font };

    return [string boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

#pragma mark - 时间戳转时间
+ (NSString *)timeStamp:(NSString *)strTime type:(NSString *)Format {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:Format];
    //    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];

    //用[NSDate date]可以获取系统当前时间
    // 毫秒值转化为秒
    // iOS 生成的时间戳是10位
    NSTimeInterval interval = [strTime doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];

    NSString *dateString = [dateFormatter stringFromDate:date];

    return dateString;
}

#pragma mark - 设置行间距
+ (void)setLineSpacingWithText:(NSString *)text label:(UILabel *)lbl lineSpacing:(NSInteger)lineSpacing size:(CGSize)size {
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    // 计算文字是否超过了一行 超过一行设置行间距
    if (([self boundingRectWithSize:size font:lbl.font lineSpacing:lineSpacing text:text].height - lineSpacing) >= lbl.font.lineHeight) {
        paragraphStyle.lineSpacing = lineSpacing - (lbl.font.lineHeight - lbl.font.pointSize);
    }

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    lbl.attributedText = attributedString;
}

+ (void)setLineSpacingWithText:(NSString *)text label:(UILabel *)lbl lineSpacing:(NSInteger)lineSpacing size:(CGSize)size range:(NSRange)range {
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    // 计算文字是否超过了一行 超过一行设置行间距
    if (([self boundingRectWithSize:size font:lbl.font lineSpacing:lineSpacing text:text].height - lineSpacing) >= lbl.font.lineHeight) {
        paragraphStyle.lineSpacing = lineSpacing;
    }

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#999999"] range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];

    lbl.attributedText = attributedString;
}

/**
 * 计算文字高度，可以处理计算带行间距的
 */
+ (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing text:(NSString *)text {
    if ([@"" isEqualToString:text] || !text) {
        text = @"";
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];

    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([NSString containChinese:text]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - paragraphStyle.lineSpacing);
        }
    }

    return rect.size;
}

//判断如果包含中文
+ (BOOL)containChinese:(NSString *)str {
    for (int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containChineseText:(NSString *)str {
    for (int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/**
 *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
 */
+ (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing text:(NSString *)text {
    if (([self boundingRectWithSize:size font:font lineSpacing:lineSpacing text:text].height - lineSpacing) >= font.lineHeight) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)stringWithDateIntervalFromBase:(unsigned long long)interval {//单位是秒
    unsigned long long time = [[NSDate date]timeIntervalSince1970] - interval;
    if (time == 0) {
        return @"";
    }

    if (time < 60) {
        //不足一分钟
        return [NSString stringWithFormat:@"%llu秒", time];
    }

    if (time < 60 * 60) {
        // 不足一个小时
        return [NSString stringWithFormat:@"%llu分钟", time / 60];
    } else if (time < 24 * 60 * 60) {
        // 不足一天
        NSInteger hours = (int)time / 3600;
        return [NSString stringWithFormat:@"%zd小时", hours];
    } else if (time < 30 * 24 * 60 * 60) {
        // 超过一天,不足一个月
        NSInteger days = (int)time / 86400;
        return [NSString stringWithFormat:@"%zd天", days];
    } else if (time < 365 * 30 * 24 * 60 * 60) {
        // 超过一个月，不足一年
//        NSInteger months = (int)time/(24*30*3600);
//        return [NSString stringWithFormat:@"%zd月", months];
        return [NSString timeStamp:[NSString stringWithFormat:@"%llu", interval] type:@"MM月dd日"];
    } else {
        // 超过一年。
//        NSInteger years = (int)time/(365*24*30*3600);
//        return [NSString stringWithFormat:@"%zd年", years];
        return [NSString timeStamp:[NSString stringWithFormat:@"%llu", interval] type:@"MM月dd日"];
    }
}

// !!!: 转换为字符串
+ (NSString *)conversionToStringWithValue:(id)value {
    return [NSString stringWithFormat:@"%@", value];
}

/**
 判断某个时间是否处于当天内

 @param date 某个时间
 */
+ (BOOL)isTodayWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    //    components.hour = 8;
    // 当天起始时间
    NSDate *startDate = [calendar dateFromComponents:components];
    // 当天结束时间
    NSDate *expireDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];

    if ([date compare:startDate] == NSOrderedDescending && [date compare:expireDate] == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

// !!!: 判断 date 是否在3天内
+ (BOOL)isWithin5Days:(NSDate *)date {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay = 24 * 60 * 60 * 1;  //1天的长度
    // 3天后
    NSDate *threeDate = [nowDate initWithTimeIntervalSinceNow:+oneDay * 5];

    // 判断 date 是否在3天内
    if ([date earlierDate:threeDate] == date) {
        return true;
    } else {
        return false;
    }
}

// !!!: 判断 date 是否在指定天内
+ (BOOL)isinDays:(NSDate *)date day:(NSInteger)day {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay = 24 * 60 * 60 * 1;  //1天的长度
    NSDate *threeDate = [nowDate initWithTimeIntervalSinceNow:+oneDay * day];
    // 判断 date 是否在3天内
    if ([date earlierDate:threeDate] == date) {
        return true;
    } else {
        return false;
    }
}

- (BOOL)empty {
    return (self == nil || [self length] == 0) ? YES : NO;
}

- (BOOL)notEmpty {
    return (self != nil && [self length]) > 0 ? YES : NO;
}

- (BOOL)isCellPhone {
    NSString *pattern = @"^1+\\d{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)URLEncodedString {
    NSString *outputStr =

        (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(

            NULL,                                                      /* allocator */

            (__bridge CFStringRef)self,

            NULL,                                                      /* charactersToLeaveUnescaped */

            (CFStringRef)@"!*'();:@&=+$,/?%#[]",

            kCFStringEncodingUTF8);

    return outputStr;
}

- (NSString *)decodeFromPercentEscapeString {
    NSMutableString *outputStr = [NSMutableString stringWithString:self];

    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];

    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (CGFloat)calculationStringSize:(CGFloat)width andWithTextFont:(UIFont *)font  {
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil].size.height;
}

+ (NSString *)converChinaNum:(NSUInteger)tag {
    switch (tag) {
        case 0:
            return @"零";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        case 7:
            return @"七";
            break;
        case 8:
            return @"八";
            break;
        case 9:
            return @"九";
            break;
        case 10:
            return @"十";
            break;
        default:
            break;
    }
    return @"";
}

//当前app版本
+ (NSString *)currendAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];

    return app_Version;
}

//获取缓存文件的大小
+ (NSString *)sizeForCache {
    return nil;
}

+ (NSString *)platform {
    struct utsname systemInfoa;
    uname(&systemInfoa);

    NSString *platform = [NSString stringWithCString:systemInfoa.machine encoding:NSASCIIStringEncoding];

    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([platform isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone_X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone_X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone_XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone_XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone_X MAX";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone_X MAX";

    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";

    if ([platform isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";

    if ([platform isEqualToString:@"i386"]) return @"Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"Simulator";
    return platform;
}

@end
