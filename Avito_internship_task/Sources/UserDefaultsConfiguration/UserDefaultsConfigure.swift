//
//  UserDefaultsConfigure.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 22.10.2022.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let encodeAsJSON: Bool
    let userDefaults = UserDefaults.standard
    
    public init(_ key: String, defaultValue: T, encodeAsJSON: Bool = false) {
        self.key = key
        self.defaultValue = defaultValue
        self.encodeAsJSON = encodeAsJSON
    }
    
    public var wrappedValue: T {
        get {
            if self.encodeAsJSON,
               let data = self.userDefaults.object(forKey: self.key) as? Data,
               T.self is Codable.Type {
                
                let value = T.self as! Decodable.Type
                
                if let object = value.object(from: data) as? T {
                    return object
                }
                
                return self.defaultValue
                
            } else {
                return self.userDefaults.object(forKey: self.key) as? T ?? self.defaultValue
            }
        }
        set {
            if let value = newValue as? OptionalProtocol, value.isNil() {
                UserDefaults.standard.removeObject(forKey: key)
                return
            }
            
            if self.encodeAsJSON, let value = newValue as? Codable {
                let data = value.jsonData()
                self.userDefaults.set(data, forKey: key)
            } else {
                self.userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

private protocol OptionalProtocol {
    func isNil() -> Bool
}

extension Optional: OptionalProtocol {
    func isNil() -> Bool {
        return self == nil
    }
}

extension Decodable {
    static func object(from string: String?) -> Self? {
        guard let data = string?.data(using: .utf8) else { return nil }
        return Self.object(from: data)
    }
    static func object(from data: Data) -> Self? { try? JSONDecoder().decode(Self.self, from: data) }
}

extension Encodable {
    func jsonData() -> Data? { try? JSONEncoder().encode(self) }
}
