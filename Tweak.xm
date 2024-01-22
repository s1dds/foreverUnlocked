#include <Foundation/Foundation.h>
#import <rootless.h>
#import "SBHomeButtonPressMesaUnlockTrigger.h"

@interface SBLockScreenManager
+ (id)sharedInstance;
- (BOOL)unlockUIFromSource:(int)arg1 withOptions:(id)arg2;
- (BOOL)_finishUIUnlockFromSource:(int)arg1 withOptions:(id)arg2;
@end

#define PREFERENCE_FILE ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.appknox.foreverUnlockedSettings.plist")
static BOOL shouldEnablekFromPreference();

%group LockManager 
%hook SBHomeButtonPressMesaUnlockTrigger
%new
- (void)unlock {
	NSDictionary *options = @{
		@"SBUIUnlockOptionsStartFadeInAnimation": @1,
		@"SBUIUnlockOptionsTurnOnScreenFirstKey": @1
	};

	NSDictionary *options2 = @{
		@"SBUIUnlockOptionsStartFadeInAnimation": @0,
		@"SBUIUnlockOptionsTurnOnScreenFirstKey": @0
	};
	
	[[%c(SBLockScreenManager) sharedInstance] unlockUIFromSource:13 withOptions:options];
	[[%c(SBLockScreenManager) sharedInstance] _finishUIUnlockFromSource:13 withOptions:options2];
}

- (void)screenOff {
	%orig;
	BOOL enabled = shouldEnablekFromPreference();
	if (enabled) {
		NSLog(@"[ForeverUnlocked] Overriding Device Lock!!"); 
		[self unlock];
	}
}
%end
%end

static BOOL shouldEnablekFromPreference() {
    BOOL shouldHook = YES;
    NSMutableDictionary* plist = [[NSMutableDictionary alloc] initWithContentsOfFile:PREFERENCE_FILE];
	if (!plist) {
		NSLog(@"[ForeverUnlocked] Preferences Plist Not Found");
	} else {
		shouldHook = [[plist objectForKey:@"shouldEnableForeverUnlocked"] boolValue];
	}

	return shouldHook;
}

%ctor {
	%init(LockManager);
	NSLog(@"[ForeverUnlocked] Ready!!");
}