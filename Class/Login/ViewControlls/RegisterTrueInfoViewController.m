//
//  RegisterTrueInfoViewController.m
//  MarryCard
//
//  Created by 方寸山 on 2017/7/10.
//  Copyright © 2017年 LINYUT. All rights reserved.
//

#import "RegisterTrueInfoViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIImage+Extensions.h"


@interface RegisterTrueInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextField *trueNameTextField;

@property (nonatomic,strong) UIActionSheet *imageActionSheet;


@end

@implementation RegisterTrueInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle:@"注册" showLeftButton:YES andrightBtnTitle:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)uploadImageBtnClick:(UIButton *)sender {
    self.imageActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"从手机相册选择",
                             nil];
    [self.imageActionSheet showInView:self.view.window];
}

- (IBAction)completeBtnClick:(UIButton *)sender {
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 0 ) {
        // 相机
        if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if( authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied )
            {
                UIAlertView * alertV = [[UIAlertView alloc]initWithTitle:@"" message:@"请在iPhone的\"设置-隐私\"选项中，允许应用访问您的摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertV show];
                return;
            }
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.mediaTypes = temp_MediaTypes;
            // 用于判断相机是摄像还是拍照 kUTTypeImage 拍照  kUTTypeMovie  对应摄像
            NSArray *arr = [[NSArray alloc] initWithObjects: (NSString *)kUTTypeImage, nil];
            picker.mediaTypes = arr;
            // 判断是否可以编辑，进入编辑的页面
            picker.allowsEditing = NO;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            MESSAGE(@"该设备不支持照相功能");
        }
        
    }else if ( buttonIndex == 1 ){
        
        // 进入头像修改页面
        NSLog(@"%s", __FUNCTION__);
        UIImagePickerController* picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        
    }
}

#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary )
    {
        UIImage  *image=[info valueForKey:UIImagePickerControllerOriginalImage];//原图
        // 显示选中的图片
        // setImage
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        float size = imageData.length/(1024*1024);
        if (size>10) {
            MESSAGE(@"请上传大小在10M以内的图片");
            return;
        }else{
            [self.headerImageView setImage:[image normalizedImage]];
        }
    }
    else
    {
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self.headerImageView setImage:[image normalizedImage]];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
