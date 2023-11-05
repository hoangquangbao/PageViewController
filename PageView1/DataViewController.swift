//
//  DataViewController.swift
//  PageView1
//
//  Created by Bao Hoang on 05/11/2023.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var displayLbl: UILabel!
    
    var displayText: String?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        displayLbl.text = displayText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
