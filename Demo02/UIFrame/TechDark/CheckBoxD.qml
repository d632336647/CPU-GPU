import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark

//开关控制按钮

Item {
    id:root
    clip: true
    property color bgColor: FlatDark.checkBoxBgColor
    property color borderColor: FlatDark.checkBoxBorderColor
    property color shadowColor: FlatDark.checkBoxShadowColor
    property bool  isOn: false
    property int   iw : 4
    //property int   fontSize:
    property int   fontSize: FlatDark.mainFontSize
    Rectangle
    {
        id:border
        anchors.centerIn: parent
        width: parent.width
        height: parent.height - 2*iw
        color:FlatDark.checkBoxBgColor
        border.color: borderColor
    }
    Rectangle{
        id:handle
        anchors.verticalCenter: parent.verticalCenter
        x:2
        height: parent.height-2*iw-4
        width: (parent.width-4)/2
        color: borderColor
    }
    Text {
        id: offText
        visible: !isOn
        anchors.verticalCenter: parent.verticalCenter
        x:2+handle.width
        height: parent.height-2*iw-4
        width: (parent.width-4)/2
        font.family: FlatDark.fontFamily
        color:FlatDark.checkBoxFontColor
        font.pixelSize: fontSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "关"
    }
    Text {
        id: onText
        visible: isOn
        anchors.verticalCenter: parent.verticalCenter
        x:2
        height: parent.height-2*iw-4
        width: (parent.width-4)/2
        font.family: FlatDark.fontFamily
        color:FlatDark.checkBoxFontColor
        font.pixelSize: fontSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "开"
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.isOn = !root.isOn
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
    onIsOnChanged:
    {
        if(isOn)
            handleOnAnim.start()
        else
            handleOffAnim.start()
    }
    PropertyAnimation {
        id: handleOnAnim;
        target: handle;
        property: "x";
        to: 2+handle.width;
        duration: 200
    }
    PropertyAnimation {
        id: handleOffAnim;
        target: handle;
        property: "x";
        to: 2
        duration: 200
    }
    PropertyAnimation {
        id: pressedAnim;
        target: root;
        property: "borderColor";
        to: FlatDark.checkBoxHighLightColor;
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
