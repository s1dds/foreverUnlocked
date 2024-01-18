#import "SBMesaUnlockTrigger.h"

@interface SBHomeButtonPressMesaUnlockTrigger : SBMesaUnlockTrigger
{
    BOOL _menuButtonDown;
    BOOL _primed;
}

- (void)menuButtonUp;
- (void)menuButtonDown;
- (void)significantUserInteractionOccurred;
- (void)screenOff;
- (BOOL)bioUnlock;
- (id)succinctDescriptionBuilder;
- (id)description;
- (void)unlock;
@end