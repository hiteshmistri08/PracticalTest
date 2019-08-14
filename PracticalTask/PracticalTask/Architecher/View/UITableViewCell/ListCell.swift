//
//  ListCell.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import UIKit
import SDWebImage

class ListCell: UITableViewCell {

    @IBOutlet weak var img_media: UIImageView!
    @IBOutlet weak var lblMediaTitle: UILabel!
    @IBOutlet weak var lblMediaTypeAndDate: UILabel!
    @IBOutlet weak var lblMediaDescription: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(theModel:MediaList,mediaType:MediaType) {
        img_media.sd_setImage(with: URL.init(string: theModel.artworkUrl100))
        lblMediaTitle.text = theModel.artistName
        lblMediaDescription.text = theModel.longDescription
        lblCost.text = "$ \(theModel.trackPrice)"
        var mediaTime = theModel.primaryGenreName
        
        let trackTime = Double(theModel.trackTimeMillis).stringTime
        
        if !trackTime.isEmpty {
            mediaTime += " | "
            mediaTime += trackTime.replacingOccurrences(of: ",", with: "")
        }
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let yearDate = dateFormate.date(from: theModel.releaseDate) {
            dateFormate.dateFormat = "yyyy"
            mediaTime += " | "
            mediaTime += dateFormate.string(from: yearDate)
        }
        
        lblMediaTypeAndDate.text = mediaTime
    
        
    }
    
}
