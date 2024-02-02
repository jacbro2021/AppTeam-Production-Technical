//
//  ProductView.swift
//  Walmart
//
//  Created by jacob brown on 2/1/24.
//

import SwiftUI

struct ProductView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var favorited = false
    let product: Product
    let tag = Int.random(in: 0...2)
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ProductTagView(randInt: tag)
                    .padding(.leading, 5)
                ZStack {
                    AsyncImage(url: URL(string: product.images[0])) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Button {
                                favorited.toggle()
                            } label: {
                                Image(systemName: "heart.circle.fill")
                            }
                            .foregroundStyle(favorited ? .red : .secondary)
                            .font(.title2)
                            Spacer()
                        }
                    }
                }
                .frame(width: 160, height: 150)
            }
            .padding(.bottom, 90)
                
            VStack(alignment: .leading) {
                HStack {
                    Text(String(format: "Now $%.2f", Double(product.price) * (1 - (product.discountPercentage / 100))))
                        .foregroundStyle(Color("sale-green"))
                        
                    Text("$\(product.price)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .strikethrough()
                }
                .padding(.bottom, 5)
                    
                Text("\(product.title)")
                
                StarRatingView(rating: product.rating)
                    .padding(.top, 5)
                
                Text("Save with W+")
                    .foregroundStyle(.blue)
                    .font(.caption)
                    .bold()
                    .padding(.vertical, 8)
                
                Text("Free shipping, arrives **in 2 days**")
                    .font(.caption)
                    .padding(.bottom, 8)
                
                Button {} label: {
                    Text("Add to cart")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 45)
                .background(.blue)
                .clipShape(Capsule())
            }
            .padding(.horizontal)
            
            Spacer()
        }
            
        Divider()
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
            
            Text("(1237)")
                .foregroundStyle(.secondary)
                .font(.caption2)
        }
    }
    
    @ViewBuilder
    func ProductTagView(randInt: Int) -> some View {
        VStack {
            if randInt == 0 {
                RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                    .opacity(0.3)
                    .foregroundStyle(.blue)
                    .frame(width: 70, height: 25)
                    .overlay {
                        Text("Best Seller")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    
            } else if randInt == 1 {
                RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                    .opacity(0.2)
                    .foregroundStyle(.orange)
                    .frame(width: 70, height: 25)
                    .overlay {
                        Text("Flash Deal")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                    
            } else if randInt == 2 {
                RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                    .opacity(0.9)
                    .foregroundStyle(Color("flash-sale"))
                    .frame(width: 75, height: 25)
                    .overlay {
                        Text("Popular Pick")
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? .black : .white)
                    }
            }
        }
        .padding(.leading, 2)
    }
}

#Preview {
    ProductView(product: Product(id: 1,
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
}
