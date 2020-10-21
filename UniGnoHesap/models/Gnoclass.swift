//
//  Gnoclass.swift
//  UniGnoHesap
//
//  Created by Kaan Baysal on 18.10.2020.
//  Copyright © 2020 Kaan Baysal. All rights reserved.
//

import Foundation


class Gnoclass: Codable {
    
    let mevcutGNO: String
    let mevcutKredi: String
    
    let dersAdiArr : [String]
    let krediArr: [String]
    let harfArr: [String]

    
    init(mevcutGNO: String,mevcutKredi: String, dersAdiArr: [String],krediArr: [String], harfArr: [String]) {
        self.mevcutGNO = mevcutGNO
        self.mevcutKredi = mevcutKredi
        self.dersAdiArr = dersAdiArr
        self.krediArr = krediArr
        self.harfArr = harfArr
        print("oldu")
    }
    
    
    
}
