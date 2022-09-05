//
//  APODListView.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 05.09.2022.
//

import SwiftUI

struct APODListView: View {
    
    @ObservedObject var manager = MultiNetworkManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.infos) { info in
                    
                    NavigationLink(destination: APODDetailView(photoInfo: info, manager: self.manager)) {
                        APODRow(photoInfo: info)
                    }
                    
                    .onAppear {
                        if let index = self.manager.infos.firstIndex(where: { $0.id == info.id }),
                           index == self.manager.infos.count - 1 && self.manager.daysFromToday == self.manager.infos.count - 1 {
                            self.manager.getMoreData(for: 10)
                        }
                    }
                }.frame(height: 50, alignment: .leading)
                
                ForEach(0..<15) { _ in
                    Rectangle()
                        .fill(.gray.opacity(0))
                        .frame(height: 50)
                }
            }.navigationTitle("Picture of the day")
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}
