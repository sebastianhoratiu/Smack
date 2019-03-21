//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Sebastian Horatiu on 15/07/2018.
//  Copyright © 2018 Sebastian Horatiu. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    var avatarType: AvatarType = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print("***** Presenting view controller: \(presentingViewController?.title) *****")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        
        let padding: CGFloat = 2 * 20 // corresponding to the insets on both sides
        let spaceBetweenCells: CGFloat = 10
        
        // We will substract all the spaces from the width of the collection view
        // and then devide the remaining width to the desired number of columns
        // and this will give use the width of each cell
        let cellDimension =
            (
                collectionView.bounds.width
                - padding
                - ((numberOfColumns - 1) * spaceBetweenCells) // total space between cells
            )
            / numberOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let updateProfileVC = presentingViewController as! UpdateProfileVC? else { return }
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
            updateProfileVC.userImg.image = UIImage(named: UserDataService.instance.avatarName)
            print("***** Avatar name: \(UserDataService.instance.avatarName)) *****")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
            updateProfileVC.userImg.image = UIImage(named: UserDataService.instance.avatarName)
            print("***** Avatar name: \(UserDataService.instance.avatarName)) *****")
        }
        dismiss(animated: true, completion: nil)
    }
    

    //MARK: Actions
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
