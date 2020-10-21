//
//  CollectionViewHucre.swift
//  UniGnoHesap
//
//  Created by Kaan Baysal on 16.08.2020.
//  Copyright © 2020 Kaan Baysal. All rights reserved.
//

import UIKit


protocol DataCollectionProtocol {
    func krediChooser(indx: Int)
    
    
}
class CollectionViewHucre: UICollectionViewCell {
    
    @IBOutlet weak var dersAdi: UITextField!
    
    @IBOutlet weak var krediButton: UIButton!
    
    @IBOutlet weak var harfButton: UIButton!
    
    var index: IndexPath?
    var delegate: DataCollectionProtocol?
    
   
}
