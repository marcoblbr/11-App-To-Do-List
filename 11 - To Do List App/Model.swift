//
//  Model.swift
//  
//
//  Created by Marco Linhares on 6/14/15.
//
//

import Foundation

class Model {
    var list: [String]
    
    init () {
        list = []
        
        // recover stored elements
        // apenas carrega caso o valor não seja nulo
        if let listInMemory = NSUserDefaults.standardUserDefaults().objectForKey ("table") as? [String] {
            list = listInMemory as [String]
        }
    }
        
    func addElement (element : String) {
        // insere sempre no começo do vetor
        list.insert(element, atIndex: 0)
    
        writeToDisk ()
    }
    
    func removeElement (index : Int) {
        list.removeAtIndex(index)
        
        writeToDisk ()
    }

    func removeAll () {
        list.removeAll(keepCapacity: false)
        
        writeToDisk ()
    }
    
    func writeToDisk () {
        // cria ou atualiza uma variável permanente
        NSUserDefaults.standardUserDefaults().setObject(list, forKey: "table")
        
        // save permanently on disk
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func countElements () -> Int {
        return list.count
    }
    
    func elementAtIndex (index : Int) -> String {
        return list [index]
    }
}
