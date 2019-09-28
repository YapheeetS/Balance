//
//  UIImage+Extension.h
//  VCTalk
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
 根据颜色生成一张尺寸为1*1的相同颜色图片

 @param color 颜色
 @return 返回图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 *  图片压缩
 *
 *  @param sourceImage   被压缩的图片
 *  @param defineWidth 被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *)imageCompressed:(UIImage *)sourceImage withdefineWidth:(CGFloat)defineWidth ;

+(UIImage *)buttonImageFromColor:(UIColor *)color andWithSize:(CGSize)size;

//给图片添加模糊 模糊度
+(UIImage *)blurryImage:(UIImage *)image withBlurLever:(CGFloat)blur;

+(UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

/**
 设置网络图片-默认占位图
 
 @param url 地址
 @param imgView 图层
 */
+(void)setImagePathWithUrl:(NSString *)url andImageView:(UIImageView *)imgView;

/**
 设置网络图片-字符串
 
 @param url 地址
 @param imgView 图层
 @param placehold 占位图字符串
 */
+(void)setImagePathWithUrl:(NSString *)url andImageView:(UIImageView *)imgView andPlacehold:(NSString *)placehold;

/**
 设置网络图片-image对象
 
 @param url 地址
 @param imgView 图层
 @param placehold 占位图图片
 */
+(void)setImagePathWithUrl:(NSString *)url andImageView:(UIImageView *)imgView andPlaceholdImage:(UIImage *)placehold;

/** 添加水印 **/
+(UIImage *)jq_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary *)attributed;

/** image的size进行调整 **/
-(UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end

NS_ASSUME_NONNULL_END
