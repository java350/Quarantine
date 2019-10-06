//
//  Optional+Extensions.swift

import Foundation
import CoreGraphics

func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

extension Optional where Wrapped == String {
    var `default`: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var `default`: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == CGFloat {
    var `default`: CGFloat {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Double {
    var `default`: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Bool {
    var `default`: Bool {
        return self ?? true
    }
}

extension Optional where Wrapped == Date {
    var `default`: Date {
        return self ?? Date()
    }
}

extension Optional {
    var isEmpty: Bool {
        return self == nil
    }
}
