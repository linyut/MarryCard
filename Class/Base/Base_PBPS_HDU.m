//
//  Base_PBPS_HDU.m
//  PBPS-MA
//
//  Created by BOCOP-0018 on 17/5/3.
//  Copyright © 2017年 BOC_PBPS. All rights reserved.
//

#import "Base_PBPS_HDU.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>

#define WidthSize            130
#define HeightSize           100
#define CancelButtonWidth    20
#define CancelButtonHeight   20


#define APPDELEGATE     ((AppDelegate*)[[UIApplication sharedApplication] delegate])


#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

#pragma mark - UIImage Animated GIF


@implementation UIImage (animatedGIF)

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}
@end

@interface Base_PBPS_HDU()

@property (nonatomic,strong)UIView      *bgView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,retain)UIButton    *cancelButton;
@property (nonatomic,copy) void(^cancelBlock)();

@end



@implementation Base_PBPS_HDU

static Base_PBPS_HDU *hud;


+ (Base_PBPS_HDU*)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        hud=[[Base_PBPS_HDU alloc]init];
    });
    return hud;
}
#pragma mark - 页面初始化
- (instancetype)init
{
    self = [[super init] initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {

        self.mode=MBProgressHUDModeCustomView;
        [self.bgView addSubview:self.imageView];
        self.imageView.center=CGPointMake(self.bgView.center.x, self.bgView.center.y-15);
        [self.bgView addSubview:self.cancelButton];
        self.customView=self.bgView;
        self.opacity=0;
        self.backgroundColor=[UIColor colorWithRed:((float)((0x666666 & 0xFF0000) >> 16))/255.0 green:((float)((0x666666 & 0xFF00) >> 8))/255.0 blue:((float)(0x666666 & 0xFF))/255.0 alpha:0.5];

        [[UIApplication sharedApplication].keyWindow  addSubview:self];
        [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    }
    return self;
}
- (UIView*)bgView
{
    if (!_bgView) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthSize, HeightSize)];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.cornerRadius=5;
        _bgView.clipsToBounds=YES;

        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, HeightSize-17-13, WidthSize, 13)];
        label.text=@"努力加载中...";
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        label.textColor=[UIColor colorWithRed:155/255.0f green:155/255.0f blue:155/255.0f alpha:1];
        [_bgView addSubview:label];
    }
    return _bgView;
}

- (UIImageView*)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140/2.0f, 140/2.0f)];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius=10;
        _imageView.clipsToBounds=YES;
        [_imageView stopAnimating];
        [_imageView setImage:[UIImage animatedImageWithAnimatedGIFURL:[[NSBundle mainBundle] URLForResource:@"londing.gif" withExtension:nil]]];
    }
    return _imageView;
}
- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame=CGRectMake(WidthSize-CancelButtonWidth-20, 15, CancelButtonWidth, CancelButtonHeight);
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"button_cancel_request.png"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.hidden=YES;
    }
    return _cancelButton;
}

#pragma mark - 取消按钮事件
- (void)cancelAction
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self hideHUD];
}

#pragma mark - 显示hud
//default
- (void)showDefaultHud
{
    [self show:NO];
    [self fadeIn];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
}

//带取消按钮的hud
- (void)showCancelHud:(void(^)())cancelAction
{
    _cancelButton.hidden=NO;
    if (cancelAction) {
        self.cancelBlock=[cancelAction copy];
    }
    [self showDefaultHud];
}
#pragma mark - 隐藏hud
- (void)hideHUD
{
    [self hide:NO];
    [self fadeOut];
}
#pragma mark 动画action
//淡入
- (void)fadeIn {
    [self.imageView startAnimating];
}

//淡出
- (void)fadeOut {
    [self.imageView stopAnimating];
    for (UIView *view in self.bgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            _cancelButton.hidden=YES;
        }
    }
}
#pragma mark - 类方法显示hud
+ (void)showHUD
{
    [[Base_PBPS_HDU shareManager]showDefaultHud];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

+ (void)hideHUD
{
    [[Base_PBPS_HDU shareManager] hideHUD];
}

+ (void)showHUDWithCancelButton:(void(^)())cancelAction
{
    [[Base_PBPS_HDU shareManager]showCancelHud:[cancelAction copy]];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

@end
