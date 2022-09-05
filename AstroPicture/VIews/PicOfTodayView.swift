//
//  PicOfTodayView.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 04.09.2022.
//

import SwiftUI

struct PicOfTodayView: View {
    @ObservedObject var manager = NetworkManager()
    @State private var showSwitchDate: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            
            Button {
                self.showSwitchDate.toggle()
            } label: {
                Image(systemName: "calendar")
                Text("switch day")
                
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .popover(isPresented: $showSwitchDate) {
                SelectDateView(manager: self.manager)
            }

            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                LoadingAnimation()
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(manager.photoInfo.date).font(.title)
                    Text(manager.photoInfo.title).font(.headline)
                    Text(manager.photoInfo.description)
                }
            }
            .padding()
        }
        
    }
}

struct PicOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PicOfTodayView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "preview_image")
        return view
    }
}
