//
//  ContentView.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var dataSet: [Double] = [42,12,32,17,70,90,120,100]
    
    var chartModel: ChartModel {
        return .from(rawValues: dataSet, unit: "mg", title: "Caffeine(mg)")!
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack(spacing: 20) {
                        makeHeader(text: "Line")
                        LineChart(color: randomiseColor(), graphHeight: 150, model: chartModel)
                        makeHeader(text: "Line with labels")
                        LineChartWithLabel(color: randomiseColor(), graphHeight: 150, model: chartModel)
                        makeHeader(text: "Line with labels & dots")
                        LineChartWithLabelsAndDots(color: randomiseColor(), graphHeight: 150, model: chartModel)
                        makeHeader(text: "Line with fill")
                        LineChartWithFill(color: randomiseColor(), graphHeight: 150, model: chartModel)
                        makeHeader(text: "Bar")
                        BarChart(color: randomiseColor(), graphHeight: 150, model: chartModel)
                    }
                    .padding()
                }
            }
            .navigationTitle("Charts")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Randomise Data", role: .none, action: { self.randomiseDataSet() })
                }
            }
        }
    }
    
    func makeHeader(text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func randomiseColor() -> Color {
        let kindaNiceColors: [Color] = [.teal, .yellow, .red, .green, .gray]
        return kindaNiceColors[Int.random(in: kindaNiceColors.indices)]
    }
    
    func randomiseDataSet() {
        Task(priority: .userInitiated) {
    
            self.dataSet = self.dataSet.map({ _ in Double.random(in: 0..<1) })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
