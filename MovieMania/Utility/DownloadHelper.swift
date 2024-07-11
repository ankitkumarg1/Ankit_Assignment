//
//  DownloadHelper.swift
//  MovieMania
//
//  Created by neosoft on 7/11/24.
//

import UIKit

extension UIImageView {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func setImage(from url: URL,placeholder: UIImage?) {
        print("Download Started")
        self.image = placeholder
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                if let image = UIImage(data: data){
                    self?.image = image
                }else{
                    self?.image = placeholder
                }
               
            }
        }
    }
}
