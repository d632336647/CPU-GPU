import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import "UIFrame/TechDark/"

import "UIFrame/TechDark/Styles.js" as FlatDark
import "Skin.js" as Skin

Item{
    id: rootBorder
    width: 1440+20
    height: 900+20
    property var stateError: ""

    Rectangle{
        id:rootShadow
        anchors.centerIn: parent
        width: parent.width - 20
        height: parent.height - 20
        color: FlatDark.MainBgColor
        border.color: FlatDark.WindowShadowColor
        z:1
    }
    Glow {
        id:windShadow
        source: rootShadow
        anchors.fill: rootShadow
        cached: true
        fast: true
        radius: 13
        samples: 25
        color: "black"
        spread: 0
    }

    Rectangle{
         id:roots
         anchors.centerIn: parent
         width: rootShadow.width - 2
         height: rootShadow.height - 2
         color: FlatDark.MainBgColor
         z:2
         WindTitle{
             id:windTitle
             anchors.top: parent.top
             height: 32
             btnWidth: 32
             btnHeight: 32
             btnIconSize: 16
             onWindowMoved: {
                 rootWindow.setX(rootWindow.x+offset.x) //rootWindow main.cpp导入的view对象
                 rootWindow.setY(rootWindow.y+offset.y)
             }
             onClosed:{
                 glMessageBox.showMessage("ask","确认退出?", exitApp)
             }
             onNormal: {
                 rootWindow.showNormal()
                 root.width = rootShadow.width - 2
                 root.height = rootShadow.height - 2
                 windShadow.visible = true
             }
             onMaximized: {
                 windShadow.visible = false
                 rootWindow.showMaximized()
                 root.width = rootBorder.width
                 root.height = rootBorder.height

             }
             onMinimized: {
                 rootWindow.showMinimized()
             }

         }

         Rectangle{
             id:topLine
             anchors.top: windTitle.bottom
             color: FlatDark.MainBgColor
             width: parent.width
             height: 1
         }

         LeftMenu{
             id:leftMenu
             x:0
             y:windTitle.height+topLine.height
             height: parent.height-y
             width: 180
             state: "SHOW"
             onCurrentIndexChanged:
             {
                 windowLoader.source = ""
                 windowLoader.visible= false
                 k7demo.visible = false
                 switch(currentIndex)
                 {
                 case 0:
                     k7demo.visible = true
                     break;
                 case 1:
                     windowLoader.source = "PageSignalAnalyse.qml"
                     windowLoader.visible= true
                     break;
                 case 2:
                     windowLoader.source = "PageSysOverview.qml"
                     windowLoader.visible= true
                     break;
                 case 3:
                     windowLoader.source = "GpuInfo.qml"
                     windowLoader.visible= true
                     break;
                 default:
                     break;
                 }
             }

         }//end leftMenu

         //动态加载
         Item {
             id:rightWindow
             anchors.top: topLine.bottom
             anchors.left: leftMenu.right
             anchors.right: parent.right
             anchors.bottom: stateWindow.top
             Loader {
                 id: windowLoader
                 anchors.fill: parent
                 focus: true
                 onLoaded: {
                     focus = true
                 }
             }
             PageK7Demo {
                 id: k7demo
                 anchors.fill: parent
                 visible: true
             }
         }


         Rectangle{
             id:stateWindow
             anchors.bottom: parent.bottom
             anchors.left: leftMenu.right
             anchors.right: parent.right
             height: 32
             color: FlatDark.SecondBgColor

             Rectangle{
                 anchors.left: parent.left;
                 anchors.top: parent.top
                 width: 1
                 height: parent.height
                 color: FlatDark.MainBgColor
             }
             Text {
                 id: stateText
                 anchors.left: parent.left
                 anchors.leftMargin: 10
                 text: rootBorder.stateError
                 verticalAlignment: Text.AlignVCenter
                 font.family: FlatDark.fontFamily
                 font.pixelSize: FlatDark.mainFontSize
                 height: parent.height
                 color: "white"
             }
         }

         Rectangle {
             id: glMask
             anchors.fill: parent
             visible: glMessageBox.visible
             color: "#80000000"
             MouseArea{
                 anchors.fill: parent
                 hoverEnabled: true
                 onEntered: {}
                 onExited: {}
             }
         }
         MessageBox{
             id:glMessageBox
             //anchors.centerIn: parent //要使用drag, 就不能使用anchors锚定位置
             x:0.5*(parent.width-width)
             y:0.5*(parent.height-height)
             width: 400
             height: 180
             //visible: false
         }


         Component.onCompleted: {

         }


    }///end root

    function exitApp()
    {
        k7demo.safeClean()
        Qt.quit()
    }
}
