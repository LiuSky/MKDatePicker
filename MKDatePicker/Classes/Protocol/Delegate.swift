//
//  Delegate.swift
//  MKDatePicker
//
//  Created by xiaobin liu on 2020/4/1.
//

import Foundation


/// MARK - https://gist.github.com/onevcat/3c8f7c4e8c96f288854688cf34111636/3674c944a420a09f473726043856f28c9c1014d0
public class Delegate<Input, Output> {
    public init() {}
    
    private var block: ((Input) -> Output?)?
    public func delegate<T: AnyObject>(on target: T, block: ((T, Input) -> Output)?) {
        self.block = { [weak target] input in
            guard let target = target else { return nil }
            return block?(target, input)
        }
    }
    
    func callAsFunction(_ input: Input) -> Output? {
        return block?(input)
    }
}

public protocol OptionalProtocol {
    static var createNil: Self { get }
}

extension Optional : OptionalProtocol {
    public static var createNil: Optional<Wrapped> {
         return nil
    }
}

extension Delegate where Output: OptionalProtocol {
    public func call(_ input: Input) -> Output {
        if let result = block?(input) {
            return result
        } else {
            return .createNil
        }
    }
}
