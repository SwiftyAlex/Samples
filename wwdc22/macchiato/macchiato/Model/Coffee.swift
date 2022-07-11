//
//  Coffee.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import Foundation
import AppIntents

// This will break the other query in beta 2
//struct CoffeeQuery: EntityStringQuery {
//    typealias Entity = Coffee
//    func entities(matching string: String) async throws -> [Coffee] {
//        return Coffee.all.filter({ $0.name.starts(with: string) })
//    }
//    func entities(for identifiers: [UUID]) async throws -> [Coffee] {
//        return Coffee.all.filter({ identifiers.contains($0.id) })
//    }
//}

public struct Coffee: Equatable, Hashable, AppEntity {
    public typealias DefaultQueryType = CoffeePropertyQuery
    public static var defaultQuery: CoffeePropertyQuery = CoffeePropertyQuery()
    
    public static var typeDisplayName: LocalizedStringResource = LocalizedStringResource("Coffee", defaultValue: "Coffee")
    public  var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: .init(stringLiteral: name))
    }

    public let id: UUID
    @Property(title: "Coffee Name")
    public var name: String
    public let imageUrl: URL

    public init(id: UUID, name: String, imageUrl: URL) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
    }

    public static func == (lhs: Coffee, rhs: Coffee) -> Bool {
        lhs.id == rhs.id && lhs.imageUrl == rhs.imageUrl && lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(imageUrl)
    }
}

// MARK: - Useful data
extension Coffee {
    static let all = [flatWhite, latte, mocha, cortado, macchiato]

    static let flatWhite = Coffee(
        id: UUID(uuidString: "693a960e-e6ab-11ec-8fea-0242ac120002")!,
        name: "Flat White",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1611564494260-6f21b80af7ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZmxhdCUyMHdoaXRlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")!
    )
    static let latte = Coffee(
        id: UUID(uuidString: "693a9802-e6ab-11ec-8fea-0242ac120002")!,
        name: "Latte",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1547983896-a51f56785650?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmxhdCUyMHdoaXRlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")!
    )
    static let mocha = Coffee(
        id: UUID(uuidString: "693a9938-e6ab-11ec-8fea-0242ac120002")!,
        name: "Mocha",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1596078841242-12f73dc697c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1528&q=80")!
    )
    static let cortado = Coffee(
        id: UUID(uuidString: "693a9a50-e6ab-11ec-8fea-0242ac120002")!,
        name: "Cortado",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1534687941688-651ccaafbff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80")!
    )
    static let macchiato = Coffee(
        id: UUID(uuidString: "693a9cb2-e6ab-11ec-8fea-0242ac120002")!,
        name: "Macchiato",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1485808191679-5f86510681a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80")!
    )
}
