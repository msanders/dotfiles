import Darwin

func makeOutDir() -> Result<String> {
    let outDir = "~/bin".expandUser()
    if let err = Script.makeDirs(outDir) {
        return .Error(err)
    } else {
        return .Success(outDir)
    }
}

func findModules(dir: String) -> Result<[String]> {
    let excludedDirs = ["lib"]
    let fm = NSFileManager.defaultManager()
    var error: NSError?
    return Result(
        fm.contentsOfDirectoryAtPath(dir, error:&error) as [String]?,
        error
    ) <^> { paths in paths.filter {
        path in Script.isDir(path) && !contains(excludedDirs, path)
    } }
}

func compileModule(module: String, outDir: String) -> Result<String> {
    let dirname = Script.dirname().collapseUser()
    let outPath = outDir.joinPath(module)
    let imports = "\(dirname)/lib/lib.swift " +
                  "\(dirname)/lib/lib.*.swift " + 
                  "\(dirname)/\(module)/*.swift"
    let options = "-O -module-name \(module) -o \(outPath)"
    let cmd = "xcrun swiftc \(imports) \(options)"
    let status = Shell.system(cmd, glob: true)
    return status == 0 ? Result.Success(outPath) : Result.Error(
        Script.error("`\(cmd)` failed with code \(status)")
    )
}

func compileModules(modules: [String], outDir: String) -> Result<[String]> {
    var values: [String] = []
    for module in modules {
        switch compileModule(module, outDir) {
            case let .Success(value):
                values.append(value())
            case let .Error(error):
                return .Error(error)
        }
    }

    return .Success(values)
}

func main() {
    switch findModules(Script.dirname()).combine(
        makeOutDir()
    ) >>- compileModules {
        case let .Success(results):
            let modules = results().map { $0.lastPathComponent }
            let delimeter = modules.count > 1 ? "& " : ""
            let formatted = join(", ", modules[0..<modules.count - 1]) +
                            delimeter +
                            modules[modules.count - 1]
            let suffix = modules.count == 1 ? "" : "s"
            println("Installed \(formatted) module\(suffix)")
        case let .Error(error):
            Shell.fail("Error: \(error.localizedDescription)")
    }
}

main()
