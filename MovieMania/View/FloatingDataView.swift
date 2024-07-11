//
//  FloatingDataView.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import SwiftUI

struct FloatingDataView: View {
    
    var dict: [[Character : Int]]
    var categoryName: String
    var productCount : Int
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            HStack{
                VStack(alignment : .leading){
                    Text("\(categoryName) (\(productCount) items)")
                    .bold()
                    ForEach(0..<dict.count, id: \.self) { index in
                        let item = dict[index]
                        if let key = item.keys.first, let value = item.values.first {
                            Text("\(key) = \(value)")
                            .fontWeight(.medium)
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            Spacer()
        }
    }
}
