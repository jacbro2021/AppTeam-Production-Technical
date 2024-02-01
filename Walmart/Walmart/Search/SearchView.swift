//
//  SearchView.swift
//  Walmart
//
//  Created by jacob brown on 1/31/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            SearchToolbarView
                .frame(height: 100)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var SearchToolbarView: some View {
        VStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {} label: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .padding(.leading)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.primary)
                                .padding(.leading)
                            
                            TextField("Search Walmart", text: $vm.searchText)
                            
                            Spacer()
                            
                            Button {} label: {
                                Image(systemName: "barcode.viewfinder")
                            }
                            .font(.title)
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 5)
                        }
                        .padding(.horizontal, 2)
                        .frame(height: 40)
                        .background()
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        
                        HStack {
                            NavigationLink {
                                CartView()
                            } label: {
                                VStack(alignment: .leading) {
                                    Image(systemName: "cart")
                                        .font(.title2)
                                        .padding(.trailing)
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                        .overlay {
                                            Circle()
                                                .foregroundStyle(.yellow)
                                                .frame(width: 15)
                                                .position(CGPoint(x: 25, y: 3))
                                                .overlay {
                                                    Text("0")
                                                        .font(.caption2)
                                                        .foregroundStyle(.black)
                                                        .position(x: 25, y: 3)
                                                }
                                        }
                                    Text("$0.00")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .padding(.trailing)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Image("phone-in-hand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .clipShape(Circle())
                            .padding(.leading, 5)
                        
                        Text("How do you want your items?")
                            .foregroundStyle(colorScheme == .dark ? .black : .white)
                            .font(.callout)
                        
                        Text("| 27514")
                            .foregroundStyle(colorScheme == .dark ? .black : .white)
                            .font(.callout)
                        
                        Button {
                            // Insert filtering feature here.
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                        .font(.title2)
                        .padding(.horizontal)
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
