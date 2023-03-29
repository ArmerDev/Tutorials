//
//  ContentView.swift
//  InfitineCarousel
//
//  Created by James Armer on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Carousel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
