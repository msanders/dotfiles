import Darwin
import Foundation.NSError

func findModules(dir: String) throws -> [String] {
    let excludedDirs = ["lib"]
    let fm = NSFileManager.defaultManager()
    let contents = try fm.contentsOfDirectoryAtPath(dir)
    return contents.filter {
        path in Script.isDir(path) && !excludedDirs.contains(path)
    }
}

func compileModule(module: String, outDir: String) throws -> String {
    let dirname = Script.dirname.collapseUser
    let outPath = outDir.joinPath(module)
    let imports = "\(dirname)/lib/lib.swift " +
                  "\(dirname)/lib/lib.*.swift " + 
                  "\(dirname)/\(module)/*.swift"
    let options = "-O -module-name \(module) -o \(outPath)"
    let cmd = "xcrun swiftc \(imports) \(options)"
	try Shell.system(cmd, glob: true)
    return outPath
}

func compileModules(modules: [String], outDir: String) throws -> [String] {
    var values: [String] = []
    for module in modules {
        let value = try compileModule(module, outDir: outDir)
        values.append(value)
    }

    return values
}

func main() {
    do {
        let results = try compileModules(findModules(Script.dirname), 
                                         outDir: Script.makeDirs("~/bin".expandUser))
        let modules = results.map { NSURL(string: $0)?.lastPathComponent ?? "" }
        let delimeter = modules.count > 1 ? "& " : ""
        let formatted = modules[0..<modules.count - 1].joinWithSeparator(", ") +
                        delimeter +
                        modules[modules.count - 1]
        let suffix = modules.count == 1 ? "" : "s"
        print("Installed \(formatted) module\(suffix).")
    } catch {
        Shell.fail("Error: \(error)")
    }
}

main()
