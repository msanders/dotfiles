import Darwin

struct Script {
    static var ErrorDomain = "com.msanders.lib.sh.errordomain"

    static func dirname() -> String {
        let fm = NSFileManager.defaultManager()
        let arg0 = Process.arguments[0]
        return fm.currentDirectoryPath.joinPath(arg0).normPath().dirname()
    }

    static func isDir(path: String) -> Bool {
        let fm = NSFileManager.defaultManager()
        var isDir: ObjCBool = ObjCBool(false)
        return fm.fileExistsAtPath(path, isDirectory:&isDir) && isDir
    }

    static func makeDirs(path: String) -> NSError? {
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        return fm.createDirectoryAtPath(path,
                                        withIntermediateDirectories:true,
                                        attributes:nil,
                                        error:&error) ? nil : error
    }

    static func error(msg: String, code: Int = 1) -> NSError {
        return NSError(domain:ErrorDomain, code:code, userInfo:[
            NSLocalizedDescriptionKey: msg
        ])
    }
}

struct Shell {
    static func subprocess(components: [String]) -> Int {
        let task = NSTask()
        task.launchPath = "/usr/bin/env"
        task.arguments = components
        task.launch()
        task.waitUntilExit()
        return Int(task.terminationStatus)
    }

    static func system(cmd: String, glob: Bool = false) -> Int {
        return subprocess(
            glob ? ["sh", "-c", cmd] : cmd.componentsSeparatedByString(" ")
        )
    }

    static func fail(msg: String, code: Int = 1) {
        println(msg, &stderr)
        exit(Int32(code))
    }
}
