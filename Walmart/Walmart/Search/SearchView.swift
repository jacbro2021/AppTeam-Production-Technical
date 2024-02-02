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
    @State var showingSheet = false
    
    var body: some View {
        NavigationStack {
            SearchToolbarView
                .frame(height: 100)
            
            VStack {
                switch vm.loadingState {
                case .idle:
                    ContentUnavailableView.search
                case .loading:
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    Spacer()
                case .success(let productList, let specific_search):
                    SearchProductListView(productList, specific_search: specific_search)
                case .error(let err):
                    ContentUnavailableView("Error",
                                           systemImage: "exclamationmark.triangle",
                                           description: Text(err))
                }
            }
        }
        .task {
            // TODO: Change this task!!!
            vm.get_products()
            // TODO: Delete this test data.
            
        }
    }
    
    // MARK: Toolbar for the top of the screen with the search bar.

    @ViewBuilder
    private var SearchToolbarView: some View {
        VStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            vm.searchText = ""
                            vm.get_products()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                        .font(.largeTitle)
                        .padding(.leading)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.primary)
                                .padding(.leading)
                            
                            TextField("Search Walmart", text: $vm.searchText)
                                .onSubmit {
                                    vm.search_products()
                                }
                            
                            Spacer()
                            
                            Button {} label: {
                                Image(systemName: "barcode.viewfinder")
                            }
                            .font(.title)
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 5)
                        }
                        .padding(.horizontal, 2)
                        .frame(height: 35)
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
        }
    }
    
    @ViewBuilder
    private func SearchProductListView(_ productList: ProductList, specific_search: Bool = false) -> some View {
        VStack(alignment: .leading) {
            ScrollView {
                if specific_search {
                    HStack {
                        Text("Results for \"\(vm.searchText)\"")
                            .bold()
                            .font(.title2)
                    
                        Text("(\(productList.total))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            
                HStack {
                    Text("Price when purchased online")
                        .font(.callout)
                        .padding(.leading)
                
                    Button {} label: {
                        Image(systemName: "info.circle")
                    }
                    .foregroundStyle(.primary)
                    
                    Spacer()
                }
            
                ForEach(productList.products) { product in
                    NavigationLink {
                        ProductDetailView(vm: ProductDetailViewModel(product: product))
                    } label: {
                        ProductView(product: product)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
