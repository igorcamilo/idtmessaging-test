//
//  NSString+Reversed.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//
//

#import "NSString+Reversed.h"

@implementation NSString (Reversed)

- (NSString *)reversed {
    return [[self mutableReversed] copy];
}


- (NSMutableString *)mutableReversed {
    NSMutableString *mutable = [[NSMutableString alloc] initWithCapacity:self.length];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [mutable appendString:substring];
    }];
    return mutable;
}

@end
