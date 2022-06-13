//
//  Coffee.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import Foundation

struct Coffee: Equatable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let imageUrl: URL
}

// MARK: - Useful data
extension Coffee {
    static let all = [flatWhite, latte, mocha, cortado, macchiato, americano]

    static let flatWhite = Coffee(
        id: UUID(uuidString: "693a960e-e6ab-11ec-8fea-0242ac120001")!,
        name: "Flat White",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1611564494260-6f21b80af7ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZmxhdCUyMHdoaXRlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")!
    )
    static let latte = Coffee(
        id: UUID(uuidString: "693a9802-e6ab-11ec-8fea-0242ac120002")!,
        name: "Latte",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1547983896-a51f56785650?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmxhdCUyMHdoaXRlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60")!
    )
    static let mocha = Coffee(
        id: UUID(uuidString: "693a9938-e6ab-11ec-8fea-0242ac120003")!,
        name: "Mocha",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1596078841242-12f73dc697c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1528&q=80")!
    )
    static let cortado = Coffee(
        id: UUID(uuidString: "693a9a50-e6ab-11ec-8fea-0242ac120004")!,
        name: "Cortado",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1534687941688-651ccaafbff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80")!
    )
    static let macchiato = Coffee(
        id: UUID(uuidString: "693a9cb2-e6ab-11ec-8fea-0242ac120005")!,
        name: "Macchiato",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1485808191679-5f86510681a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80")!
    )
    static let americano = Coffee(
        id: UUID(uuidString: "693a9cb2-e6ab-11ec-8fea-0242ac120006")!,
        name: "Americano",
        imageUrl: URL(string: "https://images.unsplash.com/photo-1551030173-122aabc4489c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80")!
    )
}
