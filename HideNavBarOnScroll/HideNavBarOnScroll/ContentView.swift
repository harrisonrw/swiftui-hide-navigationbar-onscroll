//
//  ContentView.swift
//  HideNavBarOnScroll
//
//  Created by Robert Harrison on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [UUID] = (1...100).compactMap { _ in UUID() }
    
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
        }
    }
}

#Preview {
    ContentView()
}
