//
//  FirstViewController.swift
//  11 - To Do List App
//
//  Created by Marco Linhares on 6/13/15.
//  Copyright (c) 2015 Marco Linhares. All rights reserved.
//

import UIKit

var list = Model ()

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // variável criada pro ícone de refresh quando a pessoa "puxa" a tabela para cima com o dedo
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func buttonAdd (sender: AnyObject) {
        // troca pra 2a aba (índice começa em 0)
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func buttonErase(sender: AnyObject) {
        // mostra um alerta em popup com 2 opções
        var refreshAlert = UIAlertController(title: "Apagar Tudo?", message: "Todos os ítens serão removidos.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .Default, handler: { (action: UIAlertAction!) in
            // doesn't do anything
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Remover", style: .Default, handler: { (action: UIAlertAction!) in
            
            // remove all rows
            list.removeAll()
            
// COMO FAZER PRA REMOVER 1 LINHA DE CADA VEZ COM ANIMAÇÃO??????
//            for var i = 0; i < list.countElements(); i++ {
//                // Update Table View
//                self.tableView.deleteRowsAtIndexPaths(i, withRowAnimation: UITableViewRowAnimation.Right)
//            }
            
            self.handleRefresh (self.refreshControl)
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    // serve para informar o número de linhas da tabela
    func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.countElements()
    }
  
    // para dizer o número de seções. sem essa função, não é possível remover linhas
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // informa que as células podem ser editadas e no caso, removidas
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // função que atualiza as células com o texto adequado e usa o dequeue corretamente
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // não precisa instanciar uma célula nova toda vez e pode reaproveitar células fora da tela
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = list.elementAtIndex(indexPath.row)
        
        return cell
    }
    
    // função para remover as células com um swipe lateral
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Update Items
            list.removeElement(indexPath.row)

            // Update Table View
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }
    }
    
    // muda o texto padrão do botão de "delete" para algum outro
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Apagar"
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // ocorre logo antes da view aparecer, mas depois que ela já está carregada
    override func viewWillAppear(animated: Bool) {
        handleRefresh (refreshControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
