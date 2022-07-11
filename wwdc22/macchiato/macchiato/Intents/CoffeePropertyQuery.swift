//
//  CoffeePropertyQuery.swift
//  macchiato
//
//  Created by Alex Logan on 11/07/2022.
//

import Foundation
import AppIntents

public struct CoffeePropertyQuery: EntityPropertyQuery {
    public init() { }

    public func entities(for identifiers: [Coffee.ID]) async throws -> [Coffee] {
        Coffee.all.filter({ identifiers.contains($0.id) })
    }

    public func suggestedEntities() async throws -> [Coffee] {
        Coffee.all
    }

    public func entities(matching comparators: [CoffeeComparator], mode: ComparatorMode, sortedBy: [EntityQuerySort<Coffee>], limit: Int?) async throws -> [Coffee] {
        let allCoffee = Coffee.all
        var matches: [Coffee]
        switch mode {
        case .and:
            matches = allCoffee.filter{ coffee in
                return comparators.reduce(true, { currentValue, comparator in
                    return match(coffee: coffee, comparator: comparator) && currentValue
                })
            }
        case .or:
            matches = allCoffee.filter{ coffee in
                return comparators.reduce(false, { currentValue, comparator in
                    return match(coffee: coffee, comparator: comparator) || currentValue
                })
            }
        }

        if let sort = sortedBy.first {
            matches.sort(by: {
                return sortPair(coffees: ($0, $1), sort: sort)
            })
        }

        return matches
    }

    func sortPair(coffees: (Coffee, Coffee), sort: EntityQuerySort<Coffee>) -> Bool {
        let lhs = coffees.0
        let rhs = coffees.1
        guard let lhsValue = lhs[keyPath: sort.by] as? EntityProperty<String>, let rhsValue = rhs[keyPath: sort.by] as? EntityProperty<String> else {
            return false
        }

        switch sort.order {
        case .ascending:
            return lhsValue.wrappedValue < rhsValue.wrappedValue
        case .descending:
            return lhsValue.wrappedValue > rhsValue.wrappedValue
        }
    }

    func match(coffee: Coffee, comparator: CoffeeComparator) -> Bool {
        switch comparator {
        case .nameContains(let string):
            return coffee.name.contains(string)
        case .nameEquals(let string):
            return coffee.name == string
        }
    }
    public static var properties: QueryProperties = EntityQueryProperties<Coffee, CoffeeComparator> {
        Property(\Coffee.$name) {
            EqualToComparator { CoffeeComparator.nameEquals($0) }
            ContainsComparator { CoffeeComparator.nameContains($0) }
        }
    }

    public static var sortingOptions = SortingOptions {
        SortableBy(\Coffee.$name)
    }
}

public enum CoffeeComparator: Sendable {
    case nameEquals(String)
    case nameContains(String)
}
