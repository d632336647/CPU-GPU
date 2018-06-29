import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark
Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color cubeColor: "#25303B"
    property color shadowColor: "#1883D7"
    property int   iw: 12
    property int   cubeNumber: 10
    property int   cubeMargin: 2
    property real  percent: 0.6
    property bool  showGrow: true
    Text {
        id: valueShow
        text: parseInt(percent*100) + "%"
        color: "#c0c0c0"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        height: parent.height
        anchors.right: pannel.left
        font.family: FlatDark.fontFamily
        width: 20
        z:1
    }
    Item{
        id:pannel
//        anchors.fill: parent
        width: parent.width-20
        height: parent.height-iw
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:  parent.right
//        anchors.topMargin: iw
//        anchors.leftMargin: iw
//        anchors.bottomMargin: iw
//        anchors.rightMargin: iw
        Rectangle
        {
            id:progressBg
            x:0
            y:0
            width: parent.width
            height: parent.height
            color: cubeColor
        }
        Rectangle
        {
            id:progressCube
            property real  p: 0
            anchors.left: parent.left
            anchors.leftMargin: cubeMargin
            width: parent.width * p - cubeMargin
            height: parent.height
            color: shadowColor
//            color: Qt.rgba(255,10,255,252)
        }
        Canvas{
            anchors.fill: parent
            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = 1.5
                ctx.strokeStyle = bgColor
                ctx.fillStyle = bgColor

                var x,  y , w, h;
                var t = pannel.width / cubeNumber
                for(var i=0; i<cubeNumber; i++){

                    x = i*t
                    y = 0
                    w = cubeMargin
                    h = pannel.height

                    ctx.fillRect(x,y,w,h)
                    ctx.strokeRect(x,y,w,h)
                }
            }
        }

        Glow {
            id:lineGrow
            anchors.fill: progressCube
            cached: true
            fast: true
            radius: 8
            samples: 12
            color: shadowColor
            source: progressCube
            spread: 0.2
            opacity: 0.8
            visible: showGrow
        }

    }

    Rectangle{
        id:mask
        x:0
        y:0
        width: parent.width
        height: parent.height
        color: bgColor
        state: "HIDE"
        //过渡动画
        states: [
            State {
                name: "HIDE"
                PropertyChanges { target: mask; x: 0}
                onCompleted:{
                    //root.visible = false
                }
            },
            State {
                name: "SHOW"
                PropertyChanges { target: mask; x: root.width}
                onCompleted: {
                }
            }
        ]

        transitions: [
             Transition {
                 from: "SHOW"
                 to: "HIDE"
                 PropertyAnimation { properties: "x"; duration: 1500; easing.type: Easing.OutCubic }
             },
             Transition {
                 from: "HIDE"
                 to: "SHOW"
                 PropertyAnimation { properties: "x"; duration: 800; easing.type: Easing.OutCubic }
             }
        ]
    }


    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: progressCube; p: 0}
            //PropertyChanges { target: progressCube; color: Qt.rgba(0,0,0)}
            onCompleted:{
                //root.visible = false
            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: progressCube; p: root.percent}
            //PropertyChanges { target: progressCube; color: Qt.rgba(250*root.percent,0*root.percent,0*root.percent)}
            onCompleted: {
            }

        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "p,color"; duration: 800; easing.type: Easing.OutCubic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "p,color"; duration: 1500; easing.type: Easing.OutCubic }
         }
    ]

    onStateChanged:
    {
        mask.state = state
    }

    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}
