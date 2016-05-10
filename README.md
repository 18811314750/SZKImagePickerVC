# SZKImagePickerVC
1.轻松实现调用照相机和本地图库，利用代理方法返回选中的照片。2.提供类方法，实现照片保存到沙盒，以及从沙盒中读取保存的图片。

详细文档请查看 http://www.jianshu.com/p/7ffc8844e956

SZKImagePickerVC.h

```
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

```
SZKImagePickerVC.m中
```
#pragma mark---选取照片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //界面返回
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取编辑之后的图片
    UIImage *editedImage=[info objectForKey:UIImagePickerControllerEditedImage];
    //将获取的image传入代理方法中
    [self.SZKDelegate imageChooseFinish:editedImage];
}
#pragma mark----将照片保存到沙盒
+(void)saveImageToSandbox:(UIImage *)image andImageNage:(NSString *)imageName andResultBlock:(resultBlock)block
{
    //高保真压缩图片，此方法可将图片压缩，但是图片质量基本不变，第二个参数为质量参数
    NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
    //将图片写入文件
   NSString *filePath=[self filePath:imageName];
   //是否保存成功
    BOOL result=[imageData writeToFile:filePath atomically:YES];
    //保存成功传值到blcok中
    if (result) {
        block(result);
    }
}
#pragma mark----从沙盒中读取照片
+(UIImage *)loadImageFromSandbox:(NSString *)imageName
{
    //获取沙盒路径
    NSString *filePath=[self filePath:imageName];
    //根据路径读取image
    UIImage *image=[UIImage imageWithContentsOfFile:filePath];
    
    return image;
}
#pragma mark----获取沙盒路径
+(NSString *)filePath:(NSString *)fileName
{
    //获取沙盒目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //保存文件名称
    NSString *filePath=[paths[0] stringByAppendingPathComponent:fileName];
    
    return filePath;
}

```

详细文档请查看 http://www.jianshu.com/p/7ffc8844e956


