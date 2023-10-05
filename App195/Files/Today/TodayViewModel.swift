//
//  TodayViewModel.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI
import Alamofire
import CoreData

final class TodayViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    @Published var news: [TodayItem] = []
    
    @Published var isDetail: Bool = false
    @Published var selectedNews: TodayItem?
    
    @AppStorage("saved_news") var saved_news: [String] = []
    
    func getNews() {
        
        isLoading = true
        
        self.fetchNews { result in
            
            switch result {
                
            case .success(let success):
                
                self.news = success.results
                
            case .failure(let failure):
                
                debugPrint("Parse error - \(failure)")
                
                self.isLoading = false
            }
        }
    }
    
    func fetchNews(completion: @escaping (Result<TodayModel, Error>) -> Void ) {
        
        isLoading = true
        
        let params: Parameters = [
            
            "token": "4a88be2d-cef5-43f6-8ee2-8f6c4b091652",
        ]
        
        let request = AF.request("https://optimumusd.space/api/v2/news", method: .get, parameters: params)
        
        request.responseDecodable(of: TodayModel.self) { response in
            
            guard let value = response.value else {
                
                self.isLoading = false
                return
            }
                           
            switch response.result{
                
            case .success(_):
                
                completion(.success(value))
                self.isLoading = false
                
            case .failure(_):
                
                completion(.failure(response.error.debugDescription as! Error))
                self.isLoading = false
            }
        }
    }
}
