#  Question 2

__Explain what happens when the following code is executed (ARC being disabled in the compiler):__

`MyClass *myClass = [[[[MyClass alloc] init] autorelease] autorelease];`

## Answer

First, myClass is retained on `init`. Later, it's added twice to the autorelease pool, so when the pool is drained at the end of the event loop, it gets deallocated twice, leading to a crash.

Currently, some cases don't lead to a crash, like `NSString` in the example, because you get a singleton instead of a normal instance, so it never gets deallocated.
