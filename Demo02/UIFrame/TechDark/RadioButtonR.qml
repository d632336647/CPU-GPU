import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark

//方形控件
Item {
    id:root
    clip: true
    objectName: "RadioButtonR"
    property color bgColor: FlatDark.RadioButtonBgColor
    property color borderColor: FlatDark.RadioButtonBorderColor
    property color shadowColor: FlatDark.RadioButtonShadowColor
    property int   iconSize: 0.75*height
    property bool  checked: false
    property string text: "单选框"
    property int   fontSize: FlatDark.mainFontSize
    Rectangle{
        id:line
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: iconSize - 4
        height: iconSize - 4
        color: FlatDark.RadioButtonBgColor
        border.color: borderColor
    }
    Rectangle{
        id:handle
        visible: checked
        anchors.top: line.top
        anchors.topMargin: 4
        anchors.left: line.left
        anchors.leftMargin: 4
        anchors.right: line.right
        anchors.rightMargin: 4
        anchors.bottom: line.bottom
        anchors.bottomMargin: 4
        color: borderColor
    }
    Text{
        id:textString
        clip: true
        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 2
        anchors.left: line.right
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 2
        color: FlatDark.ComboBoxFontColor
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
            var list = root.parent.children;
            for ( var i in list) {
                if( (list[i].objectName === root.objectName) && (list[i] !== root) )
                {
                    list[i].checked = false
                }
            }
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
        to: FlatDark.RadioButtonHighLightColor
        duration: 200
    }
    PropertyAnimation {
        id: releasedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.RadioButtonBorderColor
        duration: 200
    }


    Component.onCompleted:
    {

    }

}
