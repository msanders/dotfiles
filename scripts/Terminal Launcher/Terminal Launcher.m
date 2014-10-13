#include <Carbon/Carbon.h>
#import <AppKit/AppKit.h>

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef event, void *info)
{
    BOOL success = [[NSWorkspace sharedWorkspace] launchApplication:@"Terminal"];
    return success ? noErr : 1;
}

int main(void)
{
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    InstallApplicationEventHandler(
        &hotKeyHandler,
        1,
        &eventType,
        NULL,
        NULL
    );

    EventHotKeyRef hotKeyRef;
    EventHotKeyID hotKeyID;
    hotKeyID.signature = 0;
    hotKeyID.id = 1;

    RegisterEventHotKey(
        kVK_Space,
        optionKey,
        hotKeyID,
        GetEventDispatcherTarget(),
        0,
        &hotKeyRef
    );

    [[NSApplication sharedApplication] run];
    return 0;
}
