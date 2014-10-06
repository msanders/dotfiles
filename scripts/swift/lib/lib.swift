@exported import Foundation

public class StandardErrorOutputStream: OutputStreamType {
    public func write(string: String) {
        let stream = NSFileHandle.fileHandleWithStandardError()
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            stream.writeData(data)
        }
    }
}

public var stderr = StandardErrorOutputStream()

public enum Result<T> {
    case Success(@autoclosure() -> T)
    case Error(NSError)

    init(_ value: T?, _ error: NSError?) {
        if let val = value {
            self = .Success(val)
        } else {
            if (error == nil) {
                assertionFailure("Missing both error and value")
            }
            self = .Error(error!)
        }
    }

    func map<U>(f: T -> U) -> Result<U> {
        switch self {
            case let .Success(value):
                return .Success(f(value()))
            case let .Error(error):
                return .Error(error)
        }
    }

    func flatMap<U>(f: T -> Result<U>) -> Result<U> {
        switch self {
            case let .Success(value):
                return f(value())
            case let .Error(error):
                return .Error(error)
        }
    }

    func combine<U>(b: Result<U>) -> Result<(T, U)> {
        return self.flatMap { 
            a in b.map { (a, $0) } 
        }
    }

    static func flatten<T>(results: [Result<T>]) -> Result<[T]> {
        var values: [T] = []
        for result in results {
            switch result {
                case let .Success(value):
                    values.append(value())
                case let .Error(error):
                    return .Error(error)
            }
        }

        return .Success(values)
    }
}

infix operator >>- {
    associativity left
}

// Bind (>>= is already used for bitshifting)
func >>-<T, NT>(result: Result<T>, next: T -> Result<NT>) -> Result<NT> {
    return result.flatMap(next)
}

infix operator <^> {
    associativity left
}

// Apply
func <^><T, NT>(result: Result<T>, next: T -> NT) -> Result<NT> {
    return result.map(next)
}

extension String {
    func joinPath(path: String) -> String {
        return self.stringByAppendingPathComponent(path)
    }

    func normPath() -> String {
        return self.stringByStandardizingPath
    }

    func dirname() -> String {
        return self.stringByDeletingLastPathComponent
    }

    func expandUser() -> String {
        return self.stringByExpandingTildeInPath
    }

    func collapseUser() -> String {
        return self.stringByAbbreviatingWithTildeInPath
    }
}
