import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    anchors.fill: parent
    property var host

    Column {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 12

        RowLayout {
            width: parent.width
            spacing: 12

            Text {
                text: "Servers"
                font.pixelSize: 26
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "Add Server"
                onClicked: root.host.currentPage = "pages/AddServer.qml"
            }
        }

        Text {
            text: serverController.error
            visible: serverController.error.length > 0
        }

        ListView {
            id: list
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height - 100
            model: serverController.servers
            clip: true
            spacing: 8

            delegate: Rectangle {
                width: list.width
                height: 70

                Row {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Column {
                        width: parent.width - 120
                        spacing: 4
                        Text { text: modelData.name; font.pixelSize: 18 }
                        Text {
                            text: modelData.address + (modelData.port > 0 ? (":" + modelData.port) : "")
                            opacity: 0.8
                        }
                    }

                    Button {
                        text: "Remove"
                        onClicked: serverController.removeServer(index)
                    }
                }
            }
        }

        Button {
            text: "Back Home"
            onClicked: root.host.currentPage = "pages/Home.qml"
        }
    }
}
