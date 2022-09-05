//
//  SelectDateView.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 04.09.2022.
//

import SwiftUI

struct SelectDateView: View {
    @State private var date = Date()
    
    @ObservedObject var manager: NetworkManager
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Select a day").font(.headline)
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("Some text")
            }.labelsHidden()
            
            Button {
                self.manager.date = date
                self.presentation.wrappedValue.dismiss()
                print("action")
            } label: {
                Text("Done")
            }
        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: NetworkManager())
    }
}
