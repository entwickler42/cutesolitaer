include(../cutecommon/cutecommon.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

TARGET = CuteSolitaer
VERSION = 1.0.2
DEFINES += CC_VERSION=$$VERSION CC_TARGET=$$TARGET

symbian{
    ICON = cutesolitaer.svg
    #TARGET.UID3 = 0xE0B22095
    TARGET.UID3 = 0x2006a743
    TARGET.CAPABILITY += NetworkServices
    vendorinfo += "%{\"CuteCube\"}" ":\"CuteCube\""
    my_deployment.pkg_prerules += vendorinfo
    DEPLOYMENT += my_deployment
    DEPLOYMENT.installer_header = 0x2002CCCF
}

win32{
    RC_FILE = cutesolitaer.rc
}

SOURCES += main.cpp

RESOURCES += \
    cutesolitaer.qrc

OTHER_FILES += android\AndroidManifest.xml \
    cutesolitaer.rc \
    ImportFileList.inc \
    acmesab.ttf \
    service-login.wav \
    service-logout.wav \
    dialog-error.wav \
    bell.wav \
    home.png \
    qml/cutesolitaer/csengine.js \
    qml/cutesolitaer/CSBoard.qml \
    qml/cutesolitaer/CSTile.qml \
    qml/cutesolitaer/CS.qml \
    qml/cutesolitaer/CSPalette.qml \
    qml/cutesolitaer/CSCredits.qml \
    qml/cutesolitaer/CSFrame.qml \
    qml/cutesolitaer/CSMenu.qml \
    qml/cutesolitaer/CSMessageBox.qml
