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
            
            VStack {
                switch vm.loadingState {
                    case .idle:
                        ContentUnavailableView.search
                    case .loading:
                        ProgressView()
                    case .success(let productList):
                        SearchProductListView(productList)
                    case .error(let err):
                        ContentUnavailableView("Error",
                                               systemImage: "exclamationmark.triangle",
                                               description: Text(err))
                }
            }
        }
        .task {
            // TODO: Change this task!!!
            // vm.get_products()
            // TODO: Delete this test data.
            vm.loadingState = .success(products: ProductList(products: [
                    Product(id: 1,
                            title: "iPhone 9",
                            description:"An apple mobile which is nothing like apple",
                            price:549,
                            discountPercentage:12.96,
                            rating:4.69,
                            stock:94,
                            brand:"Apple",
                            category:"smartphones",
                            thumbnail:"https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                            images:["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]
                            ),
                    Product(id: 1,
                            title: "iPhone 9",
                            description:"An apple mobile which is nothing like apple",
                            price:549,
                            discountPercentage:12.96,
                            rating:4.69,
                            stock:94,
                            brand:"Apple",
                            category:"smartphones",
                            thumbnail:"https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                            images:["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]
                            ),
                    Product(id: 1,
                            title: "iPhone 9",
                            description:"An apple mobile which is nothing like apple",
                            price:549,
                            discountPercentage:12.96,
                            rating:4.69,
                            stock:94,
                            brand:"Apple",
                            category:"smartphones",
                            thumbnail:"https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                            images:["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]
                            ),
                    Product(id: 1,
                            title: "iPhone 9",
                            description:"An apple mobile which is nothing like apple",
                            price:549,
                            discountPercentage:12.96,
                            rating:4.69,
                            stock:94,
                            brand:"Apple",
                            category:"smartphones",
                            thumbnail:"https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                            images:["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]
                            ),
                    Product(id: 1,
                            title: "iPhone 9",
                            description:"An apple mobile which is nothing like apple",
                            price:549,
                            discountPercentage:12.96,
                            rating:4.69,
                            stock:94,
                            brand:"Apple",
                            category:"smartphones",
                            thumbnail:"https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                            images:["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]
                            ),
                ],
                total: 5,
                skip: 0,
                limit: 5))
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
                        Button {} label: {
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
            Spacer()
        }
    }
    
    @ViewBuilder
    private func SearchProductListView(_ productList: ProductList) -> some View {
        ForEach(productList.products) { product in
            Text(product.title)
        }
    }
}

#Preview {
    SearchView()
}
