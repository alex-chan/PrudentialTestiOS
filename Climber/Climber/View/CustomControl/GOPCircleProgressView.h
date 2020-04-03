//
//  GOPCircleProgressView.h
//  BleLocker
//
//  Created by Alex Chan on 2019/3/15.
//  Copyright © 2019 北京果加智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface GOPCircleProgressView : UIView


@property (nonatomic, assign) NSUInteger progress;

@property (nonatomic) IBInspectable UIColor *progressColor;
@property (nonatomic) IBInspectable UIColor *progressBgColor;
@property (nonatomic) IBInspectable NSUInteger progressWidth;


@end

NS_ASSUME_NONNULL_END
