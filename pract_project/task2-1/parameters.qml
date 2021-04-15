pragma Singleton // Указываем, что этот QML Тип является синглетоном
import QtQuick 2.0

Item {
    //значения цветов
    property color accentСolor1: "#48D3FF"
    property color accentСolor2: "#DE242F"
    property color accentСolor3: "#0081C2"
    //для темной темы
    property color dbgColor: "#2F3140"
    property color delemFirstColor: "#393B4E"
    property color delemSecondColor: "#43455A"
    property color delemThirdColor: "#4D4F67"
    property color dtextColor1: "#ECECEC"
    property color dtextColor2: "#48D3FF"
    //для светлой темы
    property color lbgColor: "#d3d5e8"
    property color lelemFirstColor: "#edeffa"
    property color lelemSecondColor: "#FFFFFF"
    property color lelemThirdColor: "#dadceb"
    property color ltextColor1: "#2F3140"
    property color ltextColor2: "#696B7D"
    //значения текста
    property string textFontFamily: "Exo 2"
    property int textButtonSize: 12 / 1.5
    property int textFBSize: 38/ 1.5
    property int textTitleSize: 40/ 1.5
    property string textRegularBold: "Regular"
    property string textLightBold: "Light"
    //отступы
    property int margin80: 80/ 1.5
    property int margin48: 48/ 1.5
    property int margin32: 32/ 1.5
    property int margin24: 24/ 1.5
    property int margin16: 16/ 1.5
    //скругление
    property int elemRadius: 16/ 1.5
    //рамки
    property int sizeFrame: 2
    //тени
    property int horizOffset: 0
    property int verticOffset: 0
    property color dDropShadowColor: "#2C2D35"
    property color lDropShadowColor: "#636782"
    property int mainRadius: 30/ 1.5
    property int mainSamples: 60/ 1.5
    property int darkRadius: 20/ 1.5
    property int darkSamples: 25/ 1.5
    property int lightRadius: 20/ 1.5
    property int lightSamples: 10/ 1.5
    //размеры
    //Кнопка-большая-desktop
    property int buttonBigWidth: 400/ 1.5
    property int buttonBigHeight: 80/ 1.5
    //Кнопка-маленькая-desktop
    property int buttonSmallWidth: 336/ 1.5
    property int buttonSmallHeight: 72/ 1.5
    //Функциональный блок
    property int fBWidth: 400/ 1.5
    property int fBHeight:96/ 1.5
    //ФБ - элемент выбора
    property int fBSelectSmallWidth:100/ 1.5
    property int fBSelectBigWidth: 200/ 1.5
    property int fBSelectHeight: 72/ 1.5
    //кнопка выбора темы
    property int buttonThemeSize: 80/ 1.5
    //связь
    property int connectWidth: 3/ 1.5
    //иконки
    property string iconArrowBigBlack: "file:/pract_project/task2-1/ArrowBigBlack"
    property string iconArrowBigBlue: "file:/pract_project/task2-1/ArrowBigBlue"
    property string iconArrowBigWhite: "file:/pract_project/task2-1/ArrowBigWhite"
    property string iconArrowSmallBlack: "file:/pract_project/task2-1/ArrowSmallBlack"
    property string iconArrowSmallWhite: "file:/pract_project/task2-1/ArrowSmallWhite"
    property string iconBASIDark: "file:/pract_project/task2-1/BASIDark"
    property string iconBASILight: "file:/pract_project/task2-1/BASILight"
    property string iconBAPPDDark: "file:/pract_project/task2-1/BASIDark"
    property string iconBAPPDLight: "file:/pract_project/task2-1/BASILight"
    property string iconPPODark: "file:/pract_project/task2-1/PPODark"
    property string iconPPOLight: "file:/pract_project/task2-1/PPOLight"
    property string iconPPUDark: "file:/pract_project/task2-1/PPUDark"
    property string iconPPULight: "file:/pract_project/task2-1/PPULight"
    property string iconStateActive: "file:/pract_project/task2-1/StateActive"
    property string iconStateDark: "file:/pract_project/task2-1/StateDark"
    property string iconStateLight: "file:/pract_project/task2-1/StateLight"
    property string iconThemeDark: "file:/pract_project/task2-1/ThemeDark"
    property string iconThemeLight: "file:/pract_project/task2-1/ThemeLight"
}
