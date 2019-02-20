//
//  NGSSideMenu.m
//  DoodleDraw
//
//  Created by Vindziukai on 02/06/2017.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "NGSSideMenuController.h"
#import <Masonry/Masonry.h>

@interface NGSSideMenuController()

@property (nonatomic, strong, readwrite) NSMutableArray<UIView<NGSSideMenuItem>*> *items;
@property (nonatomic, strong, readwrite) NSMutableDictionary <UIView<NGSSideMenuItem>*, MASConstraint*> *sideConstraints;

@end

@implementation NGSSideMenuController

- (id)init
{
    self = [super init];
    if (self)
    {
        _sideConstraints = [NSMutableDictionary dictionary];
        _items = [NSMutableArray array];
        _interItemShowDelay = 0.3f;
        _itemSpacing = 0.f;
        _position = NGSSideMenuPositionLeft;
        _startOffset = 0.f;
    } return self;
}
    
- (NSArray<UIView<NGSSideMenuItem>*>*) presentedItems
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView* view in self.items)
    {
        if (view.superview)
        {
            [array addObject:view];
        }
    }
    
    return [array copy];
}

-(void)addItem:(UIView<NGSSideMenuItem>*)item
{
    [_items addObject:item];
}

-(void)showItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated
{
    // public
    CGFloat offset = _startOffset;
    NSInteger index = [self.items indexOfObject:item];
    
    if (index == NSNotFound)
    {
        NSAssert(NO, @"Add item before showing");
        index = self.items.count;
        [self addItem:item];
    }
    
    for (int i = 0; i < index; i++)
    {
        UIView<NGSSideMenuItem>*item = self.items[i];
        offset += item.size.height + _itemSpacing;
    }
        
    [self showItem:item offset:offset animated:animated];
}

-(void)showAllAnimated:(BOOL)animated
{
    __block UIView<NGSSideMenuItem>*previousView = nil;
    [self doStuffWithObjects:self.items interDelay:self.interItemShowDelay handler:^(UIView<NGSSideMenuItem>*obj)
    {
        CGFloat offset = [self startOffsetForItem:obj previousItem:previousView];
        [self showItem:obj offset:offset animated:animated];
        previousView = obj;
    }];
}

-(void)hideItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated
{
    MASConstraint *rightConstraint = self.sideConstraints[item];
    void (^animations)() = ^() {
        [rightConstraint setOffset:0];
        [item layoutIfNeeded];
        [self.presentingView layoutIfNeeded];
    };
    void (^completion)(BOOL) = ^(BOOL finished) {
        [item removeFromSuperview];
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3 animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
    
}

-(void)hideAllAnimated:(BOOL)animated
{
    [self doStuffWithObjects:self.presentedItems interDelay:self.interItemShowDelay handler:^(id obj) {
        [self hideItem:obj animated:animated];
    }];
}

-(void)hideAllExceptItem:(UIView<NGSSideMenuItem>*)item animated:(BOOL)animated
{
    NSArray *array = [self.presentedItems filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject != item;
    }]];
    
    [self doStuffWithObjects:array interDelay:0 handler:^(id obj) {
        [self hideItem:obj animated:YES];
    }];
}
    
#pragma mark - Internal
    
-(void)showItem:(UIView<NGSSideMenuItem>*)item offset:(CGFloat)offset animated:(BOOL)animated
{
    if ([self presentingView])
    {
        [self.presentingView addSubview:item];
        
        MASConstraint *rightConstraint = [self setupConstraintsForItem:item offset:offset];
        
        self.sideConstraints[item] = rightConstraint;
        [item layoutIfNeeded];
        [self.presentingView layoutIfNeeded];
        CGFloat showingOffset = [self showingOffsetForItem:item];
        
        // Show up
        void (^animations)(void) = ^() {
            [rightConstraint setOffset:showingOffset];
            [item layoutIfNeeded];
            [self.presentingView layoutIfNeeded];
        };
        void (^completion)(BOOL) = ^(BOOL finished) {
            
        };
        
        if (animated)
        {
            [UIView animateWithDuration:0.3f animations:animations completion:completion];
        } else {
            animations();
            completion(YES);
        }
        
    } else {
        NSAssert(NO, @"Set presentingView property before showing items");
    }
}

#pragma mark - tools

- (nonnull MASConstraint*) setupConstraintsForItem:(UIView<NGSSideMenuItem>*)item offset:(CGFloat)offset
{
    MASConstraint *activeContraint = nil;
    
    switch (self.position) {
        case NGSSideMenuPositionLeft:
        {
            activeContraint = [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.presentingView.mas_left);
            }][0];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.presentingView).with.offset(offset);
            }];
            break;
        }
        
        case NGSSideMenuPositionTop:
        {
            activeContraint = [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.presentingView.mas_top);
            }][0];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.presentingView).with.offset(offset);
            }];
            break;
        }
        
        case NGSSideMenuPositionRight:
        {
            activeContraint = [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.presentingView.mas_right);
            }][0];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.presentingView).with.offset(offset);
            }];
            break;
        }
        
        case NGSSideMenuPositionBottom:
        {
            activeContraint = [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.presentingView.mas_bottom);
            }][0];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.presentingView).with.offset(offset);
            }];
            break;
        }
    }
    
    return activeContraint;
}
    
- (CGFloat) startOffsetForItem:(nonnull UIView<NGSSideMenuItem>*)item previousItem:(nullable UIView<NGSSideMenuItem>*) previousItem
    {
        switch (self.position) {
            case NGSSideMenuPositionLeft:
            case NGSSideMenuPositionRight:
            return previousItem ? previousItem.frame.origin.y + self.itemSpacing + previousItem.size.height : _startOffset;
            
            case NGSSideMenuPositionTop:
            case NGSSideMenuPositionBottom:
            return previousItem ? previousItem.frame.origin.x + self.itemSpacing + previousItem.size.width : _startOffset;
        }
    }
    
- (CGFloat) showingOffsetForItem:(UIView<NGSSideMenuItem>*)item
{
    switch (self.position) {
    case NGSSideMenuPositionLeft:
        return item.size.width;
        
    case NGSSideMenuPositionTop:
        return item.size.height;
        
    case NGSSideMenuPositionRight:
        return item.size.width * -1.f;
        
    case NGSSideMenuPositionBottom:
        return item.size.height * -1.f;
    }
}
    
- (void)doStuffWithObjects:(NSArray*)array interDelay:(NSTimeInterval)delay handler:(void (^)(id obj))handle
{
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        double delayInSeconds = delay * idx;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            handle(obj);
        });
        
        
    }];
}

@end
