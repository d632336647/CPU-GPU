import QtQuick 2.0
import "Styles.js" as TechDark

//自定义标题栏
Rectangle {
    id: root                            //创建标题栏
    anchors.top: parent.top             //对标题栏定位
    anchors.left: parent.left
    anchors.right: parent.right
    height: 32                          //设置标题栏高度
    color: TechDark.WindowTitleBgColor  //设置标题栏背景颜色
    border.color: TechDark.WindowTitleBgColor
    property bool  isShowMaximized: false
    property alias source:titleIcon.source
    property alias text:titleText.text
    property int   btnWidth: 32
    property int   btnHeight: 32
    property int   btnIconSize: 18
    property point offset: Qt.point(0, 0)

    signal  windowMoved()
    signal  closed()
    signal  normal()
    signal  maximized()
    signal  minimized()

    MouseArea {
        id: dragRegion
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos = Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged: {
            offset = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            windowMoved()
        }
    }
    Image{
        id:titleIcon
        height: parent.height * 0.7
        width: 36
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.15
        //source: "qrc:/rc/image/app.ico"
        fillMode: Image.PreserveAspectFit
    }
    Text{
        id:titleText
        color:"#d0d0d0"
        font.family: "幼圆"
        font.pixelSize: 18
        text: "GPU参数估计"
        height: parent.height * 0.7
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.2
        anchors.left: titleIcon.right
    }
    Rectangle{
        id:closeBtn
        width: btnWidth
        height: btnHeight
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        color:root.color
        Text{
            font.family: "themify"
            color:"#BEC0C2"
            font.pixelSize: btnIconSize
            text: "\ue646"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
            {
                closed();
            }
            onEntered:
            {
                pressedAnim.start()
                releasedAnim.stop()
            }
            onExited:
            {
                releasedAnim.start()
                pressedAnim.stop()
            }
            PropertyAnimation {
                id: pressedAnim;
                target: closeBtn;
                property: "color";
                to: "#aaff0000";
                duration: 200
            }
            PropertyAnimation {
                id: releasedAnim;
                target: closeBtn;
                property: "color";
                to: root.color
                duration: 200
            }
        }
    }//!--closeBtn End


    Rectangle{
        id:maxBtn
        width: btnWidth
        height: btnHeight
        anchors.right: closeBtn.left
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        color:root.color
        Text{
            id:maxBtnIcon
            font.family: "themify"
            color:"#BEC0C2"
            font.pixelSize: btnIconSize
            text: "\ue6ab"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
            {
                if(root.isShowMaximized)
                {
                    root.isShowMaximized = false
                    maxBtnIcon.text =  "\ue6ab"
                    normal()
                }
                else
                {
                    root.isShowMaximized = true
                    maxBtnIcon.text =  "\ue62f"
                    maximized()
                }
            }
            onEntered:
            {
                pressedMaxBtnAnim.start()
                releasedMaxBtnAnim.stop()
            }
            onExited:
            {
                releasedMaxBtnAnim.start()
                pressedMaxBtnAnim.stop()
            }
            PropertyAnimation {
                id: pressedMaxBtnAnim;
                target: maxBtn;
                property: "color";
                to: "#404244";
                duration: 200
            }
            PropertyAnimation {
                id: releasedMaxBtnAnim;
                target: maxBtn;
                property: "color";
                to: root.color
                duration: 200
            }
        }
    }//!--maxBtn End


    Rectangle{
        id:minBtn
        width: btnWidth
        height: btnHeight
        anchors.right: maxBtn.left
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        color:root.color
        Text{
            font.family: "themify"
            color:"#BEC0C2"
            font.pixelSize: btnIconSize
            text: "\ue622"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
            {
                minimized()
            }
            onEntered:
            {
                pressedMinBtnAnim.start()
                releasedMinBtnAnim.stop()
            }
            onExited:
            {
                releasedMinBtnAnim.start()
                pressedMinBtnAnim.stop()
            }
            PropertyAnimation {
                id: pressedMinBtnAnim;
                target: minBtn;
                property: "color";
                to: "#404244";
                duration: 200
            }
            PropertyAnimation {
                id: releasedMinBtnAnim;
                target: minBtn;
                property: "color";
                to: root.color
                duration: 200
            }
        }
    }//!--minBtn end
}
