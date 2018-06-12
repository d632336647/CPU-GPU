import QtQuick 2.0
import "Styles.js" as FlatDark

Rectangle{
    id:root
    width: 400
    height: 180
    color: FlatDark.MainBgColor
    border.color: FlatDark.WindowShadowColor
    property color iconColor: "#bec0c2"
    property int btnIconSize: 18
    signal closed()
    signal yesClicked()
    signal noClicked()
    visible: false
    property string iconBigText: "\ue6c5"
    property string iconBigTextColor: iconColor
    property string msgText: "消息提示框"
    property var    callbackFunc: undefined
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: 10
    Drag.hotSpot.y: 10

    Rectangle{
        id:title
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1
        width: parent.width-2
        height: 32
        color: FlatDark.SecondBgColor

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: root
        }

        Text{
            id:icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            height: parent.height
            width: height
            font.family: "themify"
            font.weight: Font.Bold
            color: iconColor
            font.pixelSize: btnIconSize
            text: "\ue717"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Text{
            id:iconText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: icon.right
            height: parent.height
            width: parent.width - 2*height
            font.family: FlatDark.fontFamily
            color: iconColor
            font.pixelSize: btnIconSize
            text: "提示"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
        Rectangle{
            id:closeBtn
            anchors.top: parent.top
            anchors.right: parent.right
            height: parent.height
            width: height
            color: FlatDark.SecondBgColor
            Text{
                anchors.fill: parent
                font.family: "themify"
                font.weight: Font.Bold
                color: iconColor
                font.pixelSize: btnIconSize
                text: "\ue646"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked:
                {
                    waitTimer.stop()
                    root.visible = false
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
                    to: FlatDark.SecondBgColor
                    duration: 200
                }
            }
        }
    }//title end
    Text{
        id:iconBig
        anchors.top: title.bottom
        anchors.left: parent.left
        height: parent.height - 2*title.height
        width: height
        font.family: "themify"
        color: iconBigTextColor
        font.pixelSize: parseInt(0.5*height)
        text: iconBigText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Text{
        id:text
        anchors.top: iconBig.top
        anchors.left: iconBig.right
        height: iconBig.height
        width: parent.width - iconBig.width
        font.family: FlatDark.fontFamily
        color: iconBigTextColor
        font.pixelSize: btnIconSize
        text: msgText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }
    ButtonN{
        id:yes
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        anchors.right: parent.right
        anchors.rightMargin: 16
        bgColor: FlatDark.MainBgColor
        width: 100
        height: 30
        text: "确认"
        onClicked: {
            waitTimer.stop()
            yesClicked()
            root.visible = false
            if(callbackFunc !== undefined)
                callbackFunc()
        }
    }
    ButtonN{
        id:no
        anchors.bottom: yes.bottom
        anchors.right: yes.left
        anchors.rightMargin: 16
        bgColor: FlatDark.MainBgColor
        width: 100
        height: 30
        text: "取消"
        onClicked: {
            waitTimer.stop()
            noClicked()
            root.visible = false
        }
    }

    Timer {
        id: waitTimer
        interval: 1/30 * 1000 // 30 Hz
        running: false
        repeat: true
        onTriggered: {
            iconBig.rotation -= 5
        }
    }
    function showWaitAnim()
    {
        waitTimer.start()
    }
    function showMessage(type, msg, callback)
    {
        callbackFunc = undefined
        waitTimer.stop()
        iconBigText = "\ue6c5"
        iconBigTextColor = iconColor
        no.visible = false
        if(type === "note" )
        {
            iconBigText = "\ue717"
            iconText.text = "提示"
            msgText = msg
        }
        else if(type === "warnning" )
        {
            iconText.text = "警告"
            iconBigTextColor = "yellow"
            msgText = msg
        }
        else if(type === "error" )
        {
            iconText.text = "错误"
            iconBigTextColor = "red"
            msgText = msg
        }
        else if(type === "ask" )
        {
            no.visible = true
            iconBigText = "\ue718"
            iconText.text = "询问"
            msgText = msg
            callbackFunc = callback
        }
        else if(type === "wait" )
        {

            iconText.text = "请稍等..."
            iconBigText = "\ue60f"
            msgText = msg
            showWaitAnim()
        }
        root.visible = true
    }

    function close()
    {
        waitTimer.stop()
        root.visible = false
        callbackFunc = undefined
    }

    //showMessage("error", "参数设置错误!",undefined)
    //showMessage("ask", "确定要退出吗?", undefined)
    //showMessage("warnning", "参数超出范围,请检查",undefined)
    //showMessage("warnning", "参数超出范围,请检查",undefined)
    //showMessage("wait", "参数设置中,请稍等...",undefined)
    //showMessage("note", "运行正常",undefined)
}
