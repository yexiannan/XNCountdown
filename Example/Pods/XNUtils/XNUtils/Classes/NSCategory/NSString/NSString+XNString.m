//
//  NSString+XNString.m
//  Caiyicai
//
//  Created by apple on 2019/1/18.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "NSString+XNString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XNString)
+ (BOOL)stringIsNull:(id)string{
    if ([string isKindOfClass:[NSString class]]) {
        if (string && ![string isKindOfClass:[NSNull class]]) {
            if (![@"<null>" isEqualToString:string] && ![@"" isEqualToString:string] && ![@"null" isEqualToString:string] && ![@"nil" isEqualToString:string]) {
                return NO;
            }
        }
    }
    return YES;
}

+ (BOOL)stringIsCorrect:(NSString *)string Set:(NSCharacterSet *)set{
    if (![self stringIsNull:string]) {
        if ([[string stringByTrimmingCharactersInSet:set] length] == string.length) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+ (CGSize)getSizeWithString:(NSString *)aStr withFont:(UIFont *)font LimitWidth:(CGFloat)aLimitWidth{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize stringSize = [aStr boundingRectWithSize:CGSizeMake(aLimitWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return stringSize;
}

- (NSString *)md5String{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

@end
