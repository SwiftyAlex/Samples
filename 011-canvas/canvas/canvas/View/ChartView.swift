//
//  ChartView.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import SwiftUI

protocol ChartView: View {
    
    // Set an inset to make sure the edges of the shape can be visible
    var insets: CGFloat { get }
    // Width of the lines
    var strokeWidth: CGFloat { get }
    // Color of the drawing
    var color: Color { get }
    // Data
    var model: ChartModel { get }
}

struct ChartPoint {
    let point: CGPoint
    let value: String
}

extension ChartPoint: Comparable {
    static func < (lhs: ChartPoint, rhs: ChartPoint) -> Bool {
        return lhs.point.y > rhs.point.y
    }
}

extension ChartView {
    /// Given a set of data points, where 0 is minimum and 1 is maximum, returns a set of ChartPoints containing CGPoints for a given size
    /// Insets are used to inset the bounding box so that the edges of the shape are visible. To opt-out of this behaviour, set the insets to 0.
    func makeChartPoints(from dataPoints: [ChartValue], size: CGSize, unit: String) -> [ChartPoint] {
        var currentX: CGFloat = insets
        
        var size = size
        size.height = size.height - insets * 2
        size.width = size.width - insets * 2
        
        return dataPoints.map { dataPoint in
            let point = CGPoint(x: currentX, y: yValueForPoint(dataPoint: dataPoint.value, size: size))
            currentX += xValuePerPoint(size: size)
            return ChartPoint(point: point, value: "\(dataPoint.underlyingValue) \(unit)")
        }
    }
    
    /// The maximumY, or the bottom, of the chart.
    /// 0 is the top, and the value returned here is the bottom.
    func maxY(size: CGSize) -> CGFloat {
        return size.height
    }
    
    /// How far we need to move per value.
    /// If theres 5 values, and we have 100 pixels, they should start at 0 and add 20 per value, so the last point is at 100.
    func xValuePerPoint(size: CGSize) -> CGFloat {
        return ((size.width) / CGFloat(model.values.count-1))
    }

    
    /// Calculate the y value based on the size, and the data point being a decimal between 0 and 1.
    /// Calculated by taking the insets, and then taking away the points height ( the decimal multiplied by the maximum value ) from the maximum value
    private func yValueForPoint(dataPoint: Double, size: CGSize) -> CGFloat {
        let maxHeight = maxY(size: size)
        let pointHeight = (dataPoint * maxHeight)
        return insets + (maxHeight - pointHeight)
    }
    
    // Helpers for when we're not just drawing a single point
    
    /// Given a set of data points, where 0 is minimum and 1 is maximum, returns a set of ChartPoints containing CGPoints for a given size
    /// Insets are used to inset the bounding box so that the edges of the shape are visible. To opt-out of this behaviour, set the insets to 0.
    func makeChartPoints(from dataPoints: [ChartValue], size: CGSize, unit: String, itemWidth: CGFloat) -> [ChartPoint] {
        let halfItemWidth = itemWidth
        var currentX: CGFloat = insets + (halfItemWidth/2)
        
        var size = size
        size.height = size.height - insets * 2
        size.width = size.width - insets * 2
        
        return dataPoints.map { dataPoint in
            let point = CGPoint(x: currentX, y: yValueForPoint(dataPoint: dataPoint.value, size: size))
            // We need to increment by half the bar width, too
            currentX += xValuePerPoint(size: size, withItemWidth: itemWidth)
            return ChartPoint(point: point, value: "\(dataPoint.underlyingValue) \(unit)")
        }
    }
    
    
    /// How far we need to move per value.
    /// If theres 5 values, and we have 100 pixels, they should start at 0 and add 20 per value, so the last point is at 100.
    func xValuePerPoint(size: CGSize, withItemWidth width: CGFloat) -> CGFloat {
        let widthWithoutItems = size.width - width
        return widthWithoutItems / CGFloat(model.values.count-1)
    }
    
}
