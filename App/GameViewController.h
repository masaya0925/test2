//
//  GameViewController.h
//  App
//

//  Copyright (c) 2015年 TEAM 2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>


@interface GameViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property IBOutlet UIButton *bCameraStart;
@property IBOutlet UIButton *bSavePic;
@property IBOutlet UIButton *bAlbum;
@property  IBOutlet UIImageView *canvas;
@property  IBOutlet UIButton *clearBtn;

@property IBOutlet UILabel *label;
@property IBOutlet UIImageView *cameraView;

- (IBAction)cameraStart:(id)sender;
- (IBAction)savePic:(id)sender;
- (IBAction)showAlbum:(id)sender;
- (IBAction)clearBtnPressed:(id)sender;

@end
