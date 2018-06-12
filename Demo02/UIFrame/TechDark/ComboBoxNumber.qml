import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark
//双向数值编辑框
Item {
    id:root
    clip: true
    property color bgColor: FlatDark.ComboBoxBgColor
    property color borderColor: FlatDark.ComboBoxBorderColor
    property color shadowColor: FlatDark.ComboBoxShadowColor
    property int   iw: 4
    property real  step: 1
    property real  value: 1
    property int   fontSize: FlatDark.mainFontSize
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
        anchors.leftMargin: iw+2
        anchors.right: iconUp.left
        selectByMouse: true //是否可以选择文本
        selectionColor: borderColor
        selectedTextColor: bgColor
        activeFocusOnPress: true
        color: FlatDark.ComboBoxFontColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        validator:RegExpValidator{regExp: /[+-]?\d+[\.]?\d+$/}
        font.family: FlatDark.fontFamily
        font.pixelSize: fontSize
        text: value
        onAccepted:
        {
            focus = false
            value = parseFloat(text)
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
                releasedAnim.stop()
            }
            onExited:
            {
                releasedAnim.start()
                pressedAnim.stop()
            }
        }
    }

    Text{
        id:iconUp
        anchors.top: parent.top
        anchors.topMargin: iw
        anchors.right: parent.right
        anchors.rightMargin: iw
        height: 0.5*parent.height-iw
        width: height
        font.family: "themify"
        font.weight: Font.Bold
        color:FlatDark.ComboBoxIconColor
        font.pixelSize: height//btnIconSize
        text: "\ue648"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                value += step
            }
            onPressed: {
                iconUp.color = "#F95F46"
                textInput.focus = false
            }
            onReleased:
            {
                iconUp.color = FlatDark.ComboBoxShadowColor
            }
            onEntered:
            {
                iconUp.color = FlatDark.ComboBoxShadowColor
            }
            onExited:
            {
                iconUp.color = FlatDark.ComboBoxIconColor
            }
        }
    }
    Text{
        id:iconDown
        anchors.bottom: parent.bottom
        anchors.bottomMargin: iw
        anchors.right: parent.right
        anchors.rightMargin: iw
        height: 0.5*parent.height-iw
        width: height
        font.family: "themify"
        font.weight: Font.Bold
        color:FlatDark.ComboBoxIconColor
        font.pixelSize: height//btnIconSize
        text: "\ue64b"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                value -= step
            }
            onPressed: {
                iconDown.color = "#F95F46"
                textInput.focus = false
            }
            onReleased:
            {
                iconDown.color = FlatDark.ComboBoxShadowColor
            }
            onEntered:
            {
                iconDown.color = FlatDark.ComboBoxShadowColor
            }
            onExited:
            {
                iconDown.color = FlatDark.ComboBoxIconColor
            }
        }
    }

    PropertyAnimation {
        id: pressedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.ComboBoxHighLightColor;
        duration: 200
    }
    PropertyAnimation {
        id: releasedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.checkBoxBorderColor
        duration: 200
    }


    Component.onCompleted:
    {
    }

}
