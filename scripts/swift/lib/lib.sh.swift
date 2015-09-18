import Darwin

public class StandardErrorOutputStream: OutputStreamType {
    public func write(string: String) {
        let stream = NSFileHandle.fileHandleWithStandardError()
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            stream.writeData(data)
        }
    }
}

public var stderr = StandardErrorOutputStream()

public struct Script {
    static var ErrorDomain = "com.msanders.lib.sh.errordomain"

    static var dirname: String {
        let fm = NSFileManager.defaultManager()
        let arg0 = Process.arguments[0]
        return fm.currentDirectoryPath.joinPath(arg0).normPath.dirname
    }

    static func isDir(path: String) -> Bool {
        let fm = NSFileManager.defaultManager()
        var isDir: ObjCBool = ObjCBool(false)
        return fm.fileExistsAtPath(path, isDirectory:&isDir) && isDir
    }

    static func makeDirs(path: String) throws -> String {
        let fm = NSFileManager.defaultManager()
        try fm.createDirectoryAtPath(path, withIntermediateDirectories:true, attributes:nil)
        return path
    }

    static func error(msg: String, code: Int = 1) -> NSError {
        return NSError(domain:ErrorDomain, code:code, userInfo:[
            NSLocalizedDescriptionKey: msg
        ])
    }
}

public struct Shell {
    static func subprocess(components: [String]) throws -> String {
        let task = NSTask()
        let outPipe = NSPipe()
        task.launchPath = "/usr/bin/env"
        task.arguments = components
        task.standardOutput = outPipe
        task.launch()
        task.waitUntilExit()
        let data = outPipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data:data, encoding:NSUTF8StringEncoding) ?? ""
        let code = Int(task.terminationStatus)
		let cmd = components.joinWithSeparator(" ")
        if code != 0 {
           throw Script.error("`\(cmd)` failed with code \(code)")
        }

        return output as String
    }

    static func system(cmd: String, glob: Bool = false) throws -> String {
        return try subprocess(
            glob ? ["sh", "-c", cmd] : cmd.componentsSeparatedByString(" ")
        )
    }

    static func fail(msg: String, code: Int = 1) {
        print(msg, toStream: &stderr)
        exit(Int32(code))
    }

    static func getpass(prompt: String) -> String? {
        if let pw = String(UTF8String: Darwin.getpass(prompt)) {
            return pw.characters.count > 0 ? pw : nil
        }

        return nil
    }
}
