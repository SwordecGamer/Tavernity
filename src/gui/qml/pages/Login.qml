import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent

    property var host

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {text: "Welcome to Tavernity!"; font.pixelSize: 26}
        Text {text: "Please log in or register."; font.pixelSize: 12}

        TextField {id: userField; placeholderText: "username"}
        TextField {id: passField; placeholderText: "password"}

        Button {
            text: loginController.busy ? "Logging in..." : "Login"
            enabled: !loginController.busy
            onClicked: loginController.login(userField.text, passField.text)
        }

        Text {
            text: loginController.error
            visible: loginController.error.length > 0
        }

        Button {
            text: "Go to Register"
            onClicked: root.host.currentPage = "pages/Register.qml"
        }
    }

    Connections {
        target: loginController
        function onLoginSuccess(token) {
            root.host.token = token
            root.host.currentPage = "pages/Home.qml"
        }
    }
}