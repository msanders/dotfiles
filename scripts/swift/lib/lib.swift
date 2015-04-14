@exported import Foundation

public class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

public enum Result<T> {
    case Success(Box<T>)
    case Error(NSError)

    init(_ value: T?, _ error: NSError?) {
        if let val = value {
            self = .Success(Box(val))
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
                return .Success(Box(f(value.unbox)))
            case let .Error(error):
                return .Error(error)
        }
    }

    func flatMap<U>(f: T -> Result<U>) -> Result<U> {
        switch self {
            case let .Success(value):
                return f(value.unbox)
            case let .Error(error):
                return .Error(error)
        }
    }

    func zip<U>(b: Result<U>) -> Result<(T, U)> {
        return self.flatMap {
            a in b.map { (a, $0) }
        }
    }

    static func flatten<T>(results: [Result<T>]) -> Result<[T]> {
        var values: [T] = []
        for result in results {
            switch result {
                case let .Success(value):
                    values.append(value.unbox)
                case let .Error(error):
                    return .Error(error)
            }
        }

        return .Success(Box(values))
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

    func replace(
        pattern: String,
        _ replacement: String,
        options: NSStringCompareOptions = nil
    ) -> String {
        let str: NSString = self
        return str.stringByReplacingOccurrencesOfString(
            pattern,
            withString: replacement,
            options: options,
            range: NSRange(location: 0, length: count(self))
        )
    }

    var normPath: String {
        return self.stringByStandardizingPath
    }

    var dirname: String {
        return self.stringByDeletingLastPathComponent
    }

    var expandUser: String {
        return self.stringByExpandingTildeInPath
    }

    var collapseUser: String {
        return self.stringByAbbreviatingWithTildeInPath
    }

    // Adopted from Python's pipe.escape().
    var shellescape: String {
        // An empty argument will be skipped, so return empty quotes.
        if count(self) == 0 {
            return "''"
        }

        // Use single quotes, and put single quotes into double quotes.
        // So the string $'b is then quoted as '$'"'"'b'.
        let replaced = self.replace("'", "'\"'\"'")
        return "'\(replaced)'"
    }
}
