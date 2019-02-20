//
//  NGSSideMenu.h
//  DoodleDraw
//
//  Created by Vindziukai on 02/06/2017.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGSSideMenuItem.h"
#import "NGSSideMenuItemAction.h"

typedef NS_ENUM(NSUInteger, NGSSideMenuPosition)
{
    NGSSideMenuPositionLeft     = 0,
    NGSSideMenuPositionTop      = 1,
    NGSSideMenuPositionRight    = 2,
    NGSSideMenuPositionBottom   = 3
};

@interface NGSSideMenuController : NSObject

@property (nonatomic, strong, readonly) NSArray<UIView<NGSSideMenuItem>*> *items;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) NGSSideMenuPosition position;
@property (nonatomic, assign) NSTimeInterval interItemShowDelay;
    @property (nonatomic, weak) UIView* presentingView;
    @property (nonatomic, assign) CGFloat startOffset;
@property (nonatomic, assign) CGFloat dampingMultiplier;
@property (nonatomic, assign) NSTimeInterval showAnimationDuration;
@property (nonatomic, assign) NSTimeInterval hideAnimationDuration;
@property (nonatomic, assign) UIViewAnimationOptions showAnimationOptions;
@property (nonatomic, assign) UIViewAnimationOptions hideAnimationOptions;
    
- (NSArray<UIView<NGSSideMenuItem>*>*) presentedItems;
- (void) addItem:(UIView<NGSSideMenuItem>*)item;

- (void) showItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated;
- (void) showAllAnimated:(BOOL)animated;

- (void) hideItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated;
- (void) hideAllAnimated:(BOOL)animated;
- (void) hideAllExceptItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated;

@end
