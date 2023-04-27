//
//  HomeViewModel.swift
//  SwiftfullCrypto
//
//  Created by Ajinkya Adole 
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        $searchText
            .combineLatest(dataService.$allCoins)
            .map { (text, startingCoins) -> [CoinModel] in
                
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowerCaseText = text.lowercased()
                
               return startingCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(lowerCaseText) ||  coin.symbol.lowercased().contains(lowerCaseText) ||  coin.id.lowercased().contains(lowerCaseText)
                }
        
            }
            
    }
}
