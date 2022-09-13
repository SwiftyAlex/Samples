//
//  WhichCoffeeIntent.swift
//  macchiato
//
//  Created by Alex Logan on 10/07/2022.
//

import Foundation
import SwiftUI
import AppIntents

struct WhichCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Get a list of coffee"
    static var description = IntentDescription("Gives you a lovely list of all the coffees available.")
    static var openAppWhenRun: Bool = false

    // Or @Dependency(key: "CoffeeProvider", default: CoffeeProvider()
    @Dependency(key: "CoffeeProvider") var coffeeProvider: CoffeeProvider

    func perform() async throws -> some ShowsSnippetView {
        let coffees = coffeeProvider.getCoffees()
        
        // We can't show remote images in the list, so we have to fetch them here
        // This is the same behaviour as if you were using a widget
        
        
        let taskGroup = await withTaskGroup(
            of: (Coffee, UIImage).self,
            returning: [Coffee: UIImage].self
        ) { taskGroup in
            var dataResults: [Coffee: UIImage] = [:]
            coffees.forEach { coffee in
                // You should likely replace `UIImage()` with a pretty placeholder.
                taskGroup.addTask {
                    do {
                        let (data, _) = try await URLSession.shared.data(from: coffee.imageUrl)
                        return (coffee, UIImage(data: data) ?? UIImage())
                    } catch {
                        return (coffee, UIImage())
                    }
                }
            }
            
            for await result in taskGroup {
                dataResults[result.0] = result.1
            }

            return dataResults
        }
        
        return .result(value: coffees) {
            CoffeesView(coffees: taskGroup.map({ (key: Coffee, value: UIImage) in
                CoffeeWithImage(coffee: key, image: value)
            }))
        }
    }
}

struct CoffeeWithImage: Hashable {
    let coffee: Coffee
    let image: UIImage
}

// Public as it wont render otherwise
public struct CoffeesView: View {
    let coffees: [CoffeeWithImage]

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(coffees, id: \.coffee.id) { coffee in
                HStack {
                    Image(uiImage: coffee.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .cornerRadius(6)
                    Text(coffee.coffee.name)
                        .font(.headline.weight(.semibold))
                    Spacer()
                }
                Divider()
            }
        }
        .padding()
    }
}
