import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color cubeColor: "#096B78"
    property color shadowColor: "#01FFFC"
    property int   iw: 12
    property int   cubeNumber: 10
    property int   cubeMargin: 2
    property real  percent: 0.6
    Item{
        id:pannel
        anchors.fill: parent
        anchors.topMargin: iw
        anchors.leftMargin: iw
        anchors.bottomMargin: iw
        anchors.rightMargin: iw
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
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height * p
            color: shadowColor

        }
        Canvas{
            anchors.fill: parent
            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = 1.5
                ctx.strokeStyle = bgColor
                ctx.fillStyle = bgColor

                var x,  y , w, h;
                var t = pannel.height / cubeNumber
                for(var i=0; i<cubeNumber; i++){

                    x = 0;
                    y = i*t
                    w = pannel.width
                    h = cubeMargin

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
                PropertyChanges { target: mask; y: 0}
                onCompleted:{
                    //root.visible = false
                }
            },
            State {
                name: "SHOW"
                PropertyChanges { target: mask; y: -root.height}
                onCompleted: {
                }
            }
        ]

        transitions: [
             Transition {
                 from: "SHOW"
                 to: "HIDE"
                 PropertyAnimation { properties: "y"; duration: 1500; easing.type: Easing.OutCubic }
             },
             Transition {
                 from: "HIDE"
                 to: "SHOW"
                 PropertyAnimation { properties: "y"; duration: 800; easing.type: Easing.OutCubic }
             }
        ]
    }


    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: progressCube; p: 0}
            onCompleted:{
                //root.visible = false
            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: progressCube; p: root.percent}
            onCompleted: {
            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "p"; duration: 800; easing.type: Easing.OutCubic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "p"; duration: 1500; easing.type: Easing.OutCubic }
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
