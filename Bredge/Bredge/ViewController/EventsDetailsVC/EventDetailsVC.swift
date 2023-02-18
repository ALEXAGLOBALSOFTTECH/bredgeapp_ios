//
//  EventDetailsVC.swift
//  Bredge
//
//  Created by Magenta on 18/09/22.
//

import UIKit
import ImageSlideshow
class EventDetailsVC: UIViewController {
    
    @IBOutlet var slideshow: ImageSlideshow!
    //MARK: - Properties
    let localSource = [BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img1")]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
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
      
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.delegate = self

        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)

//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(EventDetailsVC.didTap))
//        slideshow.addGestureRecognizer(recognizer)
    }
    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
}


extension EventDetailsVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
