//
//  BottomSheet.swift
//  Bredge
//
//  Created by Magenta on 19/10/22.
//

import UIKit

class BottomSheet: UIViewController {

    @IBOutlet weak var tblView:UITableView!
 
    var arrNotification = ["Remove this notification","Turn off these notification","Report issue"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UINib(nibName:BottomSheetCell.cell, bundle: nil),forCellReuseIdentifier: BottomSheetCell.cell)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false)
    }

}

extension BottomSheet:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:BottomSheetCell.cell) as? BottomSheetCell else {
            fatalError("cell error")
        }
        cell.lblTitle.text = self.arrNotification[indexPath.row]
       
        return cell
    }
    
    @objc func btnMenu(_ sender:UIButton){
        let vc: BottomSheet = BottomSheet(nibName: "BottomSheet", bundle:nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated:false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
}
