//
//  Home.swift
//  AppleSheetBottomAnimation
//
//  Created by James Armer on 20/03/2023.
//

import SwiftUI

struct Home: View {
    // Animation Properties
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    var body: some View {
        TabView {
            // Sample Tabs
            SampleTabView("Listen Now", "play.circle.fill")
            SampleTabView("Browse", "square.grid.2x2.fill")
            SampleTabView("Radio", "dot.radiowaves.left.and.right")
            SampleTabView("Music", "play.square.stack")
            SampleTabView("Search", "magnifyingglass")
        }
        .tint(.red)
        .safeAreaInset(edge: .bottom) {
            CustomBottomSheet()
        }
        .overlay {
            if expandSheet {
                ExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
                // Transition for more fluent Animation
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        
    }
    

    
    @ViewBuilder
    func CustomBottomSheet() -> some View {
        // Animating Sheet Background (To Look Like It's Expanding from the Bottom
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
            
        }
        .frame(height: 70)
        // Seperator Line
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
            
        })
        // 49: Default Tab Bar Height
        .offset(y: -49)
    }
    
    @ViewBuilder
    func SampleTabView(_ title: String, _ icon: String) -> some View {
        // iOS Bug - It can be avoided by wrapping in a ScrollView
        ScrollView(.vertical, showsIndicators: false, content: {
            Text(title)
                .padding(.top, 25)
        })
        .tabItem {
            Image(systemName: icon)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        // Hiding Tab Bar When Sheet is Expanded
        //            .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct MusicInfo: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    var body: some View {
        HStack(spacing: 0) {
            // Adding Matched Geometry Effect (Hero Animation)
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        Image("Artwork")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: expandSheet ? 15 : 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                }
                
            }
            .frame(width: 45, height: 45)
            
            
            Text("Look What You Made Me Do")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 25)
            
            
        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            // Expanding Bottom Sheet
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}



