//
//  ProductDetailView.swift
//  Walmart
//
//  Created by jacob brown on 2/1/24.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var vm: ProductDetailViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: vm.product.images[0])) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            VStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Text(String(format: "$%.2f", Double(vm.product.price) * (1 - (vm.product.discountPercentage / 100))))
                                .bold()
                                .padding(.horizontal)
                                
                            Spacer()
                            
                            StarRatingView(rating: vm.product.rating)
                                .padding(.horizontal)
                        }
                        
                        Text("Description")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        Text(vm.product.description)
                            .padding(.horizontal)
                        
                        Text("Comments")
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        
                        switch vm.loadingState {
                        case .idle, .loading:
                            VStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        case .error(let err):
                            ContentUnavailableView("Error", systemImage: "exclamationmark.triangle", description: Text(err))
                        case .success(let commentList):
                            CommentListView(commentList)
                        }
                    }
                }
            }
            .task {
                vm.GetComments()
            }
            .navigationTitle("\(vm.product.brand) \(vm.product.title)")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {} label: {
                            Text("Purchase Now")
                                .padding(5)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .stroke(.primary))
                        }
                        .foregroundStyle(.primary)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button {} label: {
                            Text("Add to cart")
                                .padding(5)
                                .padding(.horizontal)
                        }
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                        .background(.blue)
                        .frame(height: 30)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
    }
    
    @ViewBuilder
    func StarRatingView(rating: Double) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            Image(systemName: rating >= 1 ? "star.fill" : rating >= 0.5 ? "star.leadinghalf.filled" : "star")
                .foregroundStyle(.yellow)
            
            Image(systemName: rating >= 2 ? "star.fill" : rating >= 1.5 ? "star.leadinghalf.filled" : "star")
                .foregroundStyle(.yellow)
            
            Image(systemName: rating >= 3 ? "star.fill" : rating >= 2.5 ? "star.leadinghalf.filled" : "star")
                .foregroundStyle(.yellow)
            
            Image(systemName: rating >= 4 ? "star.fill" : rating >= 3.5 ? "star.leadinghalf.filled" : "star")
                .foregroundStyle(.yellow)
            
            Image(systemName: rating >= 5 ? "star.fill" : rating >= 4.5 ? "star.leadinghalf.filled" : "star")
                .foregroundStyle(.yellow)
            
            Text(String(format: "(%.2f)", rating))
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 3)
            
            
        }
    }
    
    @ViewBuilder
    func CommentListView(_ commentList: CommentList) -> some View {
        ForEach(commentList.comments) { comment in
            VStack(alignment: .leading) {
                HStack {
                    Text(comment.user.username)
                        .padding(.horizontal)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    StarRatingView(rating: Double.random(in: 0...5))
                        .font(.footnote)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                
                Text(comment.body)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                HStack {
                    Button {} label: {
                        Image(systemName: "hand.thumbsup")
                    }
                    
                    Button {} label: {
                        Image(systemName: "hand.thumbsdown")
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
        }
    }
}

#Preview {
    ProductDetailView(vm: ProductDetailViewModel(product: Product(id: 1,
                                                                  title: "iPhone 9",
                                                                  description: "An apple mobile which is nothing like apple",
                                                                  price: 549,
                                                                  discountPercentage: 12.96,
                                                                  rating: 4.69,
                                                                  stock: 94,
                                                                  brand: "Apple",
                                                                  category: "smartphones",
                                                                  thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
                                                                  images: ["https://cdn.dummyjson.com/product-images/1/1.jpg", "https://cdn.dummyjson.com/product-images/1/2.jpg", "https://cdn.dummyjson.com/product-images/1/3.jpg", "https://cdn.dummyjson.com/product-images/1/4.jpg", "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])
        )
    )
}
