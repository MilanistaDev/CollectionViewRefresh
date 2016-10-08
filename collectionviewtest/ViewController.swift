//
//  ViewController.swift
//  collectionviewtest
//
//  Created by CatenaRentalSystem on 2016/06/20.
//  Copyright © 2016年 CatenaRentalSystem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var metroCollectionView: UICollectionView!

    // 路線選択用のランダムナンバー
    var randamNum = 0
    
    private let LineNameArray = ["銀座線", "東西線", "半蔵門線"]
    private let GinzaLineStNameArray = ["渋谷", "表参道", "青山一丁目", "外苑前", "赤坂見附",
                                "溜池山王", "虎ノ門", "新橋", "銀座", "京橋",
                                "日本橋", "三越前", "神田", "末広町", "上野広小路",
                                "上野", "稲荷町", "田原町", "浅草"]

    private let TozaiLineStNameArray = ["中野", "落合","高田馬場", "早稲田", "神楽坂",
                                "飯田橋", "九段下", "竹橋", "大手町", "日本橋",
                                "茅場町", "門前仲町", "木場", "東陽町", "南砂町",
                                "西葛西", "葛西", "浦安", "南行徳", "行徳",
                                "妙典", "原木中山", "西船橋"]

    private let HanzomonLineStNameArray = ["渋谷", "表参道", "青山一丁目", "永田町", "半蔵門",
                                   "九段下", "神保町", "大手町", "三越前", "水天宮前",
                                   "清澄白河", "住吉", "錦糸町","押上"]

    // UIRefreshControl 初期化
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.metroCollectionView.delegate = self
        self.metroCollectionView.dataSource = self

        // セルのサイズの推定
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize

        // UIRefreshControl の設定
        self.refreshControl.addTarget(self, action: #selector(refreshTrainData),
                                 for: .valueChanged)
        self.metroCollectionView.refreshControl = self.refreshControl

        // iOS 9 以下は別の方法で更新する
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh,
                                                              target: self,
                                                              action: #selector(refreshTrainData))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.randamNum = (Int)(arc4random_uniform(3))
        self.navigationItem.title = self.LineNameArray[self.randamNum]
        self.metroCollectionView.reloadData()
    }

    func refreshTrainData() {
        self.randamNum =  (Int)(arc4random_uniform(3))
        self.navigationItem.title = self.LineNameArray[self.randamNum]
        self.metroCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.randamNum {
        case 0:
            return self.GinzaLineStNameArray.count
        case 1:
            return self.TozaiLineStNameArray.count
        case 2:
            return self.HanzomonLineStNameArray.count
        default:
            return self.HanzomonLineStNameArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MetroViewCell = self.metroCollectionView.dequeueReusableCell(withReuseIdentifier: "MetroViewCell", for: indexPath) as! MetroViewCell
        
        switch self.randamNum {
        case 0:
            self.navigationController?.navigationBar.barTintColor = UIColor.GinzaLineColor()
            cell.stationNum.text = String(format: "G%d", indexPath.row + 1)
            cell.stationName.text = self.GinzaLineStNameArray[indexPath.row]
            cell.backgroundColor = UIColor.ClearGinzaLineColor()
        case 1:
            self.navigationController?.navigationBar.barTintColor = UIColor.TozaiLineColor()
            cell.stationNum.text = String(format: "T%d", indexPath.row + 1)
            cell.stationName.text = self.TozaiLineStNameArray[indexPath.row]
            cell.backgroundColor = UIColor.ClearTozaiLineColor()
        case 2:
            self.navigationController?.navigationBar.barTintColor = UIColor.HanzomonLineColor()
            cell.stationNum.text = String(format: "Z%d", indexPath.row + 1)
            cell.stationName.text = self.HanzomonLineStNameArray[indexPath.row]
            cell.backgroundColor = UIColor.ClearHanzomonLineColor()
        default:
            self.navigationController?.navigationBar.barTintColor = UIColor.red
            cell.stationNum.text = ""
            cell.stationName.text = ""
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/**
 * UIColor の Extension
 */
extension UIColor {

    class func GinzaLineColor() -> UIColor {
        return UIColor(red: 243.0/255.0, green: 151.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    class func ClearGinzaLineColor() -> UIColor {
        return UIColor(red: 243.0/255.0, green: 151.0/255.0, blue: 0.0/255.0, alpha: 0.1)
    }
    class func TozaiLineColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 167.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    }
    class func ClearTozaiLineColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 167.0/255.0, blue: 219.0/255.0, alpha: 0.1)
    }
    class func HanzomonLineColor() -> UIColor {
        return UIColor(red: 155.0/255.0, green: 124.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    }
    class func ClearHanzomonLineColor() -> UIColor {
        return UIColor(red: 155.0/255.0, green: 124.0/255.0, blue: 182.0/255.0, alpha: 0.1)
    }
}
