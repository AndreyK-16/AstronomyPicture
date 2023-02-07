//
//  MultiNetworkManager.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import Foundation
import Combine
import SwiftUI

class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    @Published var daysFromToday: Int = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $daysFromToday
            .map { daysFromToday in
                return API.create(daysFromToday: daysFromToday)
            }
            .map { date in
                return API.createURL(for: date)
            }
            .flatMap { url in
                return API.crearePublisher(url: url)
            }
            .scan([]) { particalValue, newValue in
                return particalValue + [newValue]
            }
            .tryMap({ infos in
                infos.sorted { $0.formattedDate > $1.formattedDate }
            })
            .catch { error in
                Just([PhotoInfo]())
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.infos, on: self)
            .store(in: &subscriptions)
        
        getMoreDate(for: 20)
    }
    
    func getMoreDate(for times: Int) {
        for _ in 1..<times {
            self.daysFromToday += 1
        }
    }
    /// функция получает фото в APODetatilView. используется для загрузки фото только после перехода с APOList на APODetatilView чтобы сразу не загружать все фото сразу при запуске приложения
    func fetchImage(for photoInfo: PhotoInfo) {
//        photoInfo.url
        // получить фото
        // добавить его в свойство image
        
        guard photoInfo.image == nil, let url = photoInfo.url else { return }
        
        let tast = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("fetch image error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data), let index = self.infos.firstIndex(where: {$0.id == photoInfo.id}) {
                
                DispatchQueue.main.async {
                    self.infos[index].image = image
                }
            }
            
        }
        tast.resume()
    }
}
