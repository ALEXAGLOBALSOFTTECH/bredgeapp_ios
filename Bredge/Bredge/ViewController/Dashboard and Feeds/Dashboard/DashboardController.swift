//
//  DashboardController.swift
//  Bredge
//
//  Created by suryaween on 11/09/22.
//

import UIKit
import Macaw
import FanMenu
class DashboardController: UIViewController {
    static let nibName = "DashboardController"
    @IBOutlet weak var floatingMenu: FanMenu!
    @IBOutlet weak var mainView: UIView!
    let items = [
        ("settings", 0xF55B58),
        ("gallery", 0xF55B58),
        ("multi", 0xF55B58),
        ("location", 0xFF703B),
        ("message", 0x85B1FF),
        ("cam", 0x9F85FF),
    ]
   
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var triangle2: UIView!
    @IBOutlet weak var triangle3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.setDownTriangle(targetView: self.mainView)
//        self.view.setLeftTriangle(targetView: self.mainView)

        floatingMenu.button = mainButton(colorHex: 0x7C93FE)
        floatingMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: "float_\(button.0)"),
                color: Color(val: button.1)
            )
        }
        floatingMenu.menuRadius = 90.0
        floatingMenu.duration = 0.2
        floatingMenu.interval = (Double.pi, 2 * Double.pi)
        floatingMenu.radius = 10.0
        
        floatingMenu.onItemDidClick = { button in
            let btnClickedValue = button.id
            print(btnClickedValue)
            switch (btnClickedValue){
            case "settings" :
                self.pushToNextController(controllerName: SettingsViewController.loadController())
            case "gallery":
                print("Clicked Item: \(btnClickedValue)")
                
            case "multi" :
                print("Clicked Item: \(btnClickedValue)")
                self.pushToNextController(controllerName: ColourPalleteController.loadController())
            case "location" :
                DispatchQueue.main.async {
                    self.pushToNextController(controllerName: MapController.loadController())
                }
                
                
            case "message" :
                print("Clicked Item: \(btnClickedValue)")
                
            case "cam":
                
                print("Clicked Item: \(btnClickedValue)")
            
            default:
                print("Clicked Item: \(btnClickedValue)")
            
            }
            
        }

     floatingMenu.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi/2.0))
        
        floatingMenu.backgroundColor = .clear
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingMenu.updateNode()
//        triangleView.setRightTriangle(targetView: triangleView)
//  triangle2.setLeftTriangle(targetView: triangle2)
//    triangle3.setUpTriangle(targetView: triangle3)
        
        
        
}
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        DispatchQueue.main.async {
          
           
            let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: FeedVC()), leftMenuViewController: SettingsViewController(), rightMenuViewController: SettingsViewController())
           
            
            //sideMenu.navigationController?.setNavigationBarHidden(true, animated: true)
            sideMenu.backgroundImage = UIImage(named: "Background.jpg")
            sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
            sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
            sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
            //sideMenu.delegate = self
            sideMenu.panGestureEnabled = false
            
            UIApplication.shared.windows.first?.rootViewController = sideMenu
            UIApplication.shared.windows.first?.makeKeyAndVisible()
          
    //        self.navigationController?.isNavigationBarHidden = true
//            self.pushToNextController(controllerName: FeedVC.loadController())
        }
        
    }

    func mainButton(colorHex: Int) -> FanMenuButton {
        return FanMenuButton(
            id: "main",
            image: UIImage(named: "floatButton"),
            color: Color(val: colorHex)
        )
    }
  
    
  
}



//TriangleView

extension UIView {

    func setRightTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.width //you can use triangleView.frame.size.height
        let path = CGMutablePath()
        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor
        targetView!.layer.insertSublayer(shape, at: 0)
    }

    func setLeftTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.height
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
       

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.gray.cgColor
        targetView!.layer.insertSublayer(shape, at: 0)
    }

    func setUpTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor
        
        targetView!.layer.insertSublayer(shape, at: 0)
    }

    func setDownTriangle(targetView:UIView?){
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        targetView!.layer.insertSublayer(shape, at: 0)
    }
}

