/**
 * Compile with: $CC "Terminal Launcher".m -o "Terminal Launcher" -Os -Wall -framework Carbon -framework ApplicationServices -framework AppKit
 */
#include <Carbon/Carbon.h>
#include <AppKit/AppKit.h>
#include <ApplicationServices/ApplicationServices.h>

static NSString * const kAppName = @"Terminal";
static LSApplicationParameters AppParams = {0, kLSLaunchDefaults, NULL};

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef event, void *info)
{
    return LSOpenApplication(&AppParams, NULL);
}

int main(void)
{
    FSRef appRef;
    NSString *appPath = [[NSWorkspace sharedWorkspace] fullPathForApplication:kAppName];
    if (FSPathMakeRef((const UInt8 *)[appPath UTF8String], &appRef, NULL) == noErr) {
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
            GetApplicationEventTarget(),
            0,
          &hotKeyRef
        );

        AppParams.application = &appRef;
    } else {
        NSLog(@"Couldn't find path to application: %@", appPath);
        return EXIT_FAILURE;
    }

    RunApplicationEventLoop();

    return EXIT_SUCCESS;
}
