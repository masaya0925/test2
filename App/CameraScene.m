//
//  CameraScene.m
//  App
//
//  Created by Ma-Kun on 2015/07/14.
//  Copyright (c) 2015年 TEAM 2. All rights reserved.
//

#import "CameraScene.h"

@implementation CameraScene   {
    
    
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self showUIImagePicker];
}

-(void) showUIImagePicker {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
  
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
   
    imagePickerController.delegate = self;
    

    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
 
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];

- (void)imagePickerController:(UIImagePickerController *)picker
            didFinishPickingImage:(UIImage *) image
                                editingInfo:(NSDictionary *)editingInfo
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        

        UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
    }
    
 
    - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
    {

        [self dismissViewControllerAnimated:YES completion:nil];
        
 
    }
    
    - (void)targetImage:(UIImage *)image
didFinishSavingWithError:(NSError *)error
contextInfo:(void *)context
    {
        if (error) {
            NSLog(" ");
           } else {
            // 保存成功時の処理
        }
}
}

@end
