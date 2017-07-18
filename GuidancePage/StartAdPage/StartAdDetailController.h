//
//  StartAdDetailController.h
//  GuidancePage
//
//  Created by dxs on 2017/7/18.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartAdDetailController : UIViewController

@property (strong, nonatomic) NSString *adUrlString;

@property (nonatomic, copy) dispatch_block_t backClickBlock;

- (void)showAdDetailView;

@end
