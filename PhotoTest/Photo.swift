//
//  File.swift
//  PhotoTest
//
//  Created by 黒川龍之介 on 2023/01/12.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc dynamic var photoName = ""
    @objc dynamic var fileName = ""
}
