//
//  UploadPhoto.h
//  weal
//
//  Created by ding on 15/11/26.
//  Copyright © 2015年 ding. All rights reserved.
//

#import "BaseControl.h"

@interface UploadPhoto : BaseControl{
    UIImageView *contentImageView;
    NSString *lastChosenMediaType;
}

@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadPhotoButton;
@property(nonatomic,copy)              NSString *lastChosenMediaType;

@property (strong,nonatomic) NSString *UPFullPath;
@property (strong,nonatomic) UIImage *UPImage;
@property (assign, nonatomic) User* userUploadPhoto;//当前登录用户

@end
