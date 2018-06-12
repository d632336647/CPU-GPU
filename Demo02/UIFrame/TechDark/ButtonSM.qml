import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark

//直角按钮控件

Rectangle {
    id:root
    state: "HIDE"
    clip: true
    color: FlatDark.ButtonBgColor
    border.color:FlatDark.ButtonBgColor
    property color  textColor: FlatDark.ButtonFontColor
    property string text: "按钮"
    property int    fontSize: 12
    signal clicked()
    Text {
        id: btnText
        anchors.centerIn: parent
        color:textColor
        text: root.text
        font.pixelSize: root.fontSize
        font.family: FlatDark.fontFamily
    }
    Rectangle{
        id:selectMark
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 4
        color: FlatDark.ButtonBgColor
    }
    Rectangle{
        id:mask
        anchors.fill: parent
        color: "#000000"
        opacity: 0
    }
    MouseArea{
        id: btnMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            root.clicked()
        }
        onPressed: {

        }
        onReleased:
        {

        }
        onEntered:
        {

            pressedAnim.start()
        }
        onExited:
        {

            releasedAnim.start()
        }
        PropertyAnimation {
            id: pressedAnim;
            target: mask;
            property: "opacity";
            to: 0.5;
            duration: 200
        }
        PropertyAnimation {
            id: releasedAnim;
            target: mask;
            property: "opacity";
            to: 0;
            duration: 200
        }
    }

    Component.onCompleted:
    {

    }
    function setSelect()
    {
        root.color = FlatDark.MainBgColor
        root.border.color = FlatDark.MainBgColor
        selectMark.color = FlatDark.ButtonMarkColor
    }
    function cancleSelect()
    {
        root.color = FlatDark.ButtonBgColor
        root.border.color = FlatDark.ButtonBgColor
        selectMark.color = FlatDark.ButtonBgColor
    }
}
