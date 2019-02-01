import Foundation

public protocol Identifiable {
    var identifier: UUID { get }
}

extension Array where Element: Identifiable {
    public subscript(identifier: UUID) -> Array.Element? {
        get {
            return first { $0.identifier == identifier }
        }
        set {
            if let index = index(where: { $0.identifier == identifier }), let element = newValue {
                self[index] = element
            }
        }

    }
}
