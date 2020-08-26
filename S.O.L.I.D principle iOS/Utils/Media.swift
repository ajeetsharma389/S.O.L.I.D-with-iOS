//
//  Media.swift
//  S.O.L.I.D principle iOS
//
//  Created by Ajeet on 27/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//
/*
 The Interface Segregation Principle (ISP)
 "Clients should not be forced to depend upon interfaces that they do not use."
                                    or
 "It says “many specific interfaces are better than a general interface”.
*/

// Problem

/*
 This principle introduces one of the problems of object-oriented programming: the fat interface.

A interface is called “fat” when has too many members/methods, which are not cohesive and contain more information than we really want. This problem can affect both classes and protocols.
 */
import UIKit
class Media {

    var title: String = "Discovery Video"
    var description: String = "This is a beautiful video"
    var author: String = "David John"
    var url: String = "https://www.youtube.com/watch?v=wc7i-1zm-Mk"
    var duration: Int = 60
    var created = Date()
}
//And we inject it in the video player:
class MediaPlayer {
    
    func play(video: Media) {
        // load the player UI
        // load the content at video.url
        // add video.title to the player UI title
        // update the player scrubber with video.duration
    }
}

// #########  Unfortunately, we are injecting too much information in the method play, since it needs just url, title and duration.
//////######

// Solution:
// You can solve this problem using a protocol Playable with just the information the player needs.
protocol Playable {
    var title: String { get }
    var url: String { get }
    var duration: Int { get }
}
class Media: Playable {

    var title: String = "Discovery Video"
    var description: String = "This is a beautiful video"
    var author: String = "David John"
    var url: String = "https://www.youtube.com/watch?v=wc7i-1zm-Mk"
    var duration: Int = 60
    var created = Date()
}
func play(video: Playable) {
    // load the player UI
    // load the content at video.url
    // add video.title to the player UI title
    // update the player scrubber with video.duration
}
