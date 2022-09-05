//
//  MultiNetworkManager.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 05.09.2022.
//

import Foundation
import Combine
import SwiftUI

class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var daysFromToday: Int = 0
    
    init() {
        
        $daysFromToday
            .map { daysFromToday in
                return API.createDate(daysFromToday)
            }.map { date in
                API.createURL(for: date)
            }.flatMap { url in
                return API.createPublisher(url: url)
            }.scan([]) { partialValue, newValue in
                return partialValue + [newValue]
            }
            .tryMap { infos in
                infos.sorted { $0.formatterDate > $1.formatterDate }
            }
            .catch { error in
                Just([PhotoInfo]())
            }
            .eraseToAnyPublisher()
        
            .receive(on: RunLoop.main)
            .assign(to: \.infos, on: self)
            .store(in: &subscriptions)
        
        // Подгрузить таблицу при скролле
        getMoreData(for: 20)
    }
    
    func getMoreData(for times: Int) {
        for _ in 0..<times {
            self.daysFromToday += 1
        }
    }
    
    func fetchImage(for photoInfo: PhotoInfo) {
        guard photoInfo.image == nil, let url = photoInfo.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("fetch image error \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data),
                      let index = self.infos.firstIndex(where: { $0.id == photoInfo.id }) {
                
                DispatchQueue.main.async {
                    self.infos[index].image = image
                }
            }
        }
        task.resume()
    }
    
}
