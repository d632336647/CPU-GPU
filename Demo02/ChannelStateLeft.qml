import QtQuick 2.7
import QtGraphicalEffects 1.0

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as TechDark

Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color borderColor: "#A00AFFFC"
    property color shadowColor: "#0AFFFC"
    property color textColor: "#c0c0c0"
    property int   iw: 14


    property real   ssdUsedPercent: 0.65
    property string ssdStateText: "存储使用率:"+parseInt(ssdUsedPercent*100)+"%"

    property real   temp: 62
    property string tempStateText: "设备温度:"+temp+"℃"
    property real setTempWar: 40
    property alias chNameText: chName.text
    signal click();
    RectCorner4{
        id:chName
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: height
        text: "CH1"
        offset: 0
        fontFamily: TechDark.fontFamily
        fontSize: 20
        cornerWidth: 2
        MouseArea{
            anchors.fill: parent
            onClicked: {
                click()
            }
        }
    }

    ProgressCircle {
        id:ssdState
        anchors.top: parent.top
        anchors.right: chName.left
        anchors.rightMargin: 4
        height: parent.height
        width: height
        percent: root.ssdUsedPercent
    }
    ProgressGrillX {
        id:tempState
        anchors.top:parent.top
        anchors.right: ssdState.left
        anchors.left: parent.left
        //width: parent.width - 2*parent.height
        height: parent.height * 0.4
        cubeNumber: 20
        percent: root.temp/100
        //rotation: 180
//        Component.onCompleted: {
//            if(percent >= root.setTempWar/100)
//            {
//                tempState.shadowColor ="#F95F46"
//                tempState.cubeColor = "#772928"
//            }else{
//                tempState.shadowColor ="#0AFFFC"
//                tempState.cubeColor = "#096B78"
//            }
//        }

        onPercentChanged: {
            if(percent >= root.setTempWar/100)
            {
                tempState.shadowColor ="#F95F46"
                tempState.cubeColor = "#772928"
            }else{
                tempState.shadowColor ="#0AFFFC"
                tempState.cubeColor = "#096B78"
            }
        }
    }

    Canvas{
        id:topLine
        anchors.fill: parent
        onPaint: {
            var ctx = getContext('2d')
            //ctx.save();
            ctx.clearRect(0, 0, topLine.width, topLine.height);

            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = borderColor;
            ctx.moveTo(tempState.width-6, tempState.y + 0.5*tempState.height)
            ctx.lineTo(tempState.width, tempState.y + 0.7*tempState.height)
            ctx.lineTo(tempState.width, tempState.y + 1.0*tempState.height)
            ctx.lineTo(tempState.width-6, tempState.y + 1.2*tempState.height)
            ctx.stroke()

            ctx.moveTo(ssdState.x + 0.5*ssdState.width - 8, ssdState.y + 0.5*ssdState.height + 8 )
            ctx.lineTo(tempState.width, ssdState.height - ssdState.iw)
            ctx.lineTo(tempState.x+iw, ssdState.height - ssdState.iw)
            ctx.stroke()
        }
    }
    Glow {
        id:lineGrow
        source: topLine
        anchors.fill: topLine
        cached: true
        fast: true
        radius: 10
        samples: 14
        color: shadowColor
        spread: 0.6
        opacity: 0.8
    }

    Text {
        id: tempText
        anchors.top: tempState.bottom
        //anchors.horizontalCenter: tempState.horizontalCenter
        anchors.right: tempState.right
        anchors.rightMargin: tempState.iw
        color: textColor
        text: root.tempStateText
        font.pixelSize: 14
        font.family: TechDark.fontFamily
    }

    Text {
        id: ssdText
        anchors.bottom: ssdState.bottom
        anchors.bottomMargin: ssdState.iw + 2
        //anchors.horizontalCenter: tempState.horizontalCenter
        anchors.right: tempState.right
        anchors.rightMargin: tempState.iw
        color: textColor
        text: root.ssdStateText
        font.pixelSize: 14
        font.family: TechDark.fontFamily
    }

    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: root; opacity: 0}
            onCompleted:{

            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: root; opacity: 1}
            onCompleted: {

            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "opacity"; duration: 1500; easing.type: Easing.InElastic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "opacity"; duration: 1500; easing.type: Easing.InBounce }
         }
    ]

    onStateChanged:
    {
        chName.state = state
        ssdState.state = state
        tempState.state = state
    }
    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}

