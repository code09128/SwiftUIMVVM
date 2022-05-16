//
//  HomeViewModel.swift
//  SwiftUISearchMusicMVVM
//
//  Created by Dustin on 2022/3/21.
//

import Foundation

class HomeViewModel:ObservableObject{
    @Published var results = [SearchResult]()
    @Published var searchText:String = "" {
        //收到屬性資料變化後 做更新處理這個屬性
        didSet {
            isSearchEnable = {
                (searchText.count > 2)
            }()
        }
    }
    @Published var isSearchEnable = false
    @Published var isLoading = false
    
    func performSearch(){
        isLoading = true
        //URL處理轉碼
        let search = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        guard let gURL = URL(string: "https://itunes.apple.com/search?term=\(search)") else {
            self.isLoading = false
            return
        }
        
        Task{
            do {
                // 解析做資料處理
                // try await呼叫 URLSession.shared.data(from:)
                // 從function data(from:)回傳的(data, response)取得抓到的資料
                let (data, response) = try await URLSession.shared.data(from: gURL)
                
                // decode JSON 失敗時會丟出錯誤
                let responseData = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.results = responseData.results!
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    print("*** ERROR ***")
                }
            }
        }
    }
}
