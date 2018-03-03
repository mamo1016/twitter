import UIKit
import Social

class ViewController: UIViewController {
    
    var myComposeView : SLComposeViewController!
    var myTwitterButton: UIButton!
    var myFaceBookButton: UIButton!
    var myButton: UIButton!
    var twitter: Bool = false
    var faceBook: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        createTwitterButton()
        createFaceBookButton()
        createPlayButton()
    }
    
    // ボタンイベント.
    @objc func onPostToTwitter(sender : AnyObject) {
        twitter = true
    }

    // ボタンイベント.
    @objc func onPostToFaceBook(sender : AnyObject) {
        faceBook = true
    }
    
    // つぶやくボタンイベント.
    @objc func onPostTo(sender : AnyObject) {
        twitterPlay()
        
        //ツイート処理判定
        myComposeView?.completionHandler = {
            (result:SLComposeViewControllerResult) -> () in
            switch (result) {
            // 投稿した
            case SLComposeViewControllerResult.done:
                print("tweeted")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.FaceBookPlay()                    // your code here
                    self.twitter = false
                    self.faceBook = false
                    
                }
            // キャンセルした
            case SLComposeViewControllerResult.cancelled:
                print("tweet cancel")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.FaceBookPlay()                    // your code here
                    self.twitter = false
                    self.faceBook = false
                }
            }
        }
        
        if !twitter {
            FaceBookPlay()
        }
    }
    

    func twitterPlay(){
        if twitter {
            myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            // 投稿するテキストを指定.
            myComposeView.setInitialText("Twitter Test from Swift")
            // 投稿する画像を指定.
            myComposeView.add(UIImage(named: "sample.jpg"))
            // myComposeViewの画面遷移.
            self.present(myComposeView, animated: true, completion: nil)
        }
    }
    
    func FaceBookPlay(){
        if faceBook {
            // ServiceTypeをTwitterに指定.
            myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            // 投稿するテキストを指定.
            myComposeView.setInitialText("Twitter Test from Swift")
            // 投稿する画像を指定.
            myComposeView.add(UIImage(named: "sample.jpg"))
            // myComposeViewの画面遷移.
            self.present(myComposeView, animated: true, completion: nil)
        }
    }


    
    func createTwitterButton() {
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        myTwitterButton.backgroundColor = UIColor.blue
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", for: UIControlState.normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20))
        myTwitterButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myTwitterButton.layer.cornerRadius = 50.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width/4, y:self.view.frame.height/2)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: #selector(ViewController.onPostToTwitter(sender:)), for: .touchUpInside)
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
    }
    
    func createFaceBookButton() {
        myFaceBookButton = UIButton()
        myFaceBookButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        myFaceBookButton.backgroundColor = UIColor.blue
        myFaceBookButton.layer.masksToBounds = true
        myFaceBookButton.setTitle("FaceBook", for: UIControlState.normal)
        myFaceBookButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20))
        myFaceBookButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myFaceBookButton.layer.cornerRadius = 50.0
        myFaceBookButton.layer.position = CGPoint(x: self.view.frame.width/4*3, y:self.view.frame.height/2)
        myFaceBookButton.tag = 1
        myFaceBookButton.addTarget(self, action: #selector(ViewController.onPostToFaceBook(sender:)), for: .touchUpInside)
        // buttonをviewに追加.
        self.view.addSubview(myFaceBookButton)
    }
    
    func createPlayButton() {
        myButton = UIButton()
        myButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        myButton.backgroundColor = UIColor.blue
        myButton.layer.masksToBounds = true
        myButton.setTitle("つぶやく", for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20))
        myButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myButton.layer.cornerRadius = 50.0
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/4 * 3)
        myButton.tag = 1
        myButton.addTarget(self, action: #selector(ViewController.onPostTo(sender:)), for: .touchUpInside)
        // buttonをviewに追加.
        self.view.addSubview(myButton)
    }


}
