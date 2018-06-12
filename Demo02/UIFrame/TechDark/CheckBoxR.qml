import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark
//多选框

Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: FlatDark.checkBoxBgColor
    property color borderColor: FlatDark.checkBoxBorderColor
    property color shadowColor: FlatDark.checkBoxShadowColor
    property int   iconSize: 0.75*height
    property bool  checked: false
    property string text: "多选框"
    property int   fontSize: FlatDark.mainFontSize

    Rectangle{
        id:line
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: iconSize-4
        height: iconSize-4
        color: FlatDark.checkBoxBgColor
        border.color: borderColor
    }
    Rectangle{
        visible: handle.visible
        anchors.top: line.top
        anchors.right: line.right
        width: 4
        height:4
        color: FlatDark.checkBoxBgColor
    }
    Canvas{
        id:handle
        visible: checked
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: iconSize
        height: iconSize
        onPaint: {
            var ctx = getContext('2d')
            ctx.clearRect(0, 0, line.width, line.height);

            ctx.beginPath();
            ctx.lineWidth = 2
            ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = borderColor;
            ctx.moveTo(0.1*width+2, 0.45*height)
            ctx.lineTo(0.5*width-2, 0.75*height-2)
            ctx.lineTo(width-5, 2)
            ctx.stroke()

        }
    }

    Text{
        id:textString
        clip: true
        anchors.top: parent.top
        anchors.bottom:parent.bottom
        anchors.left: handle.right
        anchors.right: parent.right
        anchors.rightMargin: 2
        color: FlatDark.checkBoxFontColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: FlatDark.fontFamily
        font.pixelSize: fontSize
        text: root.text
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.checked = !root.checked
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
        to: FlatDark.checkBoxHighLightColor
        duration: 200
    }
    PropertyAnimation {
        id: releasedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.checkBoxBorderColor
        duration: 200        
    }
    onBorderColorChanged:
    {
        handle.requestPaint()
    }
    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}
