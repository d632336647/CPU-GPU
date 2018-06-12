import QtQuick 2.7
import QtGraphicalEffects 1.0

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as TechDark
import "Skin.js" as Skin

Item {
    id:root
    anchors.fill: parent

    Rectangle{
        id:cardStatus
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 0.25*parent.height
        //color: Skin.LeftMenuBgColor
        color: "#000000"
        Row{
            anchors.fill: parent
            Item{
                width: 0.16*parent.width
                height: parent.height
                ComboBoxSelect{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top:parent.top
                    anchors.topMargin: 0.1*parent.height
                    width: 140
                    height: 30
                    popItemCount: 4
                    currentValue:"中频预处理卡1"
                    listModel:ListModel{
                        ListElement {
                            name: "数据处理卡"
                        }
                        ListElement {
                            name: "数据采集卡1"
                        }
                        ListElement {
                            name: "数据采集卡2"
                        }
                        ListElement {
                            name: "中频预处理卡1"
                        }
                        ListElement {
                            name: "中频预处理卡2"
                        }

                    }
                }
            }
            RectCorner4{
                id:ifmodule1
                width: parseInt(0.16*parent.width)
                height: parent.height
                cornerWidth: 2
                ProgressCircle {
                    id:ifFreq
                    anchors.top:parent.top
                    anchors.topMargin: 14
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    height: 0.5*parent.height
                    width: height
                    percent: 0.17
                }
                ProgressGrillY{
                    percent: 0.72
                    anchors.top:parent.top
                    anchors.topMargin: 4
                    anchors.left: ifFreq.right
                    height: 0.5*parent.height
                    width: 40
                }
                Grid{
                    anchors.top: ifFreq.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    columns: 2
                    spacing: 4
                }

            }
            RectCorner4{
                width: parseInt(0.16*parent.width)
                height: parent.height
                cornerWidth: 2
                ProgressCircle {
                    id:ifmodule2
                    anchors.top:parent.top
                    anchors.topMargin: 0.1*parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 0.5*parent.height
                    width: height
                    percent: 0.74
                }
            }
            RectCorner4{
                width: parseInt(0.16*parent.width)
                height: parent.height
                cornerWidth: 2
                ProgressCircle {
                    id:ifmodule3
                    anchors.top:parent.top
                    anchors.topMargin: 0.1*parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 0.5*parent.height
                    width: height
                    percent: 0.56
                }
            }
            RectCorner4{
                width: parseInt(0.16*parent.width)
                height: parent.height
                cornerWidth: 2
                ProgressCircle {
                    id:ifmodule4
                    anchors.top:parent.top
                    anchors.topMargin: 0.05*parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 0.5*parent.height
                    width: height
                    percent: 0.34
                }
            }
        }
    }


    Grid{
        anchors.top: cardStatus.bottom
        columns: 3
        spacing: 4

        ComboBoxSelect{
            width: 100
            height: 30
            currentValue:"前锋测试1"
            popItemCount: 3
            z:20
            listModel:ListModel{
                ListElement {
                    name: "前锋测试1"
                }
                ListElement {
                    name: "前锋测试2"
                }
                ListElement {
                    name: "前锋测试3"
                }
                ListElement {
                    name: "前锋测试4"
                }
                ListElement {
                    name: "前锋测试5"
                }
            }


        }
        ComboBoxNumber{
            width: 100
            height: 30
        }
        LineEdit {
            width: 200
            height: 30
            text: "查找..."

        }
        LineEdit
        {
            width: 100
            height: 30


        }
        LineEdit{
            width: 100
            height: 30


        }
        CheckBoxD {
            width: 60
            height: 30
        }
        RadioButtonR {
            width: 200
            height:30
        }
        RadioButtonR {
            width: 100
            height: 30
        }
        RadioButtonR {
            width: 100
            height: 30
        }

        CheckBoxR {
            width: 200
            height: 30
            checked: true
        }
        CheckBoxR {
            width: 100
            height: 30
        }
        CheckBoxR {
            width: 100
            height: 30
        }
        CheckBoxR {
            width: 100
            height: 30
        }
        CheckBoxD {
            width: 80
            height:30
        }
        CheckBoxD {
            width: 60
            height: 30
        }


//            ProgressCircle{
//                width: 200
//                height: 200
//            }
//            ContentA{
//                width: 200
//                height: 200
//            }
//            ProgressGrillY{
//                width: 200
//                height: 200
//            }
//            ProgressGrillX{
//                width: 200
//                height: 200
//            }
//            RectCorner0{
//                width: 200
//                height: 200
//            }
//            ChannelState{
//                width: 400
//                height: 100
//                temp:  30
//            }
//            ChannelStateLeft{
//                width: 400
//                height: 100
//            }
//            AnimatedImage{
//                source: "qrc:/Images/circle.gif"
//            }
//            AnimatedImage{
//                source: "qrc:/Images/wave.gif"
//            }

    }

    Item{
        anchors.top: parent.top
        anchors.right: parent.right
        width: 400
        Column{
            spacing: 2
            id:bandState
            ChannelState{
                width: 400
                height: 100
                temp:  30
                circlePrercent: 0.15
                chNameText:"板卡1"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  23
                circlePrercent: 0.36
                chNameText:"板卡2"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  56
                circlePrercent: 0.27
                chNameText:"板卡3"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  37
                chNameText:"板卡4"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  87
                circlePrercent: 0.54
                chNameText:"板卡5"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  48
                circlePrercent: 0.86
                chNameText:"板卡6"
            }
            RectCorner4{
                cornerWidth: 2
                width: 400
                height: 210
            }

        }

    }


}
