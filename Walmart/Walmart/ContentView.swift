//
//  ContentView.swift
//  Walmart
//
//  Created by jacob brown on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = "Search"
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ShopView()
                .tabItem { Label("Shop", systemImage: "storefront") }
               

            ItemsView()
                .tabItem { Label("My Items", systemImage: "heart") }

            SearchView()
                .tabItem { Label("Search", systemImage: "sparkle.magnifyingglass") }
                .tag("Search")
            
            ServicesView()
                .tabItem { Label("Services", systemImage: "circle.grid.2x2") }

            AccountView()
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
        }
    }
}

#Preview {
    ContentView()
}
