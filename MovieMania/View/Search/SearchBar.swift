//
//  SearchBar.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text : String
    @Binding var placeholder : String?
    @ObservedObject var viewModel: MoviesViewModel
    @FocusState var isTextFieldFocused: Bool
   
    var body: some View {
        HStack{
            TextField("\(StringConstants.SEARCH) \(placeholder ?? "") .....",text: $text)
                .focused($isTextFieldFocused)
                .keyboardType(.asciiCapable)
            
                .submitLabel(.search)
                .padding(7)
                .padding(.horizontal,25)
                .background(ColorConstants.lightGray)
                .cornerRadius(8)
                .overlay (
                    HStack{
                        Image(systemName: ImageConstant.magnifyingGlass)
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,8)
                    }
                )
                .padding(.horizontal,10)
                .onTapGesture {
                    DispatchQueue.main.async {
                        viewModel.isEditing = true
                        isTextFieldFocused = true
                        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            if viewModel.isEditing{
                Button {
                    viewModel.isEditing = false
                    self.text = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                } label: {
                    withAnimation(.easeIn) {
                        Text(StringConstants.CANCEL)
                            .tint(.black)
                    }
                    
                }
                .padding(.trailing,10)
                .transition(.move(edge: .trailing))
            }
            
        }
       
    }
    
}


