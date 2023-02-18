//
//  EventListViewController.swift
//  Bredge
//
//  Created by suryaween on 17/09/22.
//

import UIKit

class EventListViewController: UIViewController {
    static let nibName = "EventListViewController"
    @IBOutlet weak var myEventBtn: UIButton!
    @IBOutlet weak var createEventBtn: UIButton!
    @IBOutlet weak var allEventBtn: UIButton!
    @IBOutlet weak var eventBackground: UIView!
    @IBOutlet weak var myeventView: UIView!
    @IBOutlet weak var alleventView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var isMyEventactive:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName:EventListingCell.cell, bundle: nil),forCellReuseIdentifier: EventListingCell.cell)
        alleventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        myeventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        eventBackground.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorThird.cgColor,ColorConstants.EventViewColor.eventGradientColorFourth.cgColor],isFromTopToBottom: true,frameWidth: eventBackground.bounds)
        alleventView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: alleventView.bounds)
    }
    @IBAction func createEventBtnClicked(_ sender: Any) {
        self.pushToNextController(controllerName: EventViewController.loadController())
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEventBtn.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: false, frameWidth: createEventBtn.bounds)
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.goToPreviousController()
    }
    
    @IBAction func allEventsBtnClicked(_ sender: Any) {
        alleventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        myeventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        alleventView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: alleventView.bounds)
        myeventView.backgroundColor = .clear
        
        allEventBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        myEventBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
        isMyEventactive = false
        tableView.reloadData()
    }
    

    @IBAction func myEventsBtnClicked(_ sender: Any) {
        myeventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        alleventView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        myeventView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: alleventView.bounds)
        alleventView.backgroundColor = .clear
        
        myEventBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        allEventBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
        isMyEventactive = true
        tableView.reloadData()
    }
 
}
extension EventListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMyEventactive
        {
          return 2
        }
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:EventListingCell.cell)  as!  EventListingCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushToNextController(controllerName: EventDetailsVC.loadController())
    }
   
}
