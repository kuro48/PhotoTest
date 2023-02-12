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
        print("aaa")
        print(findPhoto)
        
        //URL型にキャスト
        let fileURL = URL(string: findPhoto[0].fileName)
        print(fileURL)
        //パス型へ変換
        let filePath = fileURL?.path
        print(filePath)
        print(type(of: filePath))
        
        //このしたで上手くファイルが取得できてないっぽい、、、
        if FileManager.default.fileExists(atPath: filePath!) {
            
            if let imageData = UIImage(contentsOfFile: filePath!) {
                imageView.image = imageData
            }else {
                print("Failed to load the image.")
            }
            
        }else {
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
