//
//  LoadViewController.swift
//  PhotoTest
//
//  Created by 黒川龍之介 on 2023/01/13.
//

import UIKit
import RealmSwift

class LoadViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let realm = try! Realm()
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Load(){
        let photo = realm.objects(Photo.self)
        print(photo)
        
        //テキストフィールドで入力した名前をRealm上で検索
        name = textField.text
        let findPhoto = realm.objects(Photo.self).filter("photoName == %@", name!)
        print(findPhoto)
        
        //URL型にキャスト
        let fileURL = URL(string: findPhoto.fileName)
        //パス型へ変換
        let path = fileURL?.path
        
        if FileManager.default.fileExists(atPath: path!) {
            if let imageData = UIImage(contentsOfFile: path!) {
                imageView.image = imageData
            }
            else {
                print("Failed to load the image.")
            }
        }
        else {
            print("Image file not found.")
        }
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
