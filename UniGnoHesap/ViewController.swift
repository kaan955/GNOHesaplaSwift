//
//  ViewController.swift
//  UniGnoHesap
//
//  Created by Kaan Baysal on 11.08.2020.
//  Copyright © 2020 Kaan Baysal. All rights reserved.
//

import UIKit

var buttonClickCount = 0
var picker  = UIPickerView()
var timer: Timer!
var btnSender: UIButton!
var btnHarfSender: UIButton!
var silici = false
var tag_counter = -1

var dersArray = [String]()
var  krediArray = [String]()
var harfArray = [String]()
var section = 1
var indexim = 0
var x = 0
var GNO = 0.0
var toplamkredi = 0.0
var totalOrtalama = 0.0
var radiogroupnum = 1
//let myDB = Gnoclass(Double,Double,[String],[Int],[Int])



var titleKoyucu = "Kredi"
var titleHarf = "Harf"
var onaylandı = false
var krediPickerItem = ["Kredi","1","1.5","2","2.5","3","3.5","4","4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18"]
var harfPickerItemA = ["Harf","A","A-","B+","B","B-","C+","C","C-","D+","D","D-","F"]
var harfPickerItemDoubleA = ["Harf","AA","BA","BB","CB","CC","DC","DD","FD","FF"]
var harfPickerItemA1 = ["Harf","A1","A2","A3","B1","B2","B3","C1","C2","C3","D","F"]
var harfandKredi = ""
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
   public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if  harfandKredi == "Kredi"
    {
       return krediPickerItem.count
    }else
    {
      
        
        switch radiogroupnum {
                   case 1:
                     
                         return harfPickerItemDoubleA.count
                   case 2:
                    return harfPickerItemA.count
                   case 3:
                   
                        return harfPickerItemA1.count
                                  
                   default:
                        return harfPickerItemA.count
    }
    
    }}
    
   public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if  harfandKredi == "Kredi"
           {
              return krediPickerItem[row]
            
        }else
        {
            if radiogroupnum == 1
            {
                return harfPickerItemDoubleA[row]
            }
            else if radiogroupnum == 2
            {
                return harfPickerItemA[row]
            }
            else if radiogroupnum == 3
            {
                return harfPickerItemA1[row]
            }else
            {
             return harfPickerItemA[row]
            }
       
        }
      
      
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if  harfandKredi == "Kredi"
           {
            titleKoyucu = "1"
        titleKoyucu = krediPickerItem[row]
               //self.MyTableview.reloadData()
        }else
        {
            switch radiogroupnum {
            case 1:
                titleHarf = "AA"
                titleHarf = harfPickerItemDoubleA[row]
               // self.MyTableview.reloadData()
            case 2:
                titleHarf = "A+"
                titleHarf = harfPickerItemA[row]
                //self.MyTableview.reloadData()
            case 3:
                titleHarf = "A1"
                titleHarf = harfPickerItemA1[row]
                //self.MyTableview.reloadData()
            default:
                titleHarf = harfPickerItemA[row]
                //self.MyTableview.reloadData()
                           
            }
         
            
            
        }
        
        
        
        
              
    }


    @IBOutlet weak var before_kredim: UITextField!
    @IBOutlet weak var before_gno: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func selectedIndex(_ sender: Any) {
        var checker = ""
        let alert = UIAlertController(title:"Harf Tipi Değişikliği", message: "Bu eski verileriniz sıfırlanmasına sebep olacak.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Onayla", style:.default, handler: {action in checker = "true"}))
        alert.addAction(UIAlertAction(title: "Vazgeç", style:.cancel, handler: {action in checker = "false"}))
        
        
        
        self.present(alert,animated: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in

             if checker == "true" || checker == "false" {
                 timer.invalidate()

             
        
        if checker == "true"
        {
            switch self.segmentedControl.selectedSegmentIndex
        {
        case 0:
            radiogroupnum = 1
            self.closePicker()
        case 1:
            radiogroupnum = 2
              self.closePicker()
        case 2:
            radiogroupnum = 3
              self.closePicker()
            default:
            radiogroupnum = 1
              self.closePicker()
        }
        }else
        {
            self.segmentedControl.selectedSegmentIndex = radiogroupnum - 1
        }
                krediArray.removeAll()
                harfArray.removeAll()
                self.myCounter = 0
                
                titleKoyucu = "Kredi"
                titleHarf = "Harf"
            
                self.MyTableview.reloadData()
               
              
                self.MyPickerView.reloadAllComponents()
               
                
                //self.MyTableview.reloadData()
            
            }}
    }
    

    @IBOutlet weak var MyPickerView: UIPickerView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var MyTableview: UITableView!
   
    @IBAction func hesaplaBtn(_ sender: Any) {
        print("clicked")
        
        print(dump(harfArray))
                print(dump(krediArray))
        
        GNO = 0.0
        toplamkredi = 0.0
        totalOrtalama = 0.0
        
        hesaplamaFonk()
        
        
        
        
    }
    let db = DBHelper()
    var myCounter = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
         view.addGestureRecognizer(tap)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.view.backgroundColor = UIColor(named: "myGrey")
        
       MyPickerView.isHidden = true
        toolBar.isHidden = true
        MyPickerView.delegate = self
        MyPickerView.dataSource = self
       MyPickerView.backgroundColor = UIColor.gray
       MyPickerView.setValue(UIColor.white, forKey: "textColor")
        
        
        self.view.addSubview(MyPickerView)
        toolBar.sizeToFit()

        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
        
        MyTableview.layer.borderColor = UIColor.lightGray.cgColor
        self.view.backgroundColor = UIColor(named: "myGrey")
      
        //MyTableview.layer.borderColor = UIColor.myTab
      //  MyTableview.backgroundColor = UIColor(named: "myTablecolor")
        MyTableview.layer.cornerRadius = 10
        MyTableview.layer.borderWidth = 3.0
       // MyTableview.layer.borderColor =  UIColor.
        
        MyTableview.delegate = self
        MyTableview.dataSource = self
        
 
        
        
        
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let alert = UIAlertController(title:"", message: "Şuan ki veriler kayıt edilecektir. *Eski verileriniz silinecektir", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style:.default))
        self.present(alert,animated: true)
        // Your action
        let beforeGNO = before_gno.text ?? ""
        let beforeKredi = before_kredim.text ?? ""
        //let myDB = Gnoclass(Double,Double,[String],[Int],[Int])
        let myDB = Gnoclass(mevcutGNO: beforeGNO , mevcutKredi: beforeKredi, dersAdiArr: dersArray, krediArr: krediArray, harfArr: harfArray)
        
       var denemem = myDB.mevcutGNO
        print("burası \(myDB.mevcutGNO)")
    }
    @objc func dismissKeyboard() {
   
        view.endEditing(true)
    }
    
    @objc func harfOfKredi()
    {
        
        
    }
    
    @objc func myHarfPicker()
    {
        
  
    
        //harfandKredi = "Harf"
        MyPickerView.isHidden = true
              MyPickerView.selectRow(0, inComponent: 0, animated: false)
                    toolBar.isHidden = true
        
       
    
           
        let sayici = btnHarfSender.tag
            harfArray[sayici] = titleHarf
        
         btnHarfSender.setTitle(harfArray[sayici], for: .normal)
      
              onaylandı = true
        
    }
    
    @objc func myPicker(){
        
        
     
        MyPickerView.isHidden = true

        MyPickerView.selectRow(0, inComponent: 0, animated: false)
        
       //if(titleKoyucu != "1")
        //{
        //self.pickerView(MyPickerView, didSelectRow: 0, inComponent: 0)
       // }
              toolBar.isHidden = true
        
       // if(btnSender != nil)
       // {
         harfandKredi = "Kredi"
        var s = titleKoyucu
      
        onaylandı = true
            
            
             let sayici2 = btnSender.tag
            
            
            
        krediArray[sayici2] = titleKoyucu
        btnSender.setTitle(titleKoyucu, for: .normal)
        
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return harfArray.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        if indexPath.row == (harfArray.count)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dersEkleCell", for: indexPath) as! TableCell
            
            cell.cellDelegate = self
            cell.index = indexPath
            
            indexim = indexPath.row
         
                   return cell
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucreadi", for: indexPath) as! TableCell
            
         indexim = indexPath.row
            
            
            if indexim == (harfArray.count - 1)
            {
            cell.harfchoose.setTitle("Harf", for: .normal)
             cell.krediChoose.setTitle("Kredi", for: .normal)
            }
            
           cell.harfchoose.tag = indexPath.row
             cell.krediChoose.tag = indexPath.row
            
            tag_counter += 1
            
         
            
          
            
            cell.selectionStyle = .none
                     cell.krediChoose.addTarget(self, action: #selector(self.checkkredi(sender:)), for: .touchUpInside)
            
        
            cell.harfchoose.addTarget(self, action: #selector(self.checkHarf(sender2:)), for: .touchUpInside)
      
        return cell
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            if editingStyle == .delete
            {
                if indexPath.row <= harfArray.count - 1
                {
                harfArray.remove(at: indexPath.row)
                krediArray.remove(at: indexPath.row)
                myCounter = myCounter-1
                
                tag_counter += 100
                
              
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                }
                
            }
        }
    }
    
    @objc func checkHarf(sender2: UIButton)
    {
       let btnDone = UIBarButtonItem(title: "Onayla", style: .plain, target: self, action: #selector(self.myHarfPicker))
                  let btnKapat = UIBarButtonItem(title: "Kapat", style: .plain, target: self, action: #selector(self.closePicker))
                   
                   let bosluk = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
                       toolBar.setItems([btnKapat,bosluk,btnDone], animated: false)
        
         harfandKredi = "Harf"
           print("clickedharf")
                onClickHarf()
        //        sender.setTitle(titleKoyucu, for: .normal)
                btnHarfSender = sender2
                
        
    }
    
    
    @objc func checkkredi(sender: UIButton)
    {
        
        let btnDone = UIBarButtonItem(title: "Onayla", style: .plain, target: self, action: #selector(self.myPicker))
        let btnKapat = UIBarButtonItem(title: "Kapat", style: .plain, target: self, action: #selector(self.closePicker))
                   
                   let bosluk = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
                       toolBar.setItems([btnKapat,bosluk,btnDone], animated: false)
        
     
        
    
        harfandKredi = "Kredi"
       
        
        print("clicked")
        onClickKredi()
//        sender.setTitle(titleKoyucu, for: .normal)
        btnSender = sender
        
       
        
     
        
    }

    
    
    
    
    
}


extension ViewController: clickGonder {
    func onClickKredi() {
            
        harfandKredi = "Kredi"
        
        MyPickerView.reloadAllComponents()
          //self.MyTableview.reloadData()
        MyPickerView.isHidden = false
            toolBar.isHidden = false
          self.view.addSubview(toolBar)
        
  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in

    if onaylandı == true {
        timer.invalidate()

        }}

        
         
        
    }
    
    func onClickCell(index: Int) {
   
        myCounter += 1
        
        krediArray.append("0")
        harfArray.append("Harf")
        
     //   let indexPath = IndexPath(row: krediArray.count - 1, section: 0)
        

       // tableView.beginUpdate()
      //  MyTableview.insertRows(at: [indexPath],with: .automatic)
        //taableView.endUpdate()
     
        
  
       // self.MyTableview.
        self.MyTableview.reloadData()
    
        
    print(index)
    }
    
    func onClickHarf() {
                harfandKredi = "Harf"
        
          MyPickerView.reloadAllComponents()
          // self.MyTableview.reloadData()
          MyPickerView.isHidden = false
                  toolBar.isHidden = false
                self.view.addSubview(toolBar)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in

          if onaylandı == true {
              timer.invalidate()

              }}
    }
    
    @objc func closePicker()
    {
         MyPickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    func hesaplamaFonk()
    {
        
        
        if radiogroupnum == 1
        {
            for i in 0 ..< harfArray.count{
                 var mySwitch = harfArray[i]
                if(krediArray[i] == "0")
                {
                    let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Kredisi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                    self.present(alert,animated: true)
                }
                 switch mySwitch {
                 case "AA":
                     GNO += (4.0 * (Double)(krediArray[i])!)
                     toplamkredi += (Double)(krediArray[i])!
                 case "BA":
                     GNO += (3.5 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "BB":
                     GNO += (3.0 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "CB":
                     GNO += (2.5 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "CC":
                     GNO += (2.0 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "DC":
                     GNO += (1.5 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "DD":
                    GNO += (1.0 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "FD":
                    GNO += (0.5 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 case "FF":
                    GNO += (0.0 * Double(krediArray[i])!)
                     toplamkredi += Double(krediArray[i])!
                 default:
                     GNO += 0
                    let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Harfi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                    self.present(alert,animated: true)
                 }
             }
        }else if radiogroupnum == 2{
            var denemem = myCounter
            for i in 0 ..< myCounter{
                var mySwitch = harfArray[i]
                var myKredi = krediArray[i]
                if(krediArray[i] == "0")
                {
                    let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Kredisi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                    self.present(alert,animated: true)
                }
                switch mySwitch {
                case "A":
                    GNO += (4.0 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "A-":
                    GNO += (3.7 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "B+":
                    GNO += (3.3 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "B":
                    GNO += (3.0 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "B-":
                    GNO += (2.7 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "C+":
                    GNO += (2.3 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "C":
                    GNO += (2.0 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "C-":
                    GNO += (1.7 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "D+":
                    GNO += (1.3 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "D":
                    GNO += (1.0 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "D-":
                    GNO += (0.7 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                case "F":
                    GNO += (0.0 * Double(krediArray[i])!)
                    toplamkredi += Double(krediArray[i])!
                default:
                    GNO += 0
                    let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Harfi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                    self.present(alert,animated: true)
                }
            }
        }else if radiogroupnum == 3{
               for i in 0 ..< myCounter{
                    var mySwitch = harfArray[i]
                if(krediArray[i] == "0")
                {
                    let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Kredisi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                    self.present(alert,animated: true)
                }
                    switch mySwitch {
                    case "A1":
                        GNO += (4.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "A2":
                        GNO += (3.5 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "A3":
                        GNO += (3.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "B1":
                        GNO += (2.5 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "B2":
                        GNO += (2.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "B3":
                        GNO += (1.5 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "C1":
                       GNO += (1.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "C2":
                       GNO += (0.5 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "C3":
                       GNO += (0.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "D":
                        GNO += (0.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    case "F":
                        GNO += (0.0 * Double(krediArray[i])!)
                        toplamkredi += Double(krediArray[i])!
                    default:
                        let alert = UIAlertController(title:"Eksik Ders Bilgisi", message: "Harfi girilmemiş ders var. \nDersi sola çekip silebilirsiniz.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                        self.present(alert,animated: true)
                        
                        GNO += 0
                    }
                }
            
          
    }
        totalOrtalama = GNO / toplamkredi
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        //oddsLabel.text = formatter.string(for: totalOrtalama)
        var genelnot = formatter.string(for: totalOrtalama)
       var ss =  before_kredim.text
        var sgno = before_gno.text
       
    
        if(ss == "" && sgno == "")
        {
            
            
            let alert = UIAlertController(title:"", message: "Genel Not Ortalamanız:  \(genelnot!) \nYarı Dönem Not Ortalamanız: \(genelnot!) \nToplam Krediniz: \(toplamkredi)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style:.default))
            self.present(alert,animated: true)
            
        }else if (Int(sgno!)! > 4)
        {
            let alert = UIAlertController(title:"", message: "Mevcut GNO 4'ten büyük olamaz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style:.default))
            self.present(alert,animated: true)
        }
            else if(ss == "" || sgno == "")
            {
                
                let alert = UIAlertController(title:"Mevcut Bilgi", message: "Mevcut Bilgilere eksik veri girdiniz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style:.default))
                self.present(alert,animated: true)
                
            }
        else if(Int(sgno!)! >= 0 && Int(ss!)! >= 0)
        {
            let toplamkredi_after = Double(ss!)! + toplamkredi
            let toplamortalama_after = (Double((Int(sgno!)! * Int(ss!)!)) + totalOrtalama)/toplamkredi_after
            
            
            
            
            let alert = UIAlertController(title:"", message: "Genel Not Ortalamanız:  \(toplamortalama_after) \nYarı Dönem Not Ortalamanız: \(genelnot!) \nToplam Krediniz: \(toplamkredi_after)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style:.default))
            self.present(alert,animated: true)
            
            
        }else
        {
            let alert = UIAlertController(title:"", message: "Mevcut Bilgilerinizi Eksik Girdiniz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style:.default))
            self.present(alert,animated: true)
            
        }
        
        
        
                   
                   print(totalOrtalama)
        print(GNO)
        print(toplamkredi)
        
        
        
    }

  
    
    
}






