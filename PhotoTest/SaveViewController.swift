//
//  SaveViewController.swift
//  PhotoTest
//
//  Created by 黒川龍之介 on 2023/01/12.
//

//参考記事　写真のアプリ（https://softmoco.com/basics/swift-how-to-save-image-file-to-document-directory.php）
//パスをRealmに保存する処理（https://zenn.dev/kazushino/articles/90bafb36f07fb2）

import UIKit
import RealmSwift

class SaveViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    let realm = try! Realm()
    let photo = Photo()
    
    var sendImage: UIImage?
    var imageName: String!
    
    //ドキュメントディレクトリの「ファイルURL」（URL型）定義
    var directoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    // ドキュメントディレクトリの「パス」（String型）定義
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = sendImage
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Save(_ sender: Any) {
        imageName = textField.text
        if imageName == "" {
            let alert = UIAlertController(title: "No Nmae", message: "Please insert the name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }else{
            saveImage()
            photo.photoName = imageName
            do {
                try photo.fileName = directoryFileURL.absoluteString
            }catch{
                //保存が失敗したときのアラート
                let alert = UIAlertController(title: "Cannot Save the IMage", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            
            //Realmへの保存
            try! realm.write {
                realm.add(photo)
            }
            print(photo)
            self.dismiss(animated: true)
        }
    }
    
    
    //保存するためのパスを作成する
    func createLocalDataFile() {
        // 作成するテキストファイルの名前
        let fileName = "\(NSUUID().uuidString).png"
        print(fileName)
        
        // DocumentディレクトリのfileURLを取得
        if directoryFileURL != nil {
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = directoryFileURL.appendingPathComponent(fileName)
            directoryFileURL = path
        }
    }
    
    //画像を保存する関数の部分
    func saveImage() {
        createLocalDataFile()
        //pngで保存する場合
        let pngImageData = imageView.image?.pngData()
        do {
            try pngImageData!.write(to: directoryFileURL)
        } catch {
            //エラー処理
            print("エラー")
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
