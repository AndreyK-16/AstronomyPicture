//
//  URLHelper.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import Foundation

extension URL {
    /// функция добавляет компоненты  к запросу URL
    func withQuery(_ query: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map({ URLQueryItem(name: $0.0, value: $0.1)})
        return components?.url
    }
}
