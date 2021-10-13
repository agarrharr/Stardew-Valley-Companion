//
//  ContentView.swift
//  Stardew Companion
//
//  Created by Adam Garrett-Harris on 10/12/21.
//

import SwiftUI

struct ContentView: View {
    let (x, y) = getPlayerLocation()
    var body: some View {
        VStack {
            Text(getPlayerName())
            Text(getFarmName())
            Text(getFarmType())
            Text(getMoney())
            Text(getTimeOfYear())
            Text(getformattedTimePlayed())
            Text("(\(x), \(y))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
