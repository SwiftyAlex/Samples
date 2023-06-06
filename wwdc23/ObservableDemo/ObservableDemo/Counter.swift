//
//  Counter.swift
//  ObservableDemo
//
//  Created by Alex Logan on 06/06/2023.
//

import Foundation
import Observation

@Observable
class Counter {
    var count: Int = 0
    var string: String = "hello"
}
