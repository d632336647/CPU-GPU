import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as FlatDark


Rectangle {
    id:root
    anchors.fill: parent
    color: "#1A1A1C"
    property bool canDestroy: false

    Rectangle{
        id:borderParamConfig
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.leftMargin: 4
        width: 0.7*parent.width
        height: 0.1*parent.height
        color: "#00000000"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }
        z:10
        Item{
            id:triggerMode
            width: 0.2*parent.width
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            z:90
            Text {
                anchors.fill: parent
                text: qsTr("  触发模式")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 2
                currentValue:"内触发"
                listModel:ListModel{
                    ListElement {
                        name: "内触发"
                    }
                    ListElement {
                        name: "外触发"
                    }
                }
            }
        }

        Item{
            id:outMode
            width: 0.2*parent.width
            height: 30
            anchors.top: triggerMode.bottom
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            z:50
            Text {
                anchors.fill: parent
                text: qsTr("  输出模式")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 3
                currentValue:"DDC模式"
                listModel:ListModel{
                    ListElement {
                        name: "DDC模式"
                    }
                    ListElement {
                        name: "ADC模式"
                    }
                    ListElement {
                        name: "测试模式"
                    }
                }
            }
        }

        Item{
            id:clockMode
            anchors.top: triggerMode.top
            anchors.left: triggerMode.right
            anchors.leftMargin: 4
            width: 0.2*parent.width
            height: 30
            z:90
            Text {
                anchors.fill: parent
                text: qsTr("  时钟模式")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 3
                currentValue:"内时钟"
                listModel:ListModel{
                    ListElement {
                        name: "内时钟"
                    }
                    ListElement {
                        name: "外时钟"
                    }
                    ListElement {
                        name: "外参考"
                    }
                }
            }
        }

        Item{
            id:channelEnable
            width: 0.2*parent.width
            height: 30
            anchors.top: clockMode.bottom
            anchors.topMargin: 4
            anchors.left: clockMode.left
            z:50
            Text {
                anchors.fill: parent
                text: qsTr("  通道使能")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 4
                currentValue:"1通道"
                listModel:ListModel{
                    ListElement {
                        name: "1通道"
                    }
                    ListElement {
                        name: "2通道"
                    }
                    ListElement {
                        name: "3通道"
                    }
                    ListElement {
                        name: "4通道"
                    }
                }
            }
        }


        Item{
            id:sampleRate
            anchors.top: triggerMode.top
            anchors.left: clockMode.right
            anchors.leftMargin: 14
            width: 0.2*parent.width+30
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("  采样率")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            Text {
                id:sampleRateUnit
                anchors.right: parent.right
                height: parent.height
                width: height
                text: qsTr("Msps")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.right: sampleRateUnit.left
                anchors.rightMargin: 2
                width: 0.5*(parent.width-30)
                height: parent.height
                text:"100"
            }
        }

        Item{
            id:ddcFreq
            anchors.top: sampleRate.bottom
            anchors.topMargin: 4
            anchors.left: sampleRate.left
            width: 0.2*parent.width+30
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("  DDC载频")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            Text {
                id:ddcFreqUnit
                anchors.right: parent.right
                height: parent.height
                width: height
                text: qsTr("MHz")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.right: ddcFreqUnit.left
                anchors.rightMargin: 2
                width: 0.5*(parent.width-30)
                height: parent.height
                text:"70"
            }

        }



        Item{
            id:fsbCoeff
            anchors.top: triggerMode.top
            anchors.left: sampleRate.right
            anchors.leftMargin: 14
            width: 0.2*parent.width
            height: 30
            z:90
            Text {
                anchors.fill: parent
                text: qsTr("  Fs/B系数")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 2
                currentValue:"1.25B"
                listModel:ListModel{
                    ListElement {
                        name: "1.25B"
                    }
                    ListElement {
                        name: "2.50B"
                    }
                }
            }
        }

        Item{
            id:extractFactor
            anchors.top: fsbCoeff.bottom
            anchors.topMargin: 4
            anchors.left: fsbCoeff.left
            width: 0.2*parent.width
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("  抽取因子")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                text:"2"
            }

        }

        ButtonN{
            id:btnReset
            anchors.top: triggerMode.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "复位"
        }

        ButtonN{
            id:applySet
            anchors.top: btnReset.bottom
            anchors.topMargin: 4
            anchors.right: btnReset.right
            width: 0.1*parent.width
            height: 30
            text: "设置"
        }


    } // 参数设置 END


    //采集设置
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:borderCaptureConfig
        anchors.top: borderParamConfig.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 4
        width: 0.7*parent.width
        height: 0.1*parent.height
        color: "#00000000"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }
        z:9
        Item{
            id:savePath
            width: 0.6*parent.width
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            Text {
                anchors.fill: parent
                text: qsTr("  落盘路径")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.left: parent.left
                anchors.leftMargin: 0.167*parent.width
                width: 0.833*parent.width
                height: parent.height
                text:"D:\\Store"
            }
        }
        ButtonN{
            id:btnBrowser
            anchors.top: savePath.top
            anchors.left: savePath.right
            anchors.leftMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "浏览"
        }

        ButtonN{
            id:btnAutoNamed
            anchors.top: savePath.top
            anchors.left: btnBrowser.right
            anchors.leftMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "自动命名"
        }


        Item{
            id:captureMode
            width: 0.2*parent.width
            height: 30
            anchors.top: savePath.bottom
            anchors.topMargin: 4
            anchors.left: savePath.left
            z:50
            Text {
                anchors.fill: parent
                text: qsTr("  采集模式")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 3
                currentValue:"即采集停"
                listModel:ListModel{
                    ListElement {
                        name: "时长采集"
                    }
                    ListElement {
                        name: "大小采集"
                    }
                    ListElement {
                        name: "定时采集"
                    }
                }
            }
        }

        Item{
            id:captureTime
            anchors.top: captureMode.top
            anchors.left: captureMode.right
            anchors.leftMargin: 4
            width: 0.2*parent.width+30
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("  采集时长")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            Text {
                id:captureTimeUnit
                anchors.right: parent.right
                height: parent.height
                width: height
                text: qsTr("秒")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.right: captureTimeUnit.left
                width: 0.5*(parent.width-30)
                height: parent.height
                text:"100"
            }
        }


        CheckBoxR{
            id:captureDivIQ
            anchors.top: captureTime.top
            anchors.left: captureTime.right
            anchors.leftMargin: 4
            height: 30
            width: 0.1*parent.width
            text:"I/Q分路"
        }

        CheckBoxR{
            id:captureDivCh
            anchors.top: captureDivIQ.top
            anchors.left: captureDivIQ.right
            anchors.leftMargin: 4
            height: 30
            width: 0.1*parent.width
            text:"通道分路"
        }




        ButtonN{
            id:btnStartCapture
            anchors.top: savePath.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "启动采集"
        }
        ButtonN{
            id:btnStopCapture
            anchors.top: btnStartCapture.bottom
            anchors.topMargin: 4
            anchors.right: btnStartCapture.right
            width: 0.1*parent.width
            height: 30
            text: "停止采集"
        }

    }


    //离线拆分
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:borderOfflineDiv
        anchors.top: borderCaptureConfig.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 4
        width: 0.7*parent.width
        height: 0.1*parent.height
        color: "#00000000"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }
        z:8
        Item{
            id:filePath
            width: 0.6*parent.width
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 4
            Text {
                anchors.fill: parent
                text: qsTr("  目标文件")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            LineEdit{
                anchors.left: parent.left
                anchors.leftMargin: 0.167*parent.width
                width: 0.833*parent.width
                height: parent.height
                text:""
            }
        }
        ButtonN{
            id:btnFileBrowser
            anchors.top: filePath.top
            anchors.left: filePath.right
            anchors.leftMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "浏览"
        }



        Item{
            id:dataMode
            width: 0.2*parent.width
            height: 30
            anchors.top: filePath.bottom
            anchors.topMargin: 4
            anchors.left: filePath.left
            z:50
            Text {
                anchors.fill: parent
                text: qsTr("  数据模式")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 2
                currentValue:"DDC模式"
                listModel:ListModel{
                    ListElement {
                        name: "DDC模式"
                    }
                    ListElement {
                        name: "ADC模式"
                    }
                }
            }
        }

        Item{
            id:channelCount
            anchors.top: dataMode.top
            anchors.left: dataMode.right
            anchors.leftMargin: 4
            width: 0.2*parent.width
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("  通道个数")
                font.family: FlatDark.fontFamily
                color:FlatDark.ComboBoxFontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            ComboBoxSelect{
                anchors.right: parent.right
                width: 0.5*parent.width
                height: parent.height
                popItemCount: 4
                currentValue:"1通道"
                listModel:ListModel{
                    ListElement {
                        name: "1通道"
                    }
                    ListElement {
                        name: "2通道"
                    }
                    ListElement {
                        name: "3通道"
                    }
                    ListElement {
                        name: "4通道"
                    }
                }
            }
        }


        CheckBoxR{
            id:offlineDivIQ
            anchors.top: channelCount.top
            anchors.left: channelCount.right
            anchors.leftMargin: 4+30
            height: 30
            width: 0.1*parent.width
            text:"I/Q分路"
        }

        CheckBoxR{
            id:offlineDivCh
            anchors.top: offlineDivIQ.top
            anchors.left: offlineDivIQ.right
            anchors.leftMargin: 4
            height: 30
            width: 0.1*parent.width
            text:"通道分路"
        }

        ButtonN{
            id:btnStartDiv
            anchors.top: filePath.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            width: 0.1*parent.width
            height: 30
            text: "开始拆分"
        }
    }

    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:logBox
        anchors.top: borderOfflineDiv.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 4
        width: 0.7*parent.width
        height: 0.325*parent.height
        color: "black"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }

        Rectangle{
            id:logTitle
            anchors.top: parent.top
            anchors.topMargin: 1
            width: parent.width
            height: 30
            color: "#404244"
            Row{
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                Rectangle{
                    height: parent.height
                    width: 0.1*parent.width
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"等级"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.3*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"时间"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.6*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"信息"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
        Component {
            id: itemDelegate
            Item {
                id:wrapper
                width: borderLogBox.width
                height: 30
                //color: "#404244"
                Row{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width
                    height: parent.height
                    Item{
                        height: parent.height
                        width: 0.1*parent.width
                        Text{
                            anchors.fill: parent
                            text:level
                            font.family: "themify"
                            color:levelColor
                            font.weight: Font.Bold
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.3*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text:date
                            font.family: FlatDark.fontFamily
                            color:levelColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.6*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text:info
                            font.family: FlatDark.fontFamily
                            color:levelColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        wrapper.ListView.view.currentIndex = index//更新视图索引
                        listView.focus = true
                    }
                    onDoubleClicked:
                    {
                    }
                }
            }
        }
        ListModel {
            id: logModel
            ListElement {
                      level: "\ue6c5"
                      levelColor:"red"
                      date: "2018-05-29 16:34:23"
                      info: "未检测到板卡"
                  }
                  ListElement {
                      level: "\ue717"
                      levelColor:"#c0c0c0"
                      date: "2018-05-29 16:34:24"
                      info: "运行正常"
                  }
                  ListElement {
                      level: "\ue717"
                      levelColor:"#c0c0c0"
                      date: "2018-05-29 16:34:25"
                      info: "运行正常"
                  }
                  ListElement {
                      level: "\ue6c5"
                      levelColor:"yellow"
                      date: "2018-05-29 16:36:26"
                      info: "板卡温度过高"
                  }
                  ListElement {
                      level: "\ue717"
                      levelColor:"#c0c0c0"
                      date: "2018-05-29 16:37:21"
                      info: "温度恢复正常"
                  }
                  ListElement {
                      level: "\ue717"
                      levelColor:"#c0c0c0"
                      date: "2018-05-29 16:38:33"
                      info: "运行正常"
                  }
        }
        ScrollView{
            id:borderLogBox
            anchors.top: logTitle.bottom
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            //ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ListView {
                id:listView
                anchors.fill: parent
                model: logModel
                delegate: itemDelegate
                highlightMoveDuration: 200
                highlight: Rectangle {
                            color: "#00808080"
                            border.color: "#808080"
                          }
                onCurrentIndexChanged: {

                }
            }
        }
    }//END logBox



    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:borderCaptureState
        anchors.top: logBox.bottom
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.leftMargin: 4
        width: 0.7*parent.width
        height: 24
        color: "#00000000"
        //border.color: "#808080"
        //radius: 4
        Row{
            anchors.fill: parent
            spacing: 8
            Item{
                width: 0.2*parent.width
                height: parent.height
                Text{
                    id:iconClkState
                    text:"\ue72b"
                    height: parent.height
                    width: height
                    font.family: "themify"
                    color:"gray"
                    font.weight: Font.Bold
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text{
                    anchors.left: iconClkState.right
                    anchors.right: parent.right
                    height: parent.height
                    text:"时钟状态:"
                    font.family: FlatDark.fontFamily
                    color:"gray"
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

            }
            Item{
                width: 0.2*parent.width
                height: parent.height
                Text{
                    id:iconSaveRate
                    text:"\ue632"
                    height: parent.height
                    width: height
                    font.family: "themify"
                    color:"gray"
                    font.weight: Font.Bold
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text{
                    text:"落盘速率:"
                    anchors.left: iconSaveRate.right
                    anchors.right: parent.right
                    height: parent.height
                    font.family: FlatDark.fontFamily
                    color:"gray"
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Item{
                width: 0.2*parent.width
                height: parent.height
                Text{
                    id:iconTimeCount
                    text:"\ue66e"
                    height: parent.height
                    width: height
                    font.family: "themify"
                    color:"gray"
                    font.weight: Font.Bold
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text{
                    text:"累计耗时:"
                    anchors.left: iconTimeCount.right
                    anchors.right: parent.right
                    height: parent.height
                    font.family: FlatDark.fontFamily
                    color:"gray"
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Item{
                width: 0.2*parent.width
                height: parent.height
                Text{
                    id:iconFileSize
                    text:"\ue67d"
                    height: parent.height
                    width: height
                    font.family: "themify"
                    color:"gray"
                    font.weight: Font.Bold
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text{
                    text:"采集大小:"
                    anchors.left: iconFileSize.right
                    anchors.right: parent.right
                    height: parent.height
                    font.family: FlatDark.fontFamily
                    color:"gray"
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }// END ROW
    }
    ButtonN{
        id:btnClearLog
        anchors.top: logBox.bottom
        anchors.right: logBox.right
        anchors.rightMargin: 4
        width: 0.07*parent.width
        height: 30
        text: "清除日志"
        onClicked: {
            dataManage.sendDataToThread(0,0,"121");
        }
    }



    //右侧频谱区域
    //////////////////////////////////////////////////////////////////////////////
    Item{
        id:rightTopArea
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.left: borderParamConfig.right
        anchors.leftMargin: 4
        anchors.bottom: logBox.bottom
        Rectangle{
            id: scopeViewBox1
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width
            height: 0.5*parent.height - 2
            color: "black"
        }


        Rectangle{
            id: scopeViewBox2
            anchors.top: scopeViewBox1.bottom
            anchors.topMargin: 4
            anchors.left: parent.left
            width: parent.width
            height: 0.5*parent.height - 2
            color: "black"
        }//END 频谱区域
    }
    Item{
        anchors.top: rightTopArea.bottom
        anchors.left: rightTopArea.left
        width: rightTopArea.width
        height: 30
        Row{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 4
            width: 0.8 * parent.width
            height: parent.height
            CheckBoxR{
                id: ch1En
                width: 0.24*parent.width
                height: parent.height
                text:"通道1"
                checked: true
            }
            CheckBoxR{
                id: ch2En
                width: 0.24*parent.width
                height: parent.height
                text:"通道2"
                checked: true
            }
            CheckBoxR{
                id: ch3En
                width: 0.24*parent.width
                height: parent.height
                text:"通道3"
            }
            CheckBoxR{
                id: ch4En
                width: 0.24*parent.width
                height: parent.height
                text:"通道4"
            }
        }
        ButtonN{
            id:btnOnOffMonitor
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: -4
            width: 0.25*parent.width
            height: parent.height
            text: "暂停"
        }
    }// END 右侧频谱区域

    //底部左侧 硬盘状态显示
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:systemStatusBox
        anchors.top: borderCaptureState.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        width: 0.7*parent.width
        color: "black"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }

        Rectangle{
            id:sysStatusTitle
            anchors.top: parent.top
            anchors.topMargin: 1
            width: parent.width
            height: 30
            color: "#404244"
            Row{
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                Rectangle{
                    height: parent.height
                    width: 0.1*parent.width
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"磁盘分区"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.2*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"分区大小"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.2*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"硬盘温度"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.5*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"分区使用率"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
        Component {
            id: sysDelegate
            Item {
                id:sysWrapper
                width: borderSysBox.width
                height: 30
                //color: "#404244"
                Row{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width
                    height: parent.height
                    Item{
                        height: parent.height
                        width: 0.1*parent.width
                        Text{
                            id:iconSSD
                            anchors.top: parent.top
                            anchors.left: parent.left
                            height: parent.height
                            width: height
                            text: icon
                            font.family: "themify"
                            color:textColor
                            font.weight: Font.Bold
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text{
                            anchors.top: parent.top
                            anchors.left: iconSSD.right
                            anchors.right: parent.right
                            height: parent.height
                            text: name
                            font.family: FlatDark.fontFamily
                            color:textColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.2*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text: size
                            font.family: FlatDark.fontFamily
                            color:textColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.2*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text: temp
                            font.family: FlatDark.fontFamily
                            color:textColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Item{
                        width: 0.5*parent.width
                        height: parent.height

                        ProgressGrillX{
                            anchors.fill: parent
                            iw: 6
                            cubeNumber: 50
                            cubeMargin: 1
                            showGrow: false
                            percent:used
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //sysListView.ListView.view.currentIndex = index//更新视图索引
                        //listView.focus = true
                    }
                    onDoubleClicked:
                    {
                    }
                }
            }
        }
        ListModel {
            id: sysModel
            ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD1 C:\\"
                      size: "120GB"
                      temp: "46℃"
                      used: 0.89
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD1 D:\\"
                      size: "120GB"
                      temp: "46℃"
                      used: 0.35
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD2 E:\\"
                      size: "400GB"
                      temp: "52℃"
                      used: 0.55
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD2 F:\\"
                      size: "100GB"
                      temp: "52℃"
                      used: 0.24
                  }

        }
        ScrollView{
            id:borderSysBox
            anchors.top: sysStatusTitle.bottom
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            //ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ListView {
                id:sysListView
                anchors.fill: parent
                model: sysModel
                delegate: sysDelegate
//                highlightMoveDuration: 200
//                highlight: Rectangle {
//                            color: "#808080"
//                          }
                onCurrentIndexChanged: {

                }
            }
        }
    }//END sysStateBox

    //底部右侧 CPU GPU RAM状态显示
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:cpuGpuRamBox
        anchors.top: systemStatusBox.top
        anchors.left: rightTopArea.left
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        width: 0.7*parent.width
        color: "black"
        //border.color: "#808080"
        //radius: 4
        Component.onCompleted: console.log("cpuGpuRamBox::"+parent.height)
        Row{
            anchors.top: parent.top
            anchors.topMargin: 0.1*parent.height
            anchors.left: parent.left
            width: parent.width
            height: 0.8*parent.height
            Item{
                width: 0.33*parent.width
                height: parent.height
                Text{
                    id:cpuLable
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "CPU使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:cpuProcess
                    anchors.top: cpuLable.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:cpuLable2
                    anchors.top: cpuProcess.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  8
                    anchors.right: parent.right
                    height: 30
                    text: "温度:65℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressGrillX{
                    id:cpuTemp
                    anchors.top: cpuLable2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
                }
            }

            Item{
                width: 0.33*parent.width
                height: width
                Text{
                    id:gpuLable
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "GPU使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:gpuProcess
                    anchors.top: gpuLable.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:gpuLable2
                    anchors.top: gpuProcess.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  8
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressGrillX{
                    id:gpuTemp
                    anchors.top: gpuLable2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
                }
            }
            Item{
                width: 0.33*parent.width
                height: width
                Text{
                    id:ramLable
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "RAM使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:ramProcess
                    anchors.top: ramLable.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:ramLable2
                    anchors.top: ramProcess.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  12
                    anchors.right: parent.right
                    height: 30
                    text: "总内存:16 GB"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                Text{
                    id:ramLable3
                    anchors.top: ramLable2.bottom

                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    height: 20
                    text: "虚拟内存:16 GB"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }

    }//END 底部右侧 CPU GPU RAM状态显示



    function setCaptureParams()
    {

    }




    function safeClean()
    {
//        scopeView1.stop()
//        scopeView2.stop()
//        scopeView3.stop()
        //stopRefreshTimer
    }


}

