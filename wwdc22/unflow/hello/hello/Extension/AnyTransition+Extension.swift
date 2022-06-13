//
//  AnyTransition+Extension.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var imageLoadingTransition: AnyTransition {
        .opacity.combined(with: .scale(scale: 0.99)).animation(.spring())
    }
}
