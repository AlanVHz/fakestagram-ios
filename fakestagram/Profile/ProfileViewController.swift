//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by Alan Vargas on 3.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var previewCollectionPosts: UICollectionView!
    
    var posts: [Post] = []
    
    let client = ProfilePostsClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegatesAndXib()
        getProfileInfo()
        
        client.show { [weak self] posts in
            self?.posts = posts
            self?.previewCollectionPosts.reloadData()
        }
    }
    
    func getProfileInfo() {
        guard let account =  AccountRepo.shared.load() else { return }
        authorView.author = account.toAuthor()
    }
    
    func delegatesAndXib() {
        previewCollectionPosts.delegate = self
        previewCollectionPosts.dataSource = self
    
        let postThumbnailCell = UINib(nibName: String(describing: PostThumbnailCollectionViewCell.self), bundle: nil)
        previewCollectionPosts.register(postThumbnailCell, forCellWithReuseIdentifier: PostThumbnailCollectionViewCell.reuseIdentifier)
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = previewCollectionPosts.frame.width / 3.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as! PostThumbnailCollectionViewCell
        cell.post = posts[indexPath.row]
        cell.backgroundColor = .red
       
        return cell
    }
}
