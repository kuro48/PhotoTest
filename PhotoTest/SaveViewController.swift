//
//  SaveViewController.swift
//  PhotoTest
//
//  Created by 黒川龍之介 on 2023/01/12.
//

import UIKit
import RealmSwift

class SaveViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var sendImage: UIImage?
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = sendImage

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Save(_ sender: Any) {
        imageName = textField.text
        print(imageName)
        guard imageName == nil else{
            let alert = UIAlertController(title: "No Nmae", message: "Please insert the name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default){ (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
