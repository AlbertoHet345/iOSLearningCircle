//
//  SecondViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 25/04/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    var contador: Int?
    var nombre: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let counter = contador else { return }
//        myLabel.text = "El valor del contador es: \(counter)"
        
        guard let nombre = nombre else { return }
        myLabel.text = "Nombre: \(nombre)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
