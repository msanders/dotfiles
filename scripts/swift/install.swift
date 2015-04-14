import Darwin
import Foundation.NSError

func findModules(dir: String) -> Result<[String]> {
    let excludedDirs = ["lib"]
    let fm = NSFileManager.defaultManager()
    var error: NSError?
    return Result(
        fm.contentsOfDirectoryAtPath(dir, error:&error) as? [String],
        error
    ) . map { paths in paths.filter {
        path in Script.isDir(path) && !contains(excludedDirs, path)
    } }
}

func compileModule(module: String, outDir: String) -> Result<String> {
    let dirname = Script.dirname.collapseUser
    let outPath = outDir.joinPath(module)
    let imports = "\(dirname)/lib/lib.swift " +
                  "\(dirname)/lib/lib.*.swift " + 
                  "\(dirname)/\(module)/*.swift"
    let options = "-O -module-name \(module) -o \(outPath)"
    let cmd = "xcrun swiftc \(imports) \(options)"
	return Shell.system(cmd, glob: true) . map { _ in outPath }
}

func compileModules(modules: [String], outDir: String) -> Result<[String]> {
    var values: [String] = []
    for module in modules {
        switch compileModule(module, outDir) {
            case let .Success(value):
                values.append(value.unbox)
            case let .Error(error):
                return .Error(error)
        }
    }

    return .Success(Box(values))
}

func main() {
	let outdir = Script.makeDirs("~/bin".expandUser)
    switch findModules(Script.dirname).zip(outdir) >>- compileModules {
        case let .Success(results):
            let modules = results.unbox.map { $0.lastPathComponent }
            let delimeter = modules.count > 1 ? "& " : ""
            let formatted = join(", ", modules[0..<modules.count - 1]) +
                            delimeter +
                            modules[modules.count - 1]
            let suffix = modules.count == 1 ? "" : "s"
            println("Installed \(formatted) module\(suffix).")
        case let .Error(error):
            Shell.fail("Error: \(error.localizedDescription)")
    }
}

main()
