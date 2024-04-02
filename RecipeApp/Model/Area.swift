//
//  Area.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import Foundation

struct Area {

    // MARK: Variables
    let name: String

    var imageURL = {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }()

    // MARK: Image Dictonary
    let imageDictionary: [String: String] = [
        "American": "https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg",
        "British": "https://www.themealdb.com/images/media/meals/utxryw1511721587.jpg",
        "Canadian": "https://www.themealdb.com/images/media/meals/uuyrrx1487327597.jpg",
        "Chinese": "https://www.themealdb.com/images/media/meals/1525876468.jpg",
        "Croatian": "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg",
        "Dutch": "https://www.themealdb.com/images/media/meals/lhqev81565090111.jpg",
        "Egyptian": "https://www.themealdb.com/images/media/meals/kcv6hj1598733479.jpg",
        "Filipino": "https://www.themealdb.com/images/media/meals/4pqimk1683207418.jpg",
        "French": "https://www.themealdb.com/images/media/meals/wrpwuu1511786491.jpg",
        "Greek": "https://www.themealdb.com/images/media/meals/k29viq1585565980.jpg",
        "Indian": "https://www.themealdb.com/images/media/meals/wuxrtu1483564410.jpg",
        "Irish": "https://www.themealdb.com/images/media/meals/sxxpst1468569714.jpg",
        "Italian": "https://www.themealdb.com/images/media/meals/0jv5gx1661040802.jpg",
        "Jamaican": "https://www.themealdb.com/images/media/meals/tytyxu1515363282.jpg",
        "Japanese": "https://www.themealdb.com/images/media/meals/g046bb1663960946.jpg",
        "Kenyan": "https://www.themealdb.com/images/media/meals/cuio7s1555492979.jpg",
        "Malaysian": "https://www.themealdb.com/images/media/meals/wai9bw1619788844.jpg",
        "Mexican": "https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg",
        "Moroccan": "https://www.themealdb.com/images/media/meals/qtwtss1468572261.jpg",
        "Polish": "https://www.themealdb.com/images/media/meals/7mxnzz1593350801.jpg",
        "Portuguese": "https://www.themealdb.com/images/media/meals/hglsbl1614346998.jpg",
        "Russian": "https://www.themealdb.com/images/media/meals/oe8rg51699014028.jpg",
        "Spanish": "https://www.themealdb.com/images/media/meals/quuxsx1511476154.jpg",
        "Thai": "https://www.themealdb.com/images/media/meals/sstssx1487349585.jpg",
        "Tunisian": "https://www.themealdb.com/images/media/meals/t8mn9g1560460231.jpg",
        "Turkish": "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
        "Unknown": "https://www.themealdb.com/images/media/meals/n7qnkb1630444129.jpg",
        "Vietnamese": "https://www.themealdb.com/images/media/meals/qqwypw1504642429.jpg"
    ]

    // MARK: Lifecycle
    init(name: String) {
        self.name = name
        if let imageURL = imageDictionary[name] {
            self.imageURL = URL(string: imageURL)
        }
    }
}

// MARK: Mock
extension Area {
    public static func mock() -> [Area] {
        return [
            Area(name: "American"),
            Area(name: "British"),
            Area(name: "Indian")
        ]
    }
}
