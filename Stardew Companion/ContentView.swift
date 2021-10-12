//
//  ContentView.swift
//  Stardew Companion
//
//  Created by Adam Garrett-Harris on 10/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(getPlayerName())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
