//
//  VideoGalleryViewController.swift
//  testVideoGallery
//
//  Created by pcg on 2023/6/5.
//

import UIKit
import AVKit
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
        guard let url = URL(string: "https://rr1---sn-i3b7knld.googlevideo.com/videoplayback?expire=1686124033&ei=oeF_ZNfZLMSD4gHnlZToDg&ip=31.171.154.75&id=o-AMiJWA3RjJP6phYzZlLQ7zOsSPgnNNLSiN_U75NWp0HT&itag=18&source=youtube&requiressl=yes&spc=qEK7B5DYJaq82sJRRITJ76tl3J_xswSiK1FVk1obwg&vprv=1&svpuc=1&mime=video%2Fmp4&ns=nzMvk1UWjT9Wv294b75l3oEN&gir=yes&clen=57990994&ratebypass=yes&dur=890.740&lmt=1683915337434589&fexp=24007246,51000012,51000022&c=WEB&txp=5538434&n=kt0hmsR1fvj1hA&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAP5M3rrDAXovCtiIxp3nAa9WQDKj-0KBYgDufrR_lvFMAiAVKkNSfQbmBN4lnYRBakTP9NihXrnrH6DVdTUffX5EKA%3D%3D&rm=sn-5cjvh-up5z7e,sn-nv4sr7l&req_id=5b53e12116f0a3ee&cmsv=e&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=a2&mip=203.91.85.202&mm=29&mn=sn-i3b7knld&ms=rdu&mt=1686102061&mv=m&mvi=1&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRgIhAOLuKTS0e6rQzO8mGUQejtLGHFGuohQEmis3B_d1viS9AiEA8w3x4QXjvOwxYVFdgfiUqtINsniiq7Zn9_pPGRkHp2Y%3D") else {
                    return
                }
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                let player = AVPlayer(url: url)
                let controller = AVPlayerViewController()
                controller.player = player
                present(controller, animated: true) {
                    player.play()
                }
    }
}

