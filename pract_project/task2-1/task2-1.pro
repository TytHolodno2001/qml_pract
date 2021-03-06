QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc \
    image.qrc

TRANSLATIONS += \
    task2-1_ru_RU.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    ArrowBigBlack.png \
    ArrowBigBlue.png \
    ArrowBigWhite.png \
    ArrowSmallBlack.png \
    ArrowSmallWhite.png \
    BASIDark.png \
    BASILight.png \
    PPODark.png \
    PPOLight.png \
    PPUDark.png \
    PPULight.png \
    StateActive.png \
    StateDark.png \
    StateLight.png \
    ThemeDark.png \
    ThemeLight.png \
    arrow.png \
    errorInfo.qml \
    expressHelp.qml \
    funckBlock.qml \
    list.qml \
    no.png \
    table.qml \
    yes.png

HEADERS +=
