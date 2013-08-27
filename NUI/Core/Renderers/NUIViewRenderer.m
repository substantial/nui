//
//  NUIViewRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUIViewRenderer.h"

@implementation NUIViewRenderer

+ (void)render:(UIView*)view withClass:(NSString*)className
{
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        [view setBackgroundColor: [NUISettings getColorFromImage:@"background-image" withClass: className]];
    } else if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        [view setBackgroundColor: [NUISettings getColor:@"background-color" withClass: className]];
    }

    [self renderSize:view withClass:className];
    [self renderBorder:view withClass:className];
    [self renderShadow:view withClass:className];
}

+ (void)renderBorder:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"border-color" withClass:className]) {
        [layer setBorderColor:[[NUISettings getColor:@"border-color" withClass:className] CGColor]];
    }
    
    if ([NUISettings hasProperty:@"border-width" withClass:className]) {
        [layer setBorderWidth:[NUISettings getFloat:@"border-width" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"corner-radius" withClass:className]) {
        [layer setCornerRadius:[NUISettings getFloat:@"corner-radius" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"border-top-color" withClass:className]
        && [NUISettings hasProperty:@"border-top-width" withClass:className]) {
        CGFloat width = [NUISettings getFloat:@"border-top-width" withClass:className];
        CGRect frame = CGRectMake(0.0f, 0.0f, view.frame.size.width, width);
        [NUIViewRenderer drawBorderWithFrame:frame colorClass:@"border-top-color" view:view className:className];        
    };

    if ([NUISettings hasProperty:@"border-left-color" withClass:className]
        && [NUISettings hasProperty:@"border-left-width" withClass:className]) {
        CGFloat width = [NUISettings getFloat:@"border-left-width" withClass:className];
        CGRect frame = CGRectMake(0.0f, 0.0f, width, view.frame.size.height);
        [NUIViewRenderer drawBorderWithFrame:frame colorClass:@"border-left-color" view:view className:className];
    };
    
    if ([NUISettings hasProperty:@"border-bottom-color" withClass:className]
        && [NUISettings hasProperty:@"border-bottom-width" withClass:className]) {
        CGFloat width = [NUISettings getFloat:@"border-bottom-width" withClass:className];
        CGRect frame = CGRectMake(0.0f, view.frame.size.height - width, view.frame.size.width, width);
        [NUIViewRenderer drawBorderWithFrame:frame colorClass:@"border-bottom-color" view:view className:className];
    };

    if ([NUISettings hasProperty:@"border-right-color" withClass:className]
        && [NUISettings hasProperty:@"border-right-width" withClass:className]) {
        CGFloat width = [NUISettings getFloat:@"border-right-width" withClass:className];
        CGRect frame = CGRectMake(view.frame.size.width - width, 0.0f, width, view.frame.size.height);
        [NUIViewRenderer drawBorderWithFrame:frame colorClass:@"border-right-color" view:view className:className];
    };
}

+ (void)drawBorderWithFrame:(CGRect)frame colorClass:(NSString *)colorClass view:(UIView *)view className:(NSString *)className
{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    border.backgroundColor = [NUISettings getColor:colorClass withClass:className].CGColor;
    
    [view.layer addSublayer:border];
}

+ (void)renderShadow:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"shadow-radius" withClass:className]) {
        [layer setShadowRadius:[NUISettings getFloat:@"shadow-radius" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-offset" withClass:className]) {
        [layer setShadowOffset:[NUISettings getSize:@"shadow-offset" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-color" withClass:className]) {
        [layer setShadowColor:[NUISettings getColor:@"shadow-color" withClass:className].CGColor];
    }
    
    if ([NUISettings hasProperty:@"shadow-opacity" withClass:className]) {
        [layer setShadowOpacity:[NUISettings getFloat:@"shadow-opacity" withClass:className]];
    }
}

+ (void)renderSize:(UIView*)view withClass:(NSString*)className
{
    CGFloat height = view.frame.size.height;
    if ([NUISettings hasProperty:@"height" withClass:className]) {
        height = [NUISettings getFloat:@"height" withClass:className];
    }
    
    CGFloat width = view.frame.size.width;
    if ([NUISettings hasProperty:@"width" withClass:className]) {
        width = [NUISettings getFloat:@"width" withClass:className];
    }

    if (height != view.frame.size.height || width != view.frame.size.width) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, height);
    }
}

@end
