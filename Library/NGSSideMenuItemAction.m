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
                         handler:(nullable NGSItemHandler)handler
{
    NGSSideMenuItemAction *action = [NGSSideMenuItemAction buttonWithType:UIButtonTypeCustom];
    [action setImage:image forState:UIControlStateNormal];
    [action setTitle:title forState:UIControlStateNormal];
    action.handler = handler;
    [action setupSize];
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

- (void) setupSize
{
    _size = self.intrinsicContentSize;
}
    
- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}
    
@end
