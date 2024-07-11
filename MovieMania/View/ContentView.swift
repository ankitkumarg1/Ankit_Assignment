//
//  ContentView.swift
//  MovieMania
//
//  Created by neosoft on 11/07/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var searchText: String = ""
    @State private var floatingViewExpanded: Bool = false
    @State private var currentIndex : Int = 0
    @StateObject var viewModel = MoviesViewModel()
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    ScrollView{
                        LazyVStack(pinnedViews: .sectionHeaders){
                            if !viewModel.isEditing {
                                Section {
                                    VStack(spacing: 10){
                                        // Image carousel
                                        TabView(selection: $viewModel.selectedIndex) {
                                            ForEach(viewModel.categories.indices) { index in
                                                MovieCarousalRowView(url: $viewModel.categories[index].image)
                                                    .tag(index)
                                            }
                                        }
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .frame(height: 200)
                                        .listRowSeparator(.hidden)
                                        
                                        HStack{
                                            Spacer()
                                            ForEach(viewModel.categories.indices, id: \.self) { index in
                                                Capsule()
                                                    .fill(viewModel.selectedIndex == index ? ColorConstants.ceruleanBlue : ColorConstants.muteSage)
                                                    .frame(width: 8, height: 8)
                                                    .onTapGesture {
                                                        
                                                        viewModel.selectedIndex = index
                                                    }
                                            }
                                            Spacer()
                                            
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                    .listRowSeparator(.hidden)
                                } header: {
                                    EmptyView()
                                        .listRowSeparator(.hidden)
                                        .frame(height: 0)
                                    
                                }
                            }
                            
                            Section{
                                
                                ForEach(viewModel.filteredMovies ?? []) { movie in
                                    
                                    VStack{
                                        MovieRow(filteredMovie: movie)
                                    }
                                    .listRowSeparator(.hidden)
                                }
                                .listRowSeparator(.hidden)
                            } header: {
                                SearchBar(text: $viewModel.searchText, placeholder:
                                            viewModel.categories.count > 0 ?  $viewModel.categories[viewModel.selectedIndex].name: .constant(nil), viewModel: viewModel,isTextFieldFocused: _isTextFieldFocused)
                                .padding([.top,.bottom],10)
                                .listRowSeparator(.hidden)
                            }
                            .background(Color.white)
                            
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                
                //FLOATING Button
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            //show floating view
                            floatingViewExpanded.toggle()
                        } label: {
                            Image(.verticalEllipsis)
                                .font(.subheadline)
                                .tint(.white)
                                .frame(width: 50, height: 50)
                        }
                        .background(ColorConstants.ceruleanBlue)
                        .foregroundStyle(Color.white)
                        .cornerRadius(25)
                        .padding(20)
                    }
                }
            }
            .clipped()
            .sheet(isPresented: $floatingViewExpanded, content: {
                if viewModel.categories.count > 0{
                    FloatingDataView(dict: viewModel.topThreeCharacters, categoryName: viewModel.categories[viewModel.selectedIndex].name ?? "" , productCount: viewModel.filteredMovies?.count ?? 0)
                        .presentationDetents([.height(250),.medium])
                }
            })
        }
        .onChange(of: viewModel.searchText, {
            DispatchQueue.main.async {
                if viewModel.isEditing {
                    isTextFieldFocused = true
                }else{
                    isTextFieldFocused = false
                }
            }
        })
        .onAppear{
            viewModel.getData()
        }
    }
}

#Preview {
    ContentView()
}
