//
//  FileController.swift
//  Stardew Companion
//
//  Created by Adam Garrett-Harris on 10/12/21.
//

import Foundation

func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "xml"),
            let data = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return data
        }
    } catch {
        print(error)
    }
    
    return nil
}
