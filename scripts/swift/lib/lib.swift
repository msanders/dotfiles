@exported import Foundation

extension String {
    func joinPath(path: String) -> String {
        return NSURL(string: self)?.URLByAppendingPathComponent(path).absoluteString ?? ""
    }

    func replace(
        pattern: String,
        _ replacement: String,
        options: NSStringCompareOptions = NSStringCompareOptions()
    ) -> String {
        let str: NSString = self
        return str.stringByReplacingOccurrencesOfString(
            pattern,
            withString: replacement,
            options: options,
            range: NSRange(location: 0, length: self.characters.count)
        )
    }

    var normPath: String {
        return NSURL(string: self)?.URLByStandardizingPath?.absoluteString ?? ""
    }

    var dirname: String {
        return NSURL(string: self)?.URLByDeletingLastPathComponent?.absoluteString ?? ""
    }

    var expandUser: String {
        return NSString(string: self).stringByExpandingTildeInPath
    }

    var collapseUser: String {
        return NSString(string: self).stringByAbbreviatingWithTildeInPath
    }

    // Adopted from Python's pipe.escape().
    var shellescape: String {
        // An empty argument will be skipped, so return empty quotes.
        if self.characters.count == 0 {
            return "''"
        }

        // Use single quotes, and put single quotes into double quotes.
        // So the string $'b is then quoted as '$'"'"'b'.
        let replaced = self.replace("'", "'\"'\"'")
        return "'\(replaced)'"
    }
}
