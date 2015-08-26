//
//  GameViewController.m
//  App
//
//  Created by Ma-Kun on 2015/04/21.
//  Copyright (c) 2015年 TEAM 2. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController () {
    UIBezierPath *bezierPath;
    UIImage *lastDrawImage;
  }

@end

@implementation GameViewController
@synthesize red, green,blue,RLabel,GLabel,BLabel,NowColor;

- (void)dealloc {
    [red release];
    [green release];
    [blue release];
    [RLabel release];
    [GLabel release];
    [BLabel release];
    [NowColor release];
    [super dealloc];
}

- (IBAction)SliderChanged:(id)sender {
    //スライダーの現在値を取得
    float R = 0;
    float G = 0;
    float B  = 0;
    R = red.value;
    G = green.value;
    B  = blue.value;
    
    //ラベルに現在値を表示
    RLabel.text = [NSString stringWithFormat:@"%2.f",R];
    GLabel.text = [NSString stringWithFormat:@"%2.f",G];
    BLabel.text = [NSString stringWithFormat:@"%2.f",B];
    
    NowColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _label.text = @"Tap the [Start] to take a picture";
    // スイッチの設置
    UISwitch *sw = [[UISwitch alloc]init];
    sw.center = CGPointMake(100, 50);
    
    // スイッチをONにする
    sw.on = YES;
    
    // スイッチの値が変更されたときに呼ばれるメソッドを設定
    [sw addTarget:self
           action:@selector(drawLine:)
 forControlEvents:UIControlEventValueChanged];
    
    // スイッチをビューに追加
    [self.view addSubview:sw];
}

// カメラの撮影開始
- (IBAction)cameraStart:(id)sender {
    // カメラの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    // カメラが利用可能かチェック
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        // インスタンスの作成
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
    else{
        _label.text = @"error";
    }
}

//　撮影が完了時した時に呼ばれる
- (void)imagePickerController: (UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_cameraView setImage:cameraImage];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    _label.text = @"Tap the [Save] to save a picture";
}

// 撮影がキャンセルされた時に呼ばれる
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    _label.text = @"Canceled";
}

// 写真を保存
- (IBAction)savePic:(id)sender {
    UIImage *image = [_cameraView image];
    if (image == nil) return;
    
    // イメージのフォトアルバムへの書き込み
    UIImageWriteToSavedPhotosAlbum(image,
                                   self, @selector(savedPic:didFinishSavingWithError:contextInfo:), NULL);
}

// 書き込み完了
- (void)savedPic:(UIImage *)image didFinishSavingWithError:(NSError *)error
     contextInfo:(void *)contextInfo {
    if (error == nil) {
        _label.text = @"Save Succeeded";
        
    } else {
        _label.text = @"Save Failed !";
    }
}

// アルバムを表示
- (IBAction)showAlbum:(id)sender{
    // アルバムの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        // ビューを開く
        [self presentViewController:cameraPicker animated:YES completion:nil];
        
        _label.text = @"Tap the [Start] to save a picture";
    }
    else{
        _label.text = @"error";
    }
}

- (IBAction)clearBtnPressed:(id)sender
{
    // 画面をクリアします。
    lastDrawImage = nil;
    self.canvas.image = nil;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // パスを初期化します。
    bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineWidth = 4.0;
    [bezierPath moveToPoint:currentPoint];
  
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始時にパスを初期化していない場合は処理を終了します。
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // パスにポイントを追加します。
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画します。
    [self drawLine:bezierPath];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // タッチ開始時にパスを初期化していない場合は処理を終了します。
    if (bezierPath == nil){
        return;
    }
    
    // タッチした座標を取得します。
    CGPoint currentPoint = [[touches anyObject] locationInView:self.canvas];
    
    // パスにポイントを追加します。
    [bezierPath addLineToPoint:currentPoint];
    
    // 線を描画します。
    [self drawLine:bezierPath];
    
    // 今回描画した画像を保持します。
    lastDrawImage = self.canvas.image;
    
    
}

- (void)drawLine:(UIBezierPath*)path
{
        // 非表示の描画領域を生成します。
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    
    // 描画領域に、前回までに描画した画像を、描画します。
    [lastDrawImage drawAtPoint:CGPointZero];
    
    // 色をセットします。
    [[UIColor blackColor] setStroke];
    
    // 線を引きます。
    [path stroke];
    
    // 描画した画像をcanvasにセットして、画面に表示します。
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 描画を終了します。
    UIGraphicsEndImageContext();
}
- (void)switch_ValueChanged:(id)sender
{
    UISwitch *sw = sender;
    if (sw.on) {
         [[UIColor redColor] setStroke];
        NSLog(@"スイッチがONになりました．");
    } else {
         [[UIColor blackColor] setStroke];
        NSLog(@"スイッチがOFFになりました．");
    }
    }
@end