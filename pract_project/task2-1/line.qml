import QtQuick 2.15

Item {
    id: it
    property real x1: 0
    property real y1: 0
    property real x2: 300
    property real y2: 300
    z: 1
    Rectangle {
        id: l
        color: "black"
        height: 3
        smooth: true;


        property real x1: it.x1
        property real y1: it.y1
        property real x2: it.x2
        property real y2: it.y2

        x: x1
        y: y1 - height / 2

        transformOrigin: Item.Left;

        width: getWidth(x1, y1, x2, y2);
        rotation: getSlope(x1, y1, x2, y2);

        function getWidth(sx1, sy1, sx2, sy2)
        {
            var w = Math.sqrt(Math.pow((sx2 - sx1), 2) + Math.pow((sy2 - sy1), 2));
            return w;
        }

        function getSlope(sx1,sy1,sx2,sy2)
        {
            var a, m, d;
            var b = sx2 - sx1;
            if (b === 0) {
                x = x + height
                return 90;
            }
            a = sy2 - sy1;
            m = a / b;
            d = Math.atan(m) * 180 / Math.PI;

            if (a < 0 && b < 0)
                return d + 180;
            else if (a >= 0 && b >= 0)
                return d;
            else if (a < 0 && b >= 0)
                return d;
            else if (a >= 0 && b < 0)
                return d + 180;
            else
                return 0;
        }
    }
}
