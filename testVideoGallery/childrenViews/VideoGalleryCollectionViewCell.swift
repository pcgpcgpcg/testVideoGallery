//
//  VideoGalleryCollectionViewCell.swift
//  testVideoGallery
//
//  Created by mac on 2023/6/6.
//

import Foundation
import UIKit
import SDWebImage

protocol VideoGalleryCollectionViewCellDelegate: AnyObject {
    func didTapCell(_ cell: VideoGalleryCollectionViewCell, videoUrl: String?)
}

final class VideoGalleryCollectionViewCell: UICollectionViewCell {
    private var videoThumbnailView : UIImageView?
    private var videoNameLabel : UILabel?
    private var videoDownButton : UIButton?
    weak var delegate: VideoGalleryCollectionViewCellDelegate?
    var recordVideoInfo: RecordVideoInfo?

    override init(frame: CGRect) {
        super.init(frame: frame)
        //imageView
        videoThumbnailView = UIImageView(image: UIImage(named: "videobkg") ?? UIImage())
        guard let videoThumbnailView = videoThumbnailView else { return };
        contentView.addSubview(videoThumbnailView)
        videoThumbnailView.snp.makeConstraints { (maker) in
            maker.left.top.right.equalToSuperview();
            maker.height.equalToSuperview().inset(30)
        }
        //Label
        videoNameLabel = UILabel()
        guard let videoNameLabel = videoNameLabel else { return };
        videoNameLabel.text = "未找到视频"
        videoNameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(videoNameLabel)
        videoNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(videoThumbnailView.snp.bottom).offset(8)
            make.height.equalTo(videoNameLabel.intrinsicContentSize.height)
        }
        //Button
        videoDownButton = UIButton(type:.system);
        guard let videoDownButton = videoDownButton else { return };
        videoDownButton.tintColor = UIColor.black
        videoDownButton.setImage(UIImage(named: "download"), for: .normal)
        contentView.addSubview(videoDownButton)
        videoDownButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(videoThumbnailView.snp.bottom).offset(10)
            maker.right.equalToSuperview().inset(10);
            maker.width.height.equalTo(24)
            maker.bottom.equalTo(videoNameLabel.snp.bottom)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapVideoGalleryCell(_:)))
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapVideoGalleryCell(_ sender: UITapGestureRecognizer) {
        if let videoInfo = recordVideoInfo{
            delegate?.didTapCell(self, videoUrl: videoInfo.getVideoUrl())
        }
        
    }

    func update(videoInfo: RecordVideoInfo) {
        guard let videoThumbnailView = videoThumbnailView else { return };
        recordVideoInfo = videoInfo
        if let videoThumbnailUrl = videoInfo.getVideoThumbnailUrl(){
            videoThumbnailView.sd_setImage(with: URL(string: videoThumbnailUrl), placeholderImage: UIImage(named: "videobkg"));
        }
        
        guard let videoNameLabel = videoNameLabel else { return };
        if let videoStartTime =  videoInfo.getVideoStartTime(){
            videoNameLabel.text = videoStartTime;
        }
        
//        videoNameLabel.snp.remakeConstraints { (make) in
//            make.left.equalToSuperview().offset(10)
//            make.right.equalToSuperview().inset(10)
//            make.top.equalTo(videoThumbnailView.snp.bottom).offset(8)
//            make.height.equalTo(videoNameLabel.intrinsicContentSize.height)
//        }
    }
   
}
