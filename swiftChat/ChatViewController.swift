//
//  ChatViewController.swift
//  swiftChat
//
//  Created by Dhwty on 03/12/2017.
//  Copyright © 2017 Dhwty. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedUser: User?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userInput: UITextField!
    var cellHeight = 44
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostManager.posts.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.fillPosts(uid: FirebaseManager.currentUser?.uid, toId: (selectedUser?.uid)!) { (result: String) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.posts = []
    }
    
    
    @IBAction func sendButton_click(_ sender: Any) {
        PostManager.addPost(username: (selectedUser?.username)!, text: userInput.text!, toId: (selectedUser?.uid)!, fromId: (FirebaseManager.currentUser?.uid)!)
        userInput.text = ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        let messageText = cell.messageText!
        messageText.delegate = self
        cellHeight = Int(messageText.contentSize.height)
        let post = PostManager.posts[indexPath.row]
        cell.messageText.text  = post.text

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}
