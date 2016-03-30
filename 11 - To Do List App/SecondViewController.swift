//
//  SecondViewController.swift
//  11 - To Do List App
//
//  Created by Marco Linhares on 6/13/15.
//  Copyright (c) 2015 Marco Linhares. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var labelItemAdded: UILabel!
    
    @IBAction func ButtonAdd(sender: AnyObject) {
        let item = inputText.text
        
        if item != nil && item! != "" {
            list.addElement (item!)
            
            labelItemAdded.text = item! + " foi adicionado na lista"
            
            inputText.text = ""
            
            // não precisa tirar o teclado pro user continuar adicionando ítens
            //inputText.resignFirstResponder()
        }
    }
    
    // running code when the screen is tapped
    // ocorre quando a pessoa clica na tela
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // pára de editar, o que significa que o teclado desaparece
        self.view.endEditing(true)
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        ButtonAdd (self)
        
        // não precisa tirar o teclado pro user continuar adicionando ítens
        //inputText.resignFirstResponder()
        
        return true
    }

    // chamado quando a cena já foi carregada e vai aparecer pela 1a ou nas demais vezes
    override func viewWillAppear(animated: Bool) {
        labelItemAdded.text = ""
        inputText.text = ""
        
        inputText.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

