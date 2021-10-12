//
//  Books.swift
//  Stardew Companion
//
//  Created by Adam Garrett-Harris on 10/12/21.
//

import Foundation
import SWXMLHash

let xmlWithNamespace = readLocalFile(forName: "ExampleSaveFile")
//let xmlWithNamespace = """
//<root xmlns:h=\"http://www.w3.org/TR/html4/\"
//xmlns:f=\"http://www.w3schools.com/furniture\">
//  <h:table>
//    <h:tr>
//      <h:td>Apples</h:td>
//      <h:td>Bananas</h:td>
//    </h:tr>
//  </h:table>
//  <f:table>
//    <f:name>African Coffee Table</f:name>
//    <f:width>80</f:width>
//    <f:length>120</f:length>
//  </f:table>
//</root>
//"""

var xml = XMLHash.parse(xmlWithNamespace!)

// one root element
let count = xml["root"].all.count

func getPlayerName() -> String {
    xml["SaveGame"]["player"]["name"].element!.text
}

// enumerate all child elements (procedurally)
// enumerate(indexer: xml, level: 0)
func enumerate(indexer: XMLIndexer, level: Int) {
    for child in indexer.children {
        let name = child.element!.name
        print("\(level) \(name)")

        enumerate(indexer: child, level: level + 1)
    }
}


// enumerate all child elements (functionally)
// xml.children.reduce("elements: ", reduceName)
func reduceName(names: String, elem: XMLIndexer) -> String {
    return names + elem.element!.name + elem.children.reduce(", ", reduceName)
}

