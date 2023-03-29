//
//  Page.swift
//  InfitineCarousel
//
//  Created by James Armer on 29/03/2023.
//

import SwiftUI

// Page Model
struct Page: Identifiable, Hashable {
    var id: UUID = .init()
    var color: Color
}
