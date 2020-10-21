//
//  TableCell.swift
//  UniGnoHesap
//
//  Created by Kaan Baysal on 18.08.2020.
//  Copyright © 2020 Kaan Baysal. All rights reserved.
//

import UIKit

protocol clickGonder {
    
    func onClickCell(index: Int)
    func onClickKredi()
    func onClickHarf()
}

class TableCell: UITableViewCell {
    
    var cellDelegate:clickGonder?
    var index: IndexPath?
    
    var tapBlock: (() -> Void)? = nil

    @IBOutlet weak var dersadi: UITextField!
    
    @IBOutlet weak var harfchoose: UIButton!
    
    @IBOutlet weak var dersEkle: UIButton!
    
    @IBOutlet weak var krediChoose: UIButton!
    
    @IBAction func dersekleClick(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    @IBAction func krediBtnclicked(_ sender: UIButton) {
        tapBlock?()
        //cellDelegate?.onClickKredi(tag: sender.tag)
    }
    
}
