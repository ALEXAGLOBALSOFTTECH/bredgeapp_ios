//
//  CommentSecond.swift
//  Bredge
//
//  Created by Magenta on 19/10/22.
//

import UIKit

class CommentSecond: UIViewController {

    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib(nibName:CommentSecondCell.cell, bundle: nil),forCellReuseIdentifier: CommentSecondCell.cell)
        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnBack(_ sender:UIButton) {
       self.goToPreviousController()
   }

}
extension CommentSecond:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:CommentSecondCell.cell) as? CommentSecondCell else {
            fatalError("cell error")
        }
       
        return cell
    }
    
   
   
}
