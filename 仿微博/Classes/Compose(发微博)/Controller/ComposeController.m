//
//  ComposeController.m
//  仿微博
//
//  Created by Yzc on 15/11/11.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "ComposeController.h"
#import "AccountTool.h"
#import "UIView+Extension.h"
#import "TextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "ComposeToolBar.h"
#import "PhotosView.h"
#import "EmotionKeyboard.h"

@interface ComposeController()<UITextViewDelegate,ComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入文本控件 */
@property(nonatomic, weak)TextView *textView;
/** 工具条 */
@property(nonatomic, weak)ComposeToolBar *toolBar;
/** 相册 */
@property(nonatomic, weak) PhotosView *photosView;
/** 表情键盘 */
@property(nonatomic, strong) EmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property(nonatomic, assign) BOOL switchingKeyboard;

@end

@implementation ComposeController


-(EmotionKeyboard *)emotionKeyboard
{
    if(_emotionKeyboard == nil)
    {
        self.emotionKeyboard = [[EmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 253;
    }
    return _emotionKeyboard;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航
    [self setupNav];
    
    //设置输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolbar];
    
    //添加相册
    [self setupPhotoView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化方法
/**
 *  设置导航
 */
-(void) setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSString *name = [AccountTool account].name;
    NSString *prefix = @"发微博";
    if(name){
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        titleView.y = 50;
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        //创建一个带有属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    }else{
        self.navigationItem.title = prefix;
    }
    
}

/**
 *  添加相册
 */
-(void) setupPhotoView
{
    PhotosView *photosView = [[PhotosView alloc]init];
    photosView.y = 150;
    
    photosView.width = self.view.width - 100;
    photosView.x = (self.view.width - photosView.width) * 0.5;
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}


/**
 *  设置工具条
 */
-(void)setupToolbar
{
    ComposeToolBar *bar = [[ComposeToolBar alloc]init];
    bar.width = self.view.width;
    bar.height = 44;
    bar.delegate = self;
    bar.y = self.view.height - bar.height;
    [self.view addSubview:bar];
    self.toolBar =bar;
    
}

/**
 *  设置文本输入框
 */
-(void)setupTextView
{
    TextView *textView = [[TextView alloc]init];
    textView.frame = self.view.frame;
    textView.font = [UIFont systemFontOfSize:15];
    //垂直方向可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享新鲜事...";
    textView.delegate = self;
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView = textView;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 导航菜单按钮方法
-(void) cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) send
{
    if(self.photosView.photos.count)
    {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)sendWithImage
{
    
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/

    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0) ;
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.png" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}


-(void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}


#pragma mark - 监听方法
-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    //如果键盘正在切换就不执行后面代码，工具条就可以固定不动
    if(self.switchingKeyboard) return;

    NSDictionary *userInfo = notification.userInfo;
    
    double duration=[userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        if(keyboardF.origin.y > self.view.height){
            self.toolBar.y = self.view.height - self.toolBar.height;
        }else{
            self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
        }
    }];
    
}

#pragma mark - UITextViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - ComposeToolbarDelegate
-(void)composeToolbar:(ComposeToolBar *)toolbar didClickButton:(ComposeToolBarButtonType)type
{
    switch (type) {
        case ComposeToolBarButtonCamera:   //拍照
            [self openCamera];
            break;
        case ComposeToolBarButtonPicture:  //打开图库
            [self openAlbum];
            break;
        case ComposeToolBarButtonMention:  //@
            NSLog(@"ComposeToolBarButtonMention");
            break;
        case ComposeToolBarButtonTrend:  //#
            NSLog(@"ComposeToolBarButtonTrend");
            break;
        case ComposeToolBarButtonEmotion: //表情
            [self switchKeyboard];
            break;
            
    }
}


#pragma mark -其他方法
-(void)openCamera
{
    [self openImagPickerController:UIImagePickerControllerSourceTypeCamera];
}
-(void)openAlbum
{
    [self openImagPickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void) openImagPickerController:(UIImagePickerControllerSourceType)type
{
    if(![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //info包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
}


/**
 *  切换键盘（系统键盘跟表情键盘之间）
 */
-(void)switchKeyboard
{
    if(self.textView.inputView == nil)
    { //切换为表情键盘
        self.textView.inputView =self.emotionKeyboard;
        self.toolBar.showKeyboardButton = YES;
    }else{
        self.textView.inputView = nil;
        self.toolBar.showKeyboardButton = NO;
        
    }
    //开始切换键盘
    self.switchingKeyboard = YES;
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        
        //结束键盘切换
        self.switchingKeyboard = NO;
    });
}

@end
