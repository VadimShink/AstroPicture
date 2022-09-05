//
//  API.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 05.09.2022.
//

import Foundation
import Combine

struct API {
    
    static func createFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func createURL(for date: Date) -> URL {
        let formatter = API.createFormatter()
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Constants.baseURL)!
        let fullURL = url.withQuery(["api_key" : Constants.key, "date" : dateString])!
        
        return fullURL
    }
    
    static func createDate(_ daysFromToday: Int) -> Date {
        let today = Date()
        
        if let newDate = Calendar.current.date(byAdding: .day, value: -daysFromToday, to: today) {
            return newDate
        } else {
            return today
        }
    }
    
    static func createPublisher(url: URL) -> AnyPublisher<PhotoInfo, Never> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch { error in
                Just(PhotoInfo())
            }
            .eraseToAnyPublisher()
    }
}
