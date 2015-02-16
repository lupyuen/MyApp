import UIKit

class MyCode {
    func button1IsPressed(myScreen: MyScreen) {
        myScreen.label1.text =
            "eat"
            + space
            + myScreen.textbox1.text
    }

    func button2IsPressed(myScreen: MyScreen) {
        myScreen.label2.text =
            "fly"
            + space
            + myScreen.textbox2.text
    }

    func button3IsPressed(myScreen: MyScreen) {
        myScreen.label3.text =
            "run"
            + space
            + myScreen.textbox3.text
    }

    func button4IsPressed(myScreen: MyScreen) {
        myScreen.label4.text =
            "jump"
            + space
            + myScreen.textbox4.text
    }

    
    /*
    func magicStickerIsNear(myScreen: MainViewController,
        stickerNumber: String) {
        myScreen.result1.text =
            "You are near magic sticker "
            + stickerNumber
    }
    */

    let space = " "
    
    
}
