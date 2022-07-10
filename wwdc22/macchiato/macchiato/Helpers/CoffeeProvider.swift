//
//  CoffeeProvider.swift
//  macchiato
//
//  Created by Alex Logan on 10/07/2022.
//

import Foundation

class CoffeeProvider {
    func getCoffees() -> [Coffee] {
        return Coffee.all
    }
}
