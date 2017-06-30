//
//  GuidancePageImageCell.m
//  ShareView
//
//  Created by dxs on 2017/6/7.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "GuidancePageImageCell.h"

@implementation GuidancePageImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end

