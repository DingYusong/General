//
//  GeneralConst.h
//  Pods
//
//  Created by 丁玉松 on 15/7/21.
//
//

#ifndef Pods_GeneralConst_h
#define Pods_GeneralConst_h

//获取物理设备的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取物理设备的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenViewHeight (ScreenHeight-64)


#define VERSION_iOS [[[UIDevice currentDevice] systemVersion] floatValue]
#define VERSION_APP [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#endif
