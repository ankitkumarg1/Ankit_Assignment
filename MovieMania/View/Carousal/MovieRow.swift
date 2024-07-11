//
//  MovieRow.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import SwiftUI

struct MovieRow: View {
    
    var filteredMovie : MoviesListModel
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack(spacing: 2){
                if let urlSting = filteredMovie.image , let url = URL(string: urlSting){
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            placeholderImageView
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60,height: 60)
                                .cornerRadius(10)
                                .clipped()
                                .padding([.leading,.trailing],20)
                                .padding([.top,.bottom],10)
                        case .failure(_):
                            placeholderImageView
                        @unknown default:
                            placeholderImageView
                        }
                    }
                }else{
                    placeholderImageView
                }
                
                VStack(alignment: .leading){
                    Text(filteredMovie.name ?? "")
                        .fontWeight(.medium)
                    Text(filteredMovie.description ?? "")
                        .font(.subheadline)
                }
                Spacer()
            }
            .background(ColorConstants.lightAqua)
            .cornerRadius(10)
            .padding([.leading,.trailing],10)
        }
    }
    var placeholderImageView: some View {
        Image(.placeholderIcon)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60,height: 60)
            .cornerRadius(10)
            .clipped()
            .padding([.leading,.trailing],20)
            .padding([.top,.bottom],10)
    }
}
