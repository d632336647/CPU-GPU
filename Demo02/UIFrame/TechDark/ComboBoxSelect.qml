import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0

import "Styles.js" as FlatDark
//下拉选择框

Item {
    id:root
    state: "SHOW"
    clip: false
    property color bgColor: FlatDark.ComboBoxBgColor
    property color borderColor: FlatDark.ComboBoxBorderColor
    property color shadowColor: FlatDark.ComboBoxShadowColor
    property bool  showGrow: true
    property int   iw: 4
    property int   popItemCount: 4     //弹出显示的选项个数
    property var   listModel: undefined
    property alias currentValue: currentName.text
    property int   fontSize: FlatDark.mainFontSize
    Rectangle{
        id:line
        anchors.centerIn: parent
        width: parent.width
        height: parent.height - 2*iw
        color: bgColor
        border.color: borderColor

    }
    Text{
        clip: true
        id:currentName
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 2
        height: parent.height - 2
        width: parent.width-height
        font.family: FlatDark.fontFamily
        color:FlatDark.ComboBoxFontColor
        font.pixelSize: fontSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: "下拉选择框"
    }


    Text{
        id:icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: iw
        height: 0.5*parent.height
        width: height
        font.family: "themify"
        font.weight: Font.Bold
        color:FlatDark.ComboBoxIconColor
        font.pixelSize: height//btnIconSize
        text: "\ue64b"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        rotation:0

    }

    MouseArea{
        id: btnMouseArea
        anchors.fill: parent
        hoverEnabled: true;
        onClicked: {

            listView.showState = !listView.showState

        }
        onPressed: {

        }
        onReleased:
        {

        }
        onEntered:
        {
            icon.color = FlatDark.ComboBoxHighLightColor
            //hoverdAnim.start()
        }
        onExited:
        {
            icon.color = FlatDark.ComboBoxBorderColor
            //releasedAnim.start()
        }
    }


    Component {
        id: itemDelegate
        Item {
            id:wrapper
            width: root.width - 7
            height: root.height-2*iw
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 2
                height: parent.height
                width: parent.width-height
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: root.fontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: name
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    wrapper.ListView.view.currentIndex = index//更新视图索引
                    listView.focus = true
                }
                onDoubleClicked:
                {
                    currentName.text = name
                    listView.showState = false
                }
            }
        }
    }
    Rectangle{
        id:listViewBg
        anchors.top: root.bottom
        x:0
        width: parent.width
        height: listView.height
        color: FlatDark.ComboBoxBgColor
    }
    Rectangle{
        anchors.top: root.bottom
        anchors.topMargin: -iw/2
        x:0
        width: parent.width
        height: listView.height
        color: "#00000000"
        border.color: borderColor
        clip: true
        Rectangle{
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottom: parent.bottom
            width: 4
            color: FlatDark.ComboBoxScrollBarBgColor
            Rectangle{
                id:yHandle
                y:0
                x:0
                width: 4
                height: (popItemCount / listView.count) * listView.height
                color: FlatDark.ComboBoxShadowColor
            }

        }
    }
    ListView {
        id:listView
        clip: true
        anchors.top: root.bottom
        anchors.topMargin: -iw/2
        x:0
        width: parent.width
        height: 0
        property bool showState: false
        model: root.listModel//contactModel
        delegate: itemDelegate
        highlightMoveDuration: 200
        highlight: Rectangle {
                    color: "#808080"
                  }
        focus: true
        onShowStateChanged: {
            if(showState)
                showListAnim.start()
            else
                hideListAnim.start()
        }
        onCurrentIndexChanged: {

        }
        onContentYChanged: {
            var itemHight = contentHeight/listView.count
            var percent = (contentY)/(contentHeight-popItemCount*itemHight);
            yHandle.y = percent*(listView.height-yHandle.height)
        }

    }

    PropertyAnimation {
        id: hoverdAnim;
        target: line;
        property: "border.color";
        to: FlatDark.ComboBoxHighLightColor
        duration: 100
    }
    PropertyAnimation {
        id: releasedAnim;
        target: line;
        property: "border.color";
        to: FlatDark.ComboBoxBorderColor
        duration: 100
    }

    PropertyAnimation {
        id: showListAnim;
        target: listView;
        property: "height";
        to: popItemCount*(root.height-2*iw);
        duration: 100
        onStarted:
        {
            iconDownAnim.start()
        }
    }
    PropertyAnimation {
        id: hideListAnim;
        target: listView;
        property: "height";
        to: 0;
        duration: 100
        easing.type: Easing.InQuint
        onStarted:
        {
            iconUpAnim.start()
        }
    }
    PropertyAnimation {
        id: iconDownAnim;
        target: icon;
        property: "rotation";
        to: 180;
        duration: 100
        easing.type: Easing.InQuint
    }
    PropertyAnimation {
        id: iconUpAnim;
        target: icon;
        property: "rotation";
        to: 0;
        duration: 100
        easing.type: Easing.InQuint
    }


    Component.onCompleted:
    {

    }

}
