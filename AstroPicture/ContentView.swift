//
//  ContentView.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 04.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        APODListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PicOfTodayView()
    }
}
