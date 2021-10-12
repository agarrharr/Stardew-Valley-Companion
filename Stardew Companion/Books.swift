//
//  Books.swift
//  Stardew Companion
//
//  Created by Adam Garrett-Harris on 10/12/21.
//

import Foundation
import SWXMLHash

func pad2Digit(_ number: Int) -> String {
    String(format: "%02d", number)
}

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

func getMoney() -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    let value = Int(xml["SaveGame"]["player"]["money"].element!.text)!
    let number = NSNumber(value: value)
    let formattedValue = formatter.string(from: number)!
    
    return "\(formattedValue) g"
}

func getFarmName() -> String {
    "\(xml["SaveGame"]["player"]["farmName"].element!.text) Farm"
}

func getYear() -> Int {
    Int(xml["SaveGame"]["year"].element!.text)!
}

func getDayOfMonth() -> Int {
    Int(xml["SaveGame"]["dayOfMonth"].element!.text)!
}

func getCurrentSeason() -> String {
    xml["SaveGame"]["currentSeason"].element!.text
}

func getTimeOfYear() -> String {
    "Day \(getDayOfMonth()) of \(getCurrentSeason().capitalized), Year \(getYear())"
}

private func getMillisecondsPlayed() -> Int {
    Int(xml["SaveGame"]["player"]["millisecondsPlayed"].element!.text)!
}

func getformattedTimePlayed() -> String {
    let milliseconds = getMillisecondsPlayed()
    let totalMinutes = milliseconds / 60000
    let hours = totalMinutes / 60
    let minutes = totalMinutes % 60
    return "\(pad2Digit(hours)):\(pad2Digit(minutes))"
}

func getFarmType() -> String {
    let farmTypes = ["Standard farm", "River farm", "Forest farm", "Hill-top farm", "Wilderness farm"]

    return farmTypes[Int(xml["SaveGame"]["whichFarm"].element!.text)!]
}

private func packColor(r: Int, g: Int, b: Int, a: Int) -> Int {
    0 | (a & 255) << 24 | (b & 255) << 16 | (g & 255) << 8 | (r & 255)
}

//private func unpackColor(_ packedColor: Int) -> nil {
//    let a = (color >> 24) & 255
//    let b = (color >> 16) & 255
//    let g = (color >> 8) & 255
//    let r = color & 255
//}

// ["questLog"]["Quest"]
// <_currentObjective>Build a Coop.</_currentObjective><_questDescription>Robin, the local carpenter, lives north of town. In exchange for raw materials and money, she'll construct new buildings on your farm. You'll need her to build a coop or barn so that you can raise animals.</_questDescription><_questTitle>Raising Animals</_questTitle><rewardDescription>-1</rewardDescription><completionString>Coop</completionString><accepted>false</accepted><completed>true</completed><dailyQuest>false</dailyQuest><showNew>false</showNew><canBeCancelled>false</canBeCancelled><destroy>false</destroy><id>7</id><moneyReward>100</moneyReward><questType>8</questType><daysLeft>0</daysLeft><nextQuests><int>-1</int></nextQuests><questTitle>Raising Animals</questTitle>



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

