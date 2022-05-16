//
//  HomeView.swift
//  SwiftUISearchMusicMVVM
//
//  Created by Dustin on 2022/3/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView{
            VStack{
                //Text Area
                HStack{
                    TextField("Search Text", text: $viewModel.searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.words)
                    
                    if viewModel.isLoading{
                        ProgressView().padding(.horizontal)
                    }
                }
                .padding()
                
                //Search Button
                Button {
                    viewModel.performSearch()
                } label: {
                    Text ("SEARCH MUSIC")
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .opacity(viewModel.isSearchEnable ? 1.0 : 5.0)
                }
                .background(Color.red)
                .cornerRadius(10)
                .disabled(!viewModel.isSearchEnable)
                .padding()
                
                //Result List
                List {
                    ForEach(viewModel.results,id:\.trackId){
                        let viewModel = SearchResultVM(model: $0)
                        SearchResultRow(resultVM: viewModel)
                    }
                }
                .listStyle(.inset)
            }
            
            .navigationTitle("MVVM DEMO")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
