//
//  RoomLayoutViewController.swift
//  iSpring_Fair_2015
//
//  Created by Samer Salib on 3/5/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit

class RoomLayoutViewController: UIPageViewController {
    var itemIndex: Int = 0
    var layoutImageName: String = ""
    @IBOutlet var layoutImageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var layoutImageName:
    didSet {
    
    if let imageView = contentImageView {
    imageView.image = UIImage(named: imageName)
    }
    
    }
}

// MARK: - View Lifecycle
override func viewDidLoad() {
    super.viewDidLoad()
    contentImageView!.image = UIImage(named: imageName)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
