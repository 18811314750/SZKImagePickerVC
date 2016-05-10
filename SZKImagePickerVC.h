//
//  SZKImagePickerVC.h
//  热点资讯
//
//  Created by sunzhaokai on 16/5/3.
//  Copyright © 2016年 孙赵凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSUInteger,imagePickerStyle){
    ImagePickerStyleCamera,
    ImagePickerStylePhotoLibrary
};

@protocol SZKImagePickerVCDelegate <NSObject>

-(void)imageChooseFinish:(UIImage *)image;

@end
/**
 *  保存成功回调
 *
 *  @param success 保存成功的block
 */
typedef void(^resultBlock)(BOOL success);


@interface SZKImagePickerVC : UIImagePickerController
/**
 *  SZKImagePickerVCDelegate
 */
@property(nonatomic,assign)id<SZKImagePickerVCDelegate>SZKDelegate;

/**
 *  初始化SZKImagePicker
 *
 *  @param style 打开照相机或者图库
 *
 *  @return  初始化SZKImagePicker
 */
-(instancetype)initWithImagePickerStyle:(imagePickerStyle)style;
/**
 *  保存图片到沙盒
 *
 *  @param image     要保存的图片
 *  @param imageName 保存的图片名称
 *  @param block     保存成功的值
 */
+(void)saveImageToSandbox:(UIImage *)image
             andImageNage:(NSString *)imageName
           andResultBlock:(resultBlock)block;
/**
 *  沙盒中获取到的照片
 *
 *  @param imageName 读取的照片名称
 *
 *  @return 从沙盒读取到的照片
 */
+(UIImage *)loadImageFromSandbox:(NSString *)imageName;
/**
 *  根据文件获取沙盒路径
 *
 *  @param fileName 文件名称
 *
 *  @return 文件在沙盒中的路径
 */
+(NSString *)filePath:(NSString *)fileName;


@end
