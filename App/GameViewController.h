//
//  GameViewController.h
//  App
//

//  Copyright (c) 2015年 TEAM 2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>


@interface GameViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton *bCameraStart;
@property (nonatomic, retain) IBOutlet UIButton *bSavePic;
@property (nonatomic, retain) IBOutlet UIButton *bAlbum;
@property  (nonatomic, retain) IBOutlet UIImageView *canvas;
@property  (nonatomic, retain) IBOutlet UIPickerView *clearBtn;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIImageView *cameraView;
@property (nonatomic, retain) IBOutlet UISlider *red;
@property (nonatomic, retain) IBOutlet UISlider *green;
@property (nonatomic, retain) IBOutlet UISlider *blue;
@property (retain, nonatomic) IBOutlet UILabel *RLabel;
@property (retain, nonatomic) IBOutlet UILabel *GLabel;
@property (retain, nonatomic) IBOutlet UILabel *BLabel;
@property (retain, nonatomic) IBOutlet UIView *NowColor;
- (IBAction)cameraStart:(id)sender;
- (IBAction)savePic:(id)sender;
- (IBAction)showAlbum:(id)sender;
- (IBAction)clearBtnPressed:(id)sender;
- (IBAction)SliderChanged:(id)sender;
@end
