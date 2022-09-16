import Foundation

@propertyWrapper
public final class SGSerializable<Value> {
    public var wrappedValue: Value
    public var name: String?
    internal var type: CodableType
    
    public enum CodableType {
        case int, string, float, double, bool, none
    }
    
    public init(wrappedValue: Value, name: String? = nil, type: CodableType = .none) {
        self.wrappedValue = wrappedValue
        self.name = name
        self.type = type
    }
}

extension SGSerializable {
    internal func getKey(with key: String) -> SGCodingKey {
        let cKey: SGCodingKey!
        if let name = name, !name.isEmpty {
            cKey = SGCodingKey(name: name)
        }else {
            cKey = SGCodingKey(name: key)
        }
        return cKey
    }
}
