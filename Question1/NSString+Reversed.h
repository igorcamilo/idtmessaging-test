//
//  NSString+Reversed.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Reversed)

/**
 Reverse the characters, with support to Unicode character sequences.
 
 @return A new string, with reversed characters.
 */
- (NSString *)reversed;

/**
 Reverse the characters, with support to Unicode character sequences.
 
 @return A new mutable string, with reversed characters.
 */
- (NSMutableString *)mutableReversed;

@end
