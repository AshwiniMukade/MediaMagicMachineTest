//
//  ViewController.swift
//  MediaMagicMachineTest
//
//  Created by Ashwini Mukade on 28/02/20.
//  Copyright © 2020 Ashwini Mukade. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{

    var picSumModel = [picsum]()
    var picsumCollection:UICollectionView!
    let cellId = "cellId"
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpActivityIndicator()
        self.loadCollectionView()
        self.setUpCollectionView()
    }
    
//UI SetUP With Functions (ActivityView, CollectionView) ........
    func setUpActivityIndicator(){
        self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = UIColor.gray
    }
    
    func setUpCollectionView(){
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
        label.text = "Lorem Pecsum"
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        var width = self.view.frame.size.width / 2
        width = width - 20
        layout.itemSize = CGSize(width: width, height: width)
              
        picsumCollection = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-10), collectionViewLayout: layout)
        picsumCollection.dataSource = self
        picsumCollection.delegate = self
        picsumCollection.register(CustomeCell.self, forCellWithReuseIdentifier: cellId)
        picsumCollection.backgroundColor = UIColor.white
        self.view.addSubview(label)
        self.view.addSubview(picsumCollection)
        self.view.addSubview(activityIndicator)
    }
    
//Calling Web Data For Updating UI
    func loadCollectionView(){
           self.activityIndicator.startAnimating()
           self.webServiceCallWithResponse(strUrl: "https://picsum.photos/list") { (response) in
               if response != nil{
                   print("yes i got it")
                   let arrayPicsum = response as! NSArray
                   for item in arrayPicsum {
                       let indexItem = item as! NSDictionary
                       var modelPicsum = picsum()
                      // var picsumModel = picsum(image: "https://picsum.photos/300/300?image=\(indexItem.object(forKey: "id") as? String ?? "")", author: indexItem.object(forKey: "author") as? String ?? "")
                       modelPicsum.image = "https://picsum.photos/300/300?image=\(indexItem.object(forKey: "id") as? String ?? "")"
                       modelPicsum.author =  indexItem.object(forKey: "author") as? String ?? ""
                       self.picSumModel.append(modelPicsum)
                   }
                   DispatchQueue.main.async {
                       self.picsumCollection.reloadData()
                       self.activityIndicator.stopAnimating()
                   }
               }
           }
       }
    
//CollectionView Delegates and Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picSumModel.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = picsumCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomeCell
        
        let modelPicsum = picSumModel[indexPath.row] as! picsum
        
        let imageURL:URL=URL(string: modelPicsum.image!)!
        let data=NSData(contentsOf: imageURL)
        
        DispatchQueue.main.async {
            cell.textLabel.text = modelPicsum.author!
            if let dataa = data{
                cell.imageView.image = UIImage(data: dataa as Data)
            }
        }
          return cell
      }
    
//Changing Device Orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                self.setUpCollectionView()
                self.picsumCollection.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
}

