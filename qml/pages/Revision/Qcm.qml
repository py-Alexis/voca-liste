import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../"
import "../../controls/Revision"
import "../../controls/modify"
import "../"

Item{
    id: qcm


    property string toFind: ""

    property bool clickable: true

    QtObject{
        id: internal

        function colorGoodAnswer(wordClicked){
            clickable = false
            if(qcmBtn1.text === toFind){
                qcmBtn1.btnColor = accent_color
            }else if(qcmBtn2.text === toFind){
                qcmBtn2.btnColor = accent_color
            }else if(qcmBtn3.text === toFind){
                qcmBtn3.btnColor = accent_color
            }else if(qcmBtn4.text === toFind){
                qcmBtn4.btnColor = accent_color
            }
            if(displayContextLabel.text !== "false"){
                animationContext.running = true
            }
            backend.add_history(wordClicked, toFind, index)
        }
    }

     Rectangle{
         id: displayWordQcm

         color: medium_color
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.top: parent.top
         anchors.bottom: displayContextQcm.top
         anchors.bottomMargin: 0
         anchors.topMargin: 0
         anchors.rightMargin: 0
         anchors.leftMargin: 0
         radius: 5

         Label{
             id: displayWordLabel
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenter: parent.horizontalCenter

             font.pointSize: 13

             color: light_text_color
         }
     }

     Rectangle{
         id: displayContextQcm

         height: 0

         color: darker_color
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.bottom: columnBtn.top
         anchors.bottomMargin: 20
         anchors.rightMargin: 0
         anchors.leftMargin: 0
         clip: true

         Label{
             id: displayContextLabel

             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenter: parent.horizontalCenter

             text: ""

             color: medium_text_color

             font.pointSize: 13

         }
         PropertyAnimation{
             id: animationContext
             target: displayContextQcm
             property: "height"
             to: if(displayContextQcm.height === 0) return 130; else return 0
             duration: 500
             easing.type: Easing.InOutQuint
         }
     }

     Column{
         id: columnBtn
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 45
         anchors.rightMargin: 0
         anchors.leftMargin: 0

         spacing: 10

         QcmBtn{
             id: qcmBtn1

             anchors.left: parent.left
             anchors.right: parent.right
             anchors.rightMargin: 0
             anchors.leftMargin: 0
             enabled: clickable
             btnColor: medium_color
             btnTextColor: light_text_color

             text: ""

             onClicked: {
                 btnColor = darker_color // turn the button dark
                 internal.colorGoodAnswer(qcmBtn1.text) // turn the good answer green
             }
         }

         QcmBtn{
             id: qcmBtn2

             anchors.left: parent.left
             anchors.right: parent.right
             anchors.rightMargin: 0
             anchors.leftMargin: 0
             enabled: clickable
             btnColor: medium_color
             btnTextColor: light_text_color


             text: ""

             onClicked: {
                 btnColor = darker_color // turn the button dark
                 internal.colorGoodAnswer(qcmBtn2.text) // turn the good answer green
             }
         }
         QcmBtn{
             id: qcmBtn3

             anchors.left: parent.left
             anchors.right: parent.right
             anchors.rightMargin: 0
             anchors.leftMargin: 0
             enabled: clickable
             btnColor: medium_color
             btnTextColor: light_text_color

             text: ""

             onClicked: {
                 btnColor = darker_color // turn the button dark
                 internal.colorGoodAnswer(qcmBtn3.text) // turn the good answer green
             }
         }
         QcmBtn{
             id: qcmBtn4

             anchors.left: parent.left
             anchors.right: parent.right
             anchors.rightMargin: 0
             anchors.leftMargin: 0
             enabled: clickable
             btnColor: medium_color
             btnTextColor: light_text_color

             text: ""

             onClicked: {
                 btnColor = darker_color // turn the button dark
                 internal.colorGoodAnswer(qcmBtn4.text) // turn the good answer green
             }
         }

     }

     SaveBtn{
         id: nextBtn

         text: ""

         anchors.right: parent.right
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 0
         anchors.rightMargin: 0
         btnColor: accent_color
         btnTextColor: light_text_color

         visible: !clickable

         onClicked: if(index != nbWord){
                        backend.call_next_word()
                    }else{
                        stackView.replace(Qt.resolvedUrl("../../pages/ResultPage.qml"))
                        backend.finish(currentList, revisionMode, revisionDirection)
                    }

     }

     Connections{
         target: backend

         function onNew_word(info){
             if(displayWordLabel.text === ""){
                 displayWordLabel.text = info["displayWord"]
             }
             if(qcmBtn1.text === ""){
                 qcmBtn1.text = info["hint"][0]
             }
             if(qcmBtn2.text === ""){
                 qcmBtn2.text = info["hint"][1]
             }
             if(qcmBtn3.text === ""){
                 qcmBtn3.text = info["hint"][2]
             }
             if(qcmBtn4.text === ""){
                 qcmBtn4.text = info["hint"][3]
             }if(displayContextLabel.text === ""){
                 displayContextLabel.text = info["context"]
             }

             toFind = info["toFindWord"]

             if(nextBtn.text === ""){
                 if(index !=  nbWord){nextBtn.text = "Suivant"}else{nextBtn.text = "Terminer"}
             }
         }
     }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:1000;width:1000}
}
##^##*/
