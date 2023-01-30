//
//  NetworkManager.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    @Published var photoInfo = PhotoInfo()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // создаем полный url-адрес
        let url = URL(string: Constants.baseURL)!
        let fullURL = url.withQuery(["api_key" : Constants.key])!
        print(fullURL.absoluteString)
        
        // получение данных
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch { error in
                Just(PhotoInfo())
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
    }
}
