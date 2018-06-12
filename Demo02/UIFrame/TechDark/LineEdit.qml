import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark
//普通单行输入框
Item {
    id:root
    state: "HIDE"
    clip: true
    property color  bgColor: FlatDark.LineEditBgColor
    property color  borderColor: FlatDark.LineEditBorderColor
    property color  shadowColor: FlatDark.LineEditShadowColor
    property int    iw: 4
    property string text: "输入框"
    property int    fontSize: FlatDark.mainFontSize
    Rectangle{
        id:line
        anchors.centerIn: parent
        width: parent.width
        height: parent.height - 2*iw
        color: bgColor
        border.color: borderColor

    }
    TextInput{
        id:textInput
        clip: true
        anchors.top: parent.top
        anchors.topMargin: iw
        anchors.bottom:parent.bottom
        anchors.bottomMargin: iw
        anchors.left: parent.left
        anchors.leftMargin: iw
        anchors.right: parent.right
        anchors.rightMargin: iw
        selectByMouse: true //是否可以选择文本
        selectionColor: borderColor
        selectedTextColor: bgColor
        activeFocusOnPress: true
        color: FlatDark.ComboBoxFontColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: FlatDark.fontFamily
        font.pixelSize: fontSize
        text: root.text
        onAccepted:
        {
            focus = false
            root.text = text
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        onClicked: {
            textInput.focus = true
            mouse.accepted = false
        }
        onMouseXChanged: {
            mouse.accepted = false
        }
        onMouseYChanged:
        {
            mouse.accepted = false
        }
        onDoubleClicked:
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
    }


    PropertyAnimation {
        id: pressedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.LineEditHighLightColor;
        duration: 200
    }
    PropertyAnimation {
        id: releasedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.LineEditBorderColor
        duration: 200
    }


    Component.onCompleted:
    {

    }

}
