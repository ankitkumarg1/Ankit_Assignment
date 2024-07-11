//
//  MovieCarousalRowView.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import SwiftUI

struct MovieCarousalRowView: View {
    
    @Binding var url: String?
    
    var body: some View {
        VStack {
            if let urlSting = url, let extractedURL = URL(string: urlSting){
                AsyncImage(url: extractedURL, scale: 2) { phase in
                    switch phase {
                    case .empty:
                        movieCarousalPlaceholderImageView
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(20)
                            .clipped()
                            .padding(20)
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        movieCarousalPlaceholderImageView
                    @unknown default:
                        movieCarousalPlaceholderImageView
                    }
                }
            }else{
                movieCarousalPlaceholderImageView
            }
        }
    }
    
    var movieCarousalPlaceholderImageView: some View {
        Image(.placeholderIcon)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .cornerRadius(20)
            .clipped()
            .padding(20)
            .aspectRatio(contentMode: .fill)
    }
}

