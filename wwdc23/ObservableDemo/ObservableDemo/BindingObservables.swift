//
//  BindingObservables.swift
//  ObservableDemo
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI
import Observation

struct BindingObservables: View {
    @Bindable var model: BindingModel

    var body: some View {
        Form {
            TextField(text: $model.name, label: {
                Text("Name")
            })
        }
    }
}

@Observable
public final class BindingModel {
    public var name: String = ""
}

#Preview {
    BindingObservables(model: .init())
}
