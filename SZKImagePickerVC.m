//
//  SZKImagePickerVC.m
//  热点资讯
//
//  Created by sunzhaokai on 16/5/3.
//  Copyright © 2016年 孙赵凯. All rights reserved.
//

#import "SZKImagePickerVC.h"

@interface SZKImagePickerVC ()<UIImagePickerControllerDelegate>

@end

@implementation SZKImagePickerVC


-(instancetype)initWithImagePickerStyle:(imagePickerStyle)style
{
    self=[super init];
    if (self) {
        if (style==ImagePickerStyleCamera) {
            self.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if(style==ImagePickerStylePhotoLibrary){
            self.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allowsEditing=YES;
    self.delegate=self;
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.875 alpha:1.000];
    
}
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
    

@end
