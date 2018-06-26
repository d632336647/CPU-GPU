import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id:root
//    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color borderColor: "#A00AFFFC"
    property color shadowColor: "#1883D7"
    property int   iw: 18
    property int   circleWidth: 8
    property real  percent: 0.0
    property bool  showGrow: true
    property alias valueChange: valueChange
    onPercentChanged: {
//        console.log("percent::"+percent)
        valueChange.start()
    }
    Text {
        id: showPercent
        text: parseInt(cricleMask.p * 100)+"%"
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#c0c0c0"
        font.pixelSize:  parent.width * 0.2
    }

    Item{
        id:pannel
        anchors.fill: parent
        rotation: -90
        Canvas{
            id:cricleBg
            anchors.fill: parent
            property real  r: width/2
            onPaint: {
                var ctx = getContext('2d')
                ctx.beginPath();
                ctx.lineWidth = circleWidth+6
//                ctx.strokeStyle = "#25303B";
                ctx.strokeStyle = "#404244"
                ctx.arc(width/2, height/2,  r-iw-6,  0, 2*Math.PI);
                //ctx.fill();  //填充
                ctx.stroke()
            }
        }
        Canvas{
            id:cricleMask
            anchors.fill: parent
            property real  r: width/2
            property real  d: 0
            property real  p: d / (2*Math.PI)
            onPaint: {
                var ctx = getContext('2d')
                //ctx.save();
                ctx.clearRect(0, 0, cricleMask.width, cricleMask.height);
                ctx.beginPath();
                ctx.lineWidth = circleWidth+6
                ctx.strokeStyle = shadowColor
                ctx.arc(width/2, height/2,  r-iw-6,  0, d);
                //ctx.fill();  //填充
                ctx.stroke()
            }
            onDChanged:
            {
                requestPaint()
            }
            NumberAnimation {
                id:valueChange
                target: cricleMask
                to:(2*Math.PI) * percent
                property: "d"
                duration: 300
                easing.type: Easing.Linear
            }
        }


        Glow {
            id:lineGrow
            anchors.fill: cricleMask
            cached: true
            fast: true
            radius: 8
            samples: 12
            color: shadowColor
            source: cricleMask
            spread: 0.2
            opacity: 0.8
            visible: showGrow
            /*
            NumberAnimation on opacity {
                id:an2
                to:0.8
                duration: 1500
                onStopped: {

                }
            }
            */
        }

        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: iw - circleWidth
            color: "#00000000"
            Canvas{
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext('2d')
                    ctx.beginPath();
                    ctx.lineWidth = 1.5
                    ctx.strokeStyle = shadowColor;
                    ctx.fillStyle = shadowColor
                    ctx.moveTo(width ,  0);
                    ctx.lineTo(width-0.86*height, 0.5*height);//0.86 = 1.72 / 2
                    ctx.lineTo(width, height);
                    ctx.closePath();
                    ctx.fill();  //填充
                    ctx.stroke()
                }
            }
        }


        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: iw - circleWidth
            color: "#00000000"
            rotation:  cricleMask.p * 360
            Canvas{
                id:arrow
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext('2d')
                    ctx.beginPath();
                    ctx.lineWidth = 1.5
                    ctx.strokeStyle = shadowColor;
                    ctx.fillStyle = shadowColor
                    ctx.moveTo(width ,  0);
                    ctx.lineTo(width-0.86*height, 0.5*height);
                    ctx.lineTo(width, height);
                    ctx.closePath();
                    ctx.fill();  //填充
                    ctx.stroke()
                }
            }
        }
    }

//    //过渡动画
//    states: [
//        State {
//            name: "HIDE"
//            PropertyChanges { target: cricleMask; d: 0}
//            PropertyChanges { target: root; opacity: 0}
//            onCompleted:{
//                //root.visible = false
//            }
//        },
//        State {
//            name: "SHOW"
//            PropertyChanges { target: cricleMask; d: (2*Math.PI) * percent}
//            PropertyChanges { target: root; opacity: 1}
//            onCompleted: {
//            }
//        }
//    ]

//    transitions: [
//         Transition {
//             from: "SHOW"
//             to: "HIDE"
//             PropertyAnimation { properties: "d,opacity"; duration: 1500; easing.type: Easing.OutCubic }
//         },
//         Transition {
//             from: "HIDE"
//             to: "SHOW"
//             PropertyAnimation { properties: "d,opacity"; duration: 1500; easing.type: Easing.OutCubic }
//         }
//    ]


//    Component.onCompleted:
//    {
//        root.state = "SHOW"
//    }
    Component.onCompleted: {
        valueChange.start()
    }

}
