import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import "UIFrame/TechDark/"

import "UIFrame/TechDark/Styles.js" as FlatDark
import "Skin.js" as Skin

Item{
     id:root
     width: 180
     height: 400
     state: "SHOW"

     property int currentIndex: 2

     Rectangle{
         anchors.fill: parent
         color: Skin.LeftMenuBgColor
         Column{
             id:leftMenuBtns
             anchors.fill: parent
             ButtonSM{
                 visible: false
                 id:menuBtn1
                 width: parent.width
                 height: 100
                 anchors.horizontalCenter: parent.horizontalCenter
                 fontSize: 16
                 text: ""
                 objectName: "MenuButtonSM"
                 Column{
                     anchors.centerIn: parent
                     width: parent.width
                     height: 0.6*parent.height
                     Text{
                         //anchors.leftMargin: iw
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: "themify"
                         color:FlatDark.fontColor
                         font.pixelSize: 40
                         text: "\ue633"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                     Text{
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: FlatDark.fontFamily
                         color:FlatDark.fontColor
                         font.pixelSize: 16
                         text: "参数设置"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                 }
                 onClicked: {
                     leftMenuBtns.menuSelect(menuBtn1)
                     currentIndex = 0
                 }
             }
             ButtonSM{
                 visible: false
                 id:menuBtn2
                 width: menuBtn1.width
                 height: menuBtn1.height
                 anchors.horizontalCenter: parent.horizontalCenter
                 fontSize: 16
                 text: ""
                 objectName: "MenuButtonSM"
                 Column{
                     anchors.centerIn: parent
                     width: parent.width
                     height: 0.6*parent.height
                     Text{
                         //anchors.leftMargin: iw
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: "themify"
                         color:FlatDark.fontColor
                         font.pixelSize: 40
                         text: "\ue60f"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                     Text{
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: FlatDark.fontFamily
                         color:FlatDark.fontColor
                         font.pixelSize: 16
                         text: "系统设置"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                 }
                 onClicked: {
                     leftMenuBtns.menuSelect(menuBtn2)
                     currentIndex = 1
                 }
             }
             ButtonSM{
                 id:menuBtn3
                 width: menuBtn1.width
                 height: menuBtn1.height
                 anchors.horizontalCenter: parent.horizontalCenter
                 fontSize: 16
                 text: ""
                 objectName: "MenuButtonSM"
                 Column{
                     anchors.centerIn: parent
                     width: parent.width
                     height: 0.6*parent.height
                     Text{
                         //anchors.leftMargin: iw
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: "themify"
                         color:FlatDark.fontColor
                         font.pixelSize: 40
                         text: "\ue60f"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                     Text{
                         height: 0.5*parent.height
                         width: parent.width
                         font.family: FlatDark.fontFamily
                         color:FlatDark.fontColor
                         font.pixelSize: 16
                         text: "系统状态"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                 }
                 onClicked: {
                     leftMenuBtns.menuSelect(menuBtn3)
                     currentIndex = 2
                 }
             }
             function menuSelect(self)
             {
                 var list = leftMenuBtns.children;
                 for ( var i in list) {
                     if( (list[i].objectName === "MenuButtonSM") )
                     {
                         if(list[i] !== self)
                             list[i].cancleSelect()
                         else
                             list[i].setSelect()
                     }
                 }
             }

         }//end Column

     }//end Rectangle

     //过渡动画
     states: [
         State {
             name: "HIDE"
             PropertyChanges { target: leftMenu; x: -0.1*root.width}
             onCompleted:{

             }
         },
         State {
             name: "SHOW"
             PropertyChanges { target: leftMenu; x: 0}
             onCompleted: {

             }
         }
     ]

     transitions: [
          Transition {
              from: "SHOW"
              to: "HIDE"
              PropertyAnimation { properties: "x"; duration: 1000; easing.type: Easing.OutExpo }
          },
          Transition {
              from: "HIDE"
              to: "SHOW"
              PropertyAnimation { properties: "x"; duration: 1000; easing.type: Easing.OutExpo }//OutCubic
          }
     ]


     Component.onCompleted: {
         var btns = [menuBtn1,menuBtn2,menuBtn3]
         leftMenuBtns.menuSelect(btns[currentIndex])
     }

}
