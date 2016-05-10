//
//  ViewController.m
//  SaveImage
//
//  Created by sunzhaokai on 16/5/10.
//  Copyright © 2016年 孙赵凯. All rights reserved.
//

#import "ViewController.h"
#import "SZKImagePickerVC.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height



@interface ViewController ()<SZKImagePickerVCDelegate,UIActionSheetDelegate>

@property(nonatomic,retain)UIButton *titleBt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleBt=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-75, 150, 150, 150)];
    _titleBt.backgroundColor=[UIColor yellowColor];
    _titleBt.layer.cornerRadius=75;
    _titleBt.layer.masksToBounds=YES;
    [_titleBt addTarget:self action:@selector(titleBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_titleBt];
    
    //从沙盒中读取照片  imageName应当与保存时的name相同
    UIImage *sandBoxImage=[SZKImagePickerVC loadImageFromSandbox:@"image"];
    [_titleBt setBackgroundImage:sandBoxImage forState:UIControlStateNormal];

}
#pragma mark----跳转到SZKImagePickerVC中
-(void)titleBtClick
{
    //判断是否支持相机  模拟器去除相机功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从相册上传" ,nil];
        [sheet showInView:self.view];
    }else{
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册上传" ,nil];
        [sheet showInView:self.view];
    }
}
#pragma mark-----UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        switch (buttonIndex) {
            case 0:{
                [self presentViewController:ImagePickerStyleCamera];
            }
                break;
            case 1:{
                [self presentViewController:ImagePickerStylePhotoLibrary];
            }
                break;
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:{
                [self presentViewController:ImagePickerStylePhotoLibrary];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark----跳转到SZKImagePickerVC
-(void)presentViewController:(imagePickerStyle)style
{
    SZKImagePickerVC *picker=[[SZKImagePickerVC alloc]initWithImagePickerStyle:style];
    picker.SZKDelegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark----SZKImagePickerVCDelegate
-(void)imageChooseFinish:(UIImage *)image
{
    [_titleBt setBackgroundImage:image forState:UIControlStateNormal];
    //保存到沙盒中
    [SZKImagePickerVC saveImageToSandbox:image andImageNage:@"image" andResultBlock:^(BOOL success) {
        NSLog(@"保存成功");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
