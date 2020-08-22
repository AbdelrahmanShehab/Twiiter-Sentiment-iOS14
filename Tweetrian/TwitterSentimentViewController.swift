//
//  ViewController.swift
//  Tweetrian
//
//  Created by Abdelrahman Shehab on 22/8/2020.
//

import UIKit
import CoreML
import SwifteriOS
import SwiftyJSON

class TwitterSentimentViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var predictButton: UIButton!

    let sentimentClassifier = try! TweetSentimentClassifier(configuration: MLModelConfiguration())

    /// Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: "xjJxM1kJzzM2bvtxS5rAl1uvv", consumerSecret: "1LfxkUiYkpHBnl9UVQdHsFB5zrYnN9XM0UiH8P0k9mKWhmIVW5")

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.setGradientBackground(colorOne: BrandColor.Blue, colorTwo: BrandColor.LightBlue)
        predictButton.setGradientBackground(colorOne: BrandColor.LightOrange, colorTwo: BrandColor.Orange)
        predictButton.layer.cornerRadius = 7
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        sender.pulsate()
        fetchTweets()
    }

    func fetchTweets() {

        if let searchField = textField.text {
            swifter.searchTweet(using: searchField, lang: "en", count: KTweet.tweetCount, tweetMode: .extended) { (results, metadata) in

                var tweets = [TweetSentimentClassifierInput]()

                for i in 0..<KTweet.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetClassifier = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetClassifier)
                    }

                    self.makePrediction(with: tweets)
                }
            } failure: { (error) in
                print("There was an error with Twitter API request, \(error)")
            }

        }
    }

    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {

        do {
            let predictions = try sentimentClassifier.predictions(inputs: tweets)
            var predictionScore = 0

            for pred in predictions {
                let sentimentScore = pred.label

                if sentimentScore == "Pos" {
                    predictionScore += 1
                }
                else if sentimentScore == "Neg"
                {
                    predictionScore -= 1
                }
            }
            self.updateUi(with: predictionScore)
        } catch {
            print("There was error with making predictions, \(error)")
        }

    }

    func updateUi(with predictionScore: Int ) {

        if predictionScore > 20
        {
            self.sentimentLabel.text = "😍"
        }
        else if predictionScore > 10
        {
            self.sentimentLabel.text = "😁"
        }
        else if predictionScore > 0
        {
            self.sentimentLabel.text = "🙂"
        }
        else if predictionScore == 0
        {
            self.sentimentLabel.text = "😐"
        }
        else if predictionScore > -10
        {
            self.sentimentLabel.text = "😕"
        }
        else if predictionScore > -20
        {
            self.sentimentLabel.text = "🤬"
        }
        else
        {
            self.sentimentLabel.text = "🤮"
        }

    }

    
}

