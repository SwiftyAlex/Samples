//
//  TagLayout.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import Foundation
import SwiftUI

struct TagLayout: Layout {
    var itemSpacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // If we don't have a proposed size, lets fill all the space we can.
        let layoutSize = proposal.replacingUnspecifiedDimensions(
            by: .init(
                width: CGFloat.greatestFiniteMagnitude,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        let layout = calculateLayout(
            bounds: CGRect(x: 0, y: 0, width: 0, height: 0),
            maxWidth: layoutSize.width,
            size: proposal,
            subviews: subviews
        )
        let totalHeight = layout.rows.reduce(0) { currentHeight, row in
            return row.height + currentHeight
        } + (itemSpacing * CGFloat(layout.rows.count))
        return CGSize(width: proposal.width ?? .infinity, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let layoutSize = proposal.replacingUnspecifiedDimensions(
            by: .init(
                width: CGFloat.infinity,
                height: CGFloat.infinity
            )
        )
        let layout = calculateLayout(bounds: bounds, maxWidth: layoutSize.width, size: proposal, subviews: subviews)
        var currentItemOffset = 0
        for rowIndex in 0..<layout.rows.count {
            let row = layout.rows[rowIndex]
            for itemIndex in 0..<row.items.count {
                let item = row.items[itemIndex]
                let subviewIndex = currentItemOffset+itemIndex
                subviews[subviewIndex].place(
                    at: item.point, proposal: proposal
                )
            }
            currentItemOffset += row.items.count
        }
    }

    private func calculateLayout(
        bounds: CGRect, maxWidth: CGFloat, size: ProposedViewSize, subviews: Subviews
    ) -> TagLayoutResult {
        let maxWidth = maxWidth
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY

        let proposal = ProposedViewSize(CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
        var currentRowIndex: CGFloat = 0

        var currentRow: Row = Row(items: [])
        var rows: [Row] = [currentRow]

        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            if (currentX + viewSize.width) >= maxWidth {
                currentRowIndex += 1
                currentX = bounds.minX
                currentRow.calculateHeight()
                currentY += currentRow.height + (itemSpacing * 2)
                currentRow = Row(items: [])
                rows.append(currentRow)
            }
            currentRow.items.append(
                Item(point: CGPoint(x: currentX, y: currentY), size: view.sizeThatFits(proposal))
            )
            currentX += (viewSize.width + itemSpacing)
        }

        rows.forEach { $0.calculateHeight() }

        return TagLayoutResult(rows: rows)
    }

    private struct TagLayoutResult {
        var rows: [Row]
    }

    private class Row: Equatable, Hashable {
        var height: CGFloat = 0
        var items: [TagLayout.Item]

        internal init(height: CGFloat = 0, items: [TagLayout.Item]) {
            self.height = height
            self.items = items
        }

        func calculateHeight() {
            height = items.map(\.size).map(\.height).max(by: >) ?? 44
        }

        static func ==(lhs: Row, rhs: Row) -> Bool {
            return lhs.height == rhs.height && lhs.items == rhs.items
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(height)
        }
    }

    private struct Item: Equatable {
        let point: CGPoint
        let size: CGSize
    }
}


struct TagLayout_Previews: PreviewProvider {
    static var previews: some View {
        (TagLayout()) {
            TagView(tag: "iOS")
            TagView(tag: "Coffee")
            TagView(tag: "SwiftUI")
            TagView(tag: "WWDC22")
            TagView(tag: "Apps")
            TagView(tag: "New")
        }
    }
}
