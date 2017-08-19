#  Question 1

__Write a function which takes a string as argument and returns the string reversed. For example, "abcdef" becomes "fedcba". Do not use the reverse method. Does it work with emojis?__

## Answer

```
- (NSMutableString *)mutableReversed {
    NSMutableString *mutable = [[NSMutableString alloc] initWithCapacity:self.length];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (substring) {
            [mutable appendString:substring];
        }
    }];
    return mutable;
}
```

Yes, it works with any Unicode sequece, including emojis.
