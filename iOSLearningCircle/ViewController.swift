//
//  ViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 18/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myButton2: UIButton!
    
    var contador = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myButton2.addTarget(self, action: #selector(didTapDecrement), for: .touchUpInside)
    }
    
    @IBAction func didTapButton(_ sender: Any) {
//        guard let button = sender as? UIButton else { return }
        contador += 1
        myLabel.text = "Botón tocado \(contador) veces"
        
        myButton.setTitle("Tocado", for: .normal)
    }
    
    @objc func didTapDecrement(_ sender: UIButton) {
        contador -= 1
        
        myLabel.text = "Botón tocado \(contador) veces"
        
        sender.setTitle("Decrementar", for: .normal)
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        goToNextView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? SecondViewController else { return }
//        controller.contador = contador
    }
    
    private func goToNextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
//        controller.contador = contador
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
