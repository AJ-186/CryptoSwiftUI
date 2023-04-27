//
//  CoinImageViewModel.swift
//  SwiftfullCrypto
//
//  Created by Ajinkya Adole on 01/12/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var coin: CoinModel
    private let dataService: CoinImageService
    private var cancelable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubcribers()
        self.isLoading = true
    }
    private func addSubcribers() {
        
        dataService.$image
            .sink { [weak self](_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancelable )

    }
}
