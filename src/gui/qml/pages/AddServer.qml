import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent
    property var host

    Column {
        anchors.centerIn: parent
        width: 360
        spacing: 10

        Text { text: "Add Server"; font.pixelSize: 26 }

        TextField { id: nameField; placeholderText: "Name (e.g. Aeterna Main)" }
        TextField { id: addrField; placeholderText: "Address (e.g. example.com or 192.168.1.10)" }
        TextField { id: portField; placeholderText: "Port (optional)"; inputMethodHints: Qt.ImhDigitsOnly }
        TextArea  { id: notesField; placeholderText: "Notes (optional)"; height: 90 }

        Text {
            text: serverController.error
            visible: serverController.error.length > 0
        }

        Row {
            spacing: 10
            Button {
                text: "Save"
                onClicked: {
                    let p = parseInt(portField.text)
                    if (isNaN(p)) p = 0
                    serverController.addServer(nameField.text, addrField.text, p, notesField.text)
                    if (serverController.error.length === 0) {
                        root.host.currentPage = "pages/Servers.qml"
                    }
                }
            }
            Button {
                text: "Cancel"
                onClicked: root.host.currentPage = "pages/Servers.qml"
            }
        }
    }
}
