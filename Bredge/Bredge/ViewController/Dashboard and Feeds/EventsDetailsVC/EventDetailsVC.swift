//
//  EventDetailsVC.swift
//  Bredge
//
//  Created by Magenta on 18/09/22.
//

import UIKit
import ImageSlideshow
class EventDetailsVC: UIViewController {
    
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventTypeLable: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var eventDateLable: UILabel!
    @IBOutlet weak var eventNameLable: UILabel!
    @IBOutlet var slideshow: ImageSlideshow!
    //MARK: - Properties
    let localSource = [BundleImageSource(imageString: "img1")]
    
    var eventData : DataObject? {
        didSet{
            
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.slideShowImage()
        // Do any additional setup after loading the view.
    }
    
    func slideShowImage()  {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.init(hexString: "#A740E4")
        pageIndicator.pageIndicatorTintColor =  UIColor.lightGray
        slideshow.pageIndicator = pageIndicator
        slideshow.slideshowInterval = 2.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
      
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.delegate = self

        if let img = self.eventData?.event_image {
            var imgSrc = [BundleImageSource]()
            let arr = img.components(separatedBy: ",")
            arr.forEach{ i in
                imgSrc.append(BundleImageSource(imgUrl: URL(string: "http://bregeapptest.in/public/events/\(i)")!))
            }
            slideshow.setImageInputs(imgSrc)
        }else{
            slideshow.setImageInputs(localSource)
        }
        
        self.eventNameLable.text = self.eventData?.event_name
        self.eventDateLable.text = self.eventData?.event_date
        self.eventTypeLable.text = self.eventData?.event_type
        self.eventDescription.text = self.eventData?.description
        self.userNameLable.text = "\(self.eventData?.first_name ?? "")  \(self.eventData?.last_name ?? "")"
        self.locationLable.text = self.eventData?.location
        if let i = self.eventData?.profile_img, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(i)") {
            self.getProfileData(from: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async() {
                        let image = UIImage(named:"profileImg")
                        self.profileImageView.image = image
                       
                    }
                    return
                }
                DispatchQueue.main.async() {
                    self.profileImageView.image = UIImage(data: data)
                    
                }
            }
        }
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(EventDetailsVC.didTap))
//        slideshow.addGestureRecognizer(recognizer)
    }
    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
    func getProfileData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


extension EventDetailsVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
