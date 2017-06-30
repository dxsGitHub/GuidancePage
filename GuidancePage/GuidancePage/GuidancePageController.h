//
//  GuidancePageController.h
//  ShareView
//
//  Created by dxs on 2017/6/7.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ENTER_SCROLL,
    ENTER_CLICK,
} EnterInStyle;

@interface GuidancePageController : UIViewController

@property (nonatomic, copy) dispatch_block_t hiddeGuidanceWindow;

- (instancetype)initPagesButtonImageWithArray:(NSArray *)array enterStyle:(EnterInStyle)style;

//- (instancetype)initPagesImageArray:(NSArray *)array enterButtonImageName:(NSString *)btnName;

@end

