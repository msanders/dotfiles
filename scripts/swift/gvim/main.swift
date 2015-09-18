//
// This just adds the `--remote` flag when necessary so you don't get a
// jillion windows in MacVim.
//

import AppKit

struct MacVim {
    static private var appName = "MacVim"
    static private var bundleID = "org.vim.MacVim"
    static private var cliPath = "/Contents/MacOS/Vim"

    static func cli(appPath: String, args: [String]) {
        // NSTask doesn't seem to play nicely with vim (e.g. `gvim -v`)
        let launchPath = appPath.joinPath(self.cliPath)
        let escaped = args.map { arg in arg.shellescape }
        system(launchPath + " " + escaped.joinWithSeparator(" "))
    }

    static func installationPath() -> String? {
        let workspace = NSWorkspace.sharedWorkspace()
        return workspace.fullPathForApplication(self.appName)
    }

    static func findActive() -> NSRunningApplication? {
        let workspace = NSWorkspace.sharedWorkspace()
        let runningApps = workspace.runningApplications
        return runningApps.filter({
            app in app.bundleIdentifier == self.bundleID
        }).first
    }

    static func windows(pid: Int) -> [[String: AnyObject]] {
        let windows = CGWindowListCopyWindowInfo(CGWindowListOption(rawValue: 16), 0) as?
            [[String: AnyObject]] ?? []
        return windows.filter({entry in
            let ownerPID = entry[kCGWindowOwnerPID as String] as? Int
            let bounds = entry[kCGWindowBounds as String] as? [String: Float]
            return ownerPID == pid && bounds?["Y"] > 22
        })
    }

    static func activeWithWindows() -> Bool {
        if let app = self.findActive() {
            return self.windows(Int(app.processIdentifier)).count > 0
        } else {
            return false
        }
    }
}

func main() {
    if Process.arguments.count == 1 {
        NSWorkspace.sharedWorkspace().launchApplication("MacVim")
    } else if let appPath = MacVim.installationPath() {
        var args = ["-g"]
        let cliFlags = Process.arguments.filter({ arg in arg.hasPrefix("-") })

        args += cliFlags.count == 0 && MacVim.activeWithWindows() ? ["--remote"] : []
        args += Process.arguments[1..<Process.arguments.count]
        MacVim.cli(appPath, args: args)
    } else {
        Shell.fail("MacVim not installed")
    }
}

main()
