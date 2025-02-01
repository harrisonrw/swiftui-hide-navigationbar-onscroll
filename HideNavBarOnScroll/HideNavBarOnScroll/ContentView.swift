//
//  ContentView.swift
//  HideNavBarOnScroll
//
//  Created by Robert Harrison on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [UUID] = (1...100).compactMap { _ in UUID() }
    
    @State private var toolbarVisibility: Visibility = .visible
    @State private var lastContentOffset: CGFloat = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        ForEach(items, id: \.self) { item in
                            ItemView(item: item)
                        }
                    }
                    .scrollTargetLayout()
                }
                .onScrollPhaseChange { oldPhase, newPhase, context in
                    let currentOffset = context.geometry.contentOffset.y
                    let isScrollingDown = currentOffset > lastContentOffset
                    
                    switch newPhase {
                    case .interacting, .tracking:
                        break
                    case .animating, .decelerating:
                        if oldPhase == .interacting || oldPhase == .tracking {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                toolbarVisibility = isScrollingDown ? .hidden : .visible
                            }
                        }
                    case .idle:
                        if oldPhase != .idle && abs(currentOffset - lastContentOffset) > 20 {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                toolbarVisibility = isScrollingDown ? .hidden : .visible
                            }
                        }
                    }
                    
                    lastContentOffset = currentOffset
                }
            }
            .navigationTitle("Item List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Item List")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                    }
                }
            }
            .toolbarVisibility(toolbarVisibility, for: .navigationBar)
            .statusBarHidden(toolbarVisibility != .visible)
        }
    }
}

#Preview {
    ContentView()
}
