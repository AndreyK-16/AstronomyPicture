//
//  API.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import Foundation
import Combine

struct API {
    
    static func createFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    // обновление данных при изменении даты
    static func createURL(for date: Date) -> URL {
        let formatter = createFormatter()
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Constants.baseURL)!
        let fullURL = url.withQuery(["api_key" : Constants.key, "date": dateString])!
        return fullURL
    }
    //  определяет день до сегоднешней даты
    static func create(daysFromToday: Int) -> Date {
        let today = Date()
        
        if let newDate = Calendar.current.date(byAdding: .day, value: -daysFromToday, to: today) {
            return newDate
        } else {
            return today
        }
    }
    
    // создаем полный url-адрес, дата = сегодня
//    let url = URL(string: Constants.baseURL)!
//    let fullURL = url.withQuery(["api_key" : Constants.key])!
//    print(fullURL.absoluteString)
    // создает паблишера по ответу от url
    static func crearePublisher(url: URL) -> AnyPublisher<PhotoInfo, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch { error in
                Just(PhotoInfo())
            }
            .eraseToAnyPublisher()
    }
}
