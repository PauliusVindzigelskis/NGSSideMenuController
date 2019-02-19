//
//  NGSSideMenuItemAction.m
//  DoodleDraw
//
//  Created by Vindziukai on 02/06/2017.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "NGSSideMenuItemAction.h"
#import <Masonry/Masonry.h>

@interface NGSSideMenuItemAction()

@property (nonatomic, copy, nullable) NGSItemHandler handler;

@end

@implementation NGSSideMenuItemAction

+ (instancetype) actionWithTitle:(nullable NSString *)title
                           image:(nullable UIImage *)image
                            size:(CGSize)size
                         handler:(nullable NGSItemHandler)handler
{
    NGSSideMenuItemAction *action = [NGSSideMenuItemAction buttonWithType:UIButtonTypeCustom];
    [action setImage:image forState:UIControlStateNormal];
    [action setTitle:title forState:UIControlStateNormal];
    action.handler = handler;
    
    [action setupSize:size];
    [action layoutIfNeeded];
    
    if (handler)
    {
        [action addTarget:action action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return action;
}
    
- (void) action
{
    if (self.handler)
    {
        self.handler(self);
    }
}

- (void) setupSize:(CGSize)s
{
    if (!CGSizeEqualToSize(s, CGSizeZero))
    {
        CGSize copySize = s;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(copySize.width));
            make.height.equalTo(@(copySize.height));
        }];
        [self sizeToFit];
        _size = s;
    } else {
        _size = self.intrinsicContentSize;
    }
}
    
- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}
    
@end
