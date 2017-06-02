//
//  HTTPHelper.swift
//  Saloon User
//
//  Created by Shivang Mishra on 12/04/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]
typealias JSONArray = [[String : Any]]
infix operator <-
infix operator <-|

func <- <T>(rawJson: Any?, string: String) -> T? {
    
    guard let json = rawJson as? JSON else { return nil }
    
    if T.self is Int.Type { return json.parse(intFrom: string) as? T}
        
    else if T.self is String.Type { return json.parse(stringFrom: string) as? T}
        
    else if T.self is Bool.Type { return json.parse(boolFrom: string) as? T}
        
    else if T.self is Float.Type { return json.parse(floatFrom: string) as? T}
        
    else if T.self is Double.Type { return json.parse(doubleFrom: string) as? T}
        
    else { return nil }
}

func <-|(rawJson : Any?, string : String) -> Any? {
    
    guard let json = rawJson as? JSON else { return nil }
    return json[string]
}

func <=(rawJson : Any?, string : String) -> JSONArray? {
    
    guard let json = rawJson as? JSON, let jsonarr = json[string] as? JSONArray else { return nil }
    return jsonarr
}

//MARK: - Dictionary
func flatten<A>(x: A??) -> A? {
    if let y = x { return y }
    return nil
}

infix operator >>>=
@discardableResult
public func >>>= <A, B> (optional: A?, f: (A) -> B?) -> B? {
    return flatten(x: optional.map(f))
}

extension Dictionary where Key : ExpressibleByStringLiteral, Value : Any {
    
    public func parse(numberFrom key: Key) -> NSNumber? {
        return self[key] >>>= { $0 as? NSNumber }
    }
    
    public func parse(intFrom key: Key) -> Int? {
        return self.parse(numberFrom: key).map { $0.intValue }
    }
    
    public func parse(floatFrom key: Key) -> Float? {
        return self.parse(numberFrom: key).map { $0.floatValue }
    }
    
    public func parse(doubleFrom key: Key) -> Double? {
        return self.parse(numberFrom: key).map { $0.doubleValue }
    }
    
    public func parse(stringFrom key: Key) -> String? {
        return self[key] >>>= { $0 as? String }
    }
    
    public func parse(boolFrom key: Key) -> Bool? {
        return self.parse(numberFrom: key).map { $0.boolValue }
    }
}
