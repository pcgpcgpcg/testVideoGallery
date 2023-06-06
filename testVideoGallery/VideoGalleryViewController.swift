//
//  VideoGalleryViewController.swift
//  testVideoGallery
//
//  Created by pcg on 2023/6/5.
//

import UIKit
import SnapKit

public class VideoGalleryViewController: UIViewController {
    
    private var videoGalleryCollectionView: UICollectionView?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView();
        
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 4;
        videoGalleryCollectionView = UICollectionView(frame:view.bounds, collectionViewLayout: layout);
        guard let videoGalleryCollectionView = videoGalleryCollectionView else{
            return;
        }
        videoGalleryCollectionView.register(VideoGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        videoGalleryCollectionView.delegate = self;
        videoGalleryCollectionView.dataSource = self;
        
        view.addSubview(videoGalleryCollectionView)
        videoGalleryCollectionView.snp.makeConstraints { (maker) in
            maker.top.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
            let wp = UILayoutPriority.required - 1
            //maker.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(-1).priority(wp)
            maker.leading.trailing.equalTo(view.safeAreaLayoutGuide).priority(wp) //TODO : 去掉-1试下
            maker.height.greaterThanOrEqualTo(videoGalleryCollectionView.snp.width).multipliedBy(9.0/16.0)
        }
    }


}

extension VideoGalleryViewController : UICollectionViewDelegate {
    
    
}

extension VideoGalleryViewController : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0);
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let lay = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 0, height: 0);
        }
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing;
        return CGSize(width: widthPerItem - 8, height: 250);
    }
}

extension VideoGalleryViewController : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath)
        if let cell = cell as? VideoGalleryCollectionViewCell{
            cell.delegate = self
            //cell.backgroundColor = .green;
            //cell.update(videoInfo: RecordVideoInfo)
        }
        return cell;
    }
}

extension VideoGalleryViewController : VideoGalleryCollectionViewCellDelegate {
    func didTapCell(_ cell: VideoGalleryCollectionViewCell) {
        //navigate to video player
    }
}

