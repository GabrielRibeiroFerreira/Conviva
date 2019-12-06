//
//  CreateEventViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 12/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit
import MapKit

class CreateEventViewController: UIViewController {
    @IBOutlet weak var titleIniciative: TextFieldView!
    @IBOutlet weak var dateIniciative: TextFieldView!
    @IBOutlet weak var timeIniciative: TextFieldView!
    @IBOutlet weak var localIniciative: TextFieldView!
    @IBOutlet weak var descriptionIniciative: TextFieldView!
    @IBOutlet weak var justificativeIniciative: TextFieldView!
    @IBOutlet weak var nextButton: UIButton!
    
    let datePicker = UIDatePicker()
    
    var event: Event = Event()
    
    var dateStr: String?
    
    //String para passar endereço por segue, sem depender do textField
    //Problema se a view ainda não tiver sido carregada
    var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let address = self.address {
            self.localIniciative.textField.text = address
        }
        
        Setup.setupViewController(self)
        Setup.setupButton(self.nextButton, withText: "Avançar")
        Setup.setupDissmiss(self.view)
        
        self.titleIniciative.textField.placeholder = "O que é a iniciativa? (Título)"
        self.dateIniciative.textField.placeholder = "Em qual data?"
        self.timeIniciative.textField.placeholder = "Em qual horário?"
        self.localIniciative.textField.placeholder = "Onde irá acontecer?"
        self.descriptionIniciative.textField.placeholder = "Descreva a iniciativa"
        self.justificativeIniciative.textField.placeholder = "Justificativa para a iniciativa"
        
        self.localIniciative.isUserInteractionEnabled = false
        self.event.address = self.localIniciative.textField.text
        
        self.dateIniciative.textField.addTarget(self, action: #selector(self.showDatePicker(_:)), for: UIControl.Event.editingDidBegin)
        self.timeIniciative.textField.addTarget(self, action: #selector(self.showTimePicker(_:)), for: UIControl.Event.editingDidBegin)
        
    }

    // MARK: - Navigation
    
    @IBAction func nextClick(_ sender: Any) {
        //Formatação da data no padrão de string do Json - validar bem se textField estao preenchidos
        self.event.date = (self.dateStr ?? "") + " " + (self.timeIniciative.textField.text ?? "")
        self.event.name = self.titleIniciative.textField.text
        self.event.description = self.descriptionIniciative.textField.text
        self.event.justification = self.justificativeIniciative.textField.text
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "nextCreateSegue" {
            let destination = segue.destination as! CreateEvent2ViewController
            destination.event = event
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var returnValue: Bool = true
        
        //Checando se todos os campos foram completados
        returnValue = textFieldEmpty(self.titleIniciative) && returnValue
        returnValue = textFieldEmpty(self.dateIniciative) && returnValue
        returnValue = textFieldEmpty(self.timeIniciative) && returnValue
        returnValue = textFieldEmpty(self.localIniciative) && returnValue
        returnValue = textFieldEmpty(self.descriptionIniciative) && returnValue
        returnValue = textFieldEmpty(self.justificativeIniciative) && returnValue
        
        return returnValue
    }
    
    func textFieldEmpty(_ textfieldView : TextFieldView) -> Bool{
        textfieldView.emptyTextndicator.isHidden = textfieldView.textField.text == "" ? false : true
        return textfieldView.emptyTextndicator.isHidden
    }
    
//    func getLatLongByAddress(address: String) {
//        CLGeocoder().geocodeAddressString(address) { placemarks, error in
//            let placemark = placemarks?.first
//            let lat = placemark?.location?.coordinate.latitude
//            let lon = placemark?.location?.coordinate.longitude
//            print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
//
//            self.event.latitude = lat
//            self.event.longitude = lon
//        }
//    }
    
    @objc func showDatePicker(_ textField: UITextField){
        //Formate Date
        datePicker.datePickerMode = .date

        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        dateIniciative.textField.inputAccessoryView = toolbar
        dateIniciative.textField.inputView = datePicker

    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateIniciative.textField.text = formatter.string(from: datePicker.date)
        
        //String auxiliar para formatacao da data segundo o padrao JSON - "yyyy-MM-dd HH:mm"
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateStr = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
     }
    
    
    @objc func showTimePicker(_ textField: UITextField){
       //Formate Time
        datePicker.datePickerMode = .time

        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        timeIniciative.textField.inputAccessoryView = toolbar
        timeIniciative.textField.inputView = datePicker

    }
    
    @objc func doneTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeIniciative.textField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
                             
}
