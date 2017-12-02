//
//  MainViewController.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

enum LayoutType: Int
{
    case Grid = 0
    case List = 1
}



class MainViewController: UIViewController {
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let showDetailSegue = "ShowDetail"
        
        static let leftAndRightPadding : CGFloat = 2.0
        static let numberOfItemsPerRowGrid : CGFloat = 3.0
    }
    var photos:[[String :Any]] = []
    var totalPage:Int = 0
    var page:Int = 1
    var pageSize:Int = 30
    var layoutType = LayoutType.Grid
    var dialogHelper: DialogHelper = DialogHelper()
    var flickrService: FlickrService = FlickrService()
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
        self.loadingActivity.startAnimating()
        self.fetchPhotos(pageSize: self.pageSize, page: self.page)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == Storyboard.showDetailSegue {
            let vc:DetailViewController = segue.destination as! DetailViewController
            let row:Int = self.collectionView.indexPathsForSelectedItems![0].row
            let photo = self.photos[row]
            let photoId = photo["id"] as! String
            let userId:String = photo["owner"] as! String
            vc.photoId = photoId
            vc.userId = userId
        }
    }
    
    private func initViewController() {
        self.loadingActivity.layer.cornerRadius = 3.0
        self.loadingActivity.layer.masksToBounds = true
    }
    
    private func showAlert(message: String) {
       dialogHelper.presentAlert(title: "Error", message: message, onAction: nil, onTopOf: self)
    }
    
    private func fetchPhotos(pageSize: Int, page: Int) {
        let request = flickrService.readPhotos(pageSize: pageSize, page: page)
        request.perform(withSuccess: { response in
            self.photos += response.photo
            self.totalPage = response.pages
            if self.loadingActivity.isAnimating {
                self.loadingActivity.stopAnimating()
            }
            self.collectionView.reloadData()
        }) { (error) in
            self.showAlert(message: "There are some problems has been occured. Please check with administrator")
            if self.loadingActivity.isAnimating {
                self.loadingActivity.stopAnimating()
            }
            debugPrint("\(error)")
        }
    }
    
    @IBAction func segmentedControlDidChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex  == 0 {
            self.layoutType = LayoutType.Grid
        } else {
            self.layoutType = LayoutType.List
        }
        
        self.collectionView.reloadData()
    }
    
    
    

}

extension MainViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCollectionViewCell
        let photoInfo = photos[indexPath.item]
        let photoUrlString:String? = (self.layoutType == LayoutType.Grid) ? photoInfo["url_z"] as? String : photoInfo["url_z"] as? String
        
        photoCell.image.sd_setImage(with: URL(string: photoUrlString ?? ""), placeholderImage: UIImage(named: "placeholder"))
    
        return photoCell;
    }
    
    
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize : CGSize
        let collectionViewWidth = collectionView.frame.width
        var itemWidth = collectionViewWidth - Storyboard.leftAndRightPadding
        if self.layoutType == LayoutType.Grid {
            itemWidth = itemWidth / Storyboard.numberOfItemsPerRowGrid
            itemSize = CGSize(width: itemWidth, height: itemWidth)
        } else {
            itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
        return itemSize
    }
}

extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSectionIndex: Int = self.collectionView.numberOfSections - 1
        let lastRowIndex: Int = self.collectionView.numberOfItems(inSection: lastSectionIndex) - 1
        if(indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex){
            if self.totalPage >= self.page {
                self.page += 1
                debugPrint("Page \(self.page)")
                self.fetchPhotos(pageSize: self.pageSize, page: self.page)
            }
        }
    }
    
    
}
