/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#ifdef USE_TI_UILABEL

#import "TiUILabelProxy.h"
#import "TiUILabel.h"
#import "TiUtils.h"

@implementation TiUILabelProxy

USE_VIEW_FOR_CONTENT_WIDTH
USE_VIEW_FOR_CONTENT_HEIGHT

-(NSString*)apiName
{
    return @"Ti.UI.Label";
}

-(void)_initWithProperties:(NSDictionary *)properties
{
    [super _initWithProperties:properties];
}

-(CGFloat) verifyWidth:(CGFloat)suggestedWidth
{
	int width = ceil(suggestedWidth);
	if (width & 0x01)
	{
		width ++;
	}
	return width;
}

-(id)heightFromWidth:(id)args
{
   	CGFloat suggestedWidth = [TiUtils floatValue:[args objectAtIndex:0]];
    NSString *value = [TiUtils stringValue:[self valueForKey:@"text"]];
   	id fontValue = [self valueForKey:@"font"];
    UIFont *font = nil;
   	if (fontValue!=nil)
    {
        font = [[TiUtils fontValue:[self valueForKey:@"font"]] font];
    }
    else
    {
        font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    }
	CGSize maxSize = CGSizeMake(suggestedWidth, 10000);
	CGSize size = [value sizeWithFont:font constrainedToSize:maxSize];
	return [NSNumber numberWithFloat:size.height];
}


-(CGFloat) verifyHeight:(CGFloat)suggestedHeight
{
	int height = ceil(suggestedHeight);
    if ([self viewInitialized]) {
        int minHeight = ceil([[[(TiUILabel*)view label] font] lineHeight]);
        if (height < minHeight) {
            height = minHeight;
        }
    }
    
	if (height & 0x01)
	{
		height ++;
	}
	return height;
}

-(NSArray *)keySequence
{
	static NSArray *labelKeySequence = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		labelKeySequence = [[NSArray arrayWithObjects:@"font",nil] retain];
	});
	return labelKeySequence;
}

-(NSMutableDictionary*)langConversionTable
{
    return [NSMutableDictionary dictionaryWithObject:@"text" forKey:@"textid"];
}

-(TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoSize;
}
-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoSize;
}

-(UIView *)parentViewForChild:(TiViewProxy *)child
{
	return [[(TiUILabel*)[self view] label] superview];
}

@end

#endif