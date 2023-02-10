//
//  ViewController.swift
//  Asteroid
//
//  Created by Nitin Bhatia on 09/02/23.
//

import UIKit


class ViewController: UIViewController {
    
    //outelts
    @IBOutlet weak var datePkStartDate: UIDatePicker!
    @IBOutlet weak var datePkEndDate: UIDatePicker!
    @IBOutlet weak var btnSubmit : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePkStartDate.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        datePkEndDate.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        btnSubmit.isEnabled = datePkStartDate.date < datePkEndDate.date
       
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        vc.startDate = datePkStartDate.date.convertToString()
        vc.endDate = datePkEndDate.date.convertToString()
        navigationController?.show(vc, sender: nil)
    }
    
    
}

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
}
