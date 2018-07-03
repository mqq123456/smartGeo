
var dom = document.getElementById("POIYun");
var myChart = echarts.init(dom);
var app = {};
var data = [{
            name: '美食',
            value: 64
//            ,textStyle: {
//                normal: {
//                    color: 'black'
//                },
//                emphasis: {
//                    color: 'red'
//                }
//            }
        }, {
            name: '购物&丽人',
            value: 45
        }, {
            name: '亲子',
            value: 12
        }, {
            name: '休闲娱乐',
            value: 3
        }, {
            name: '教育',
            value: 2
        }];
option = null;
var option = {  
        tooltip : {},  
        series : [ {  
            type : 'wordCloud',  
            shape:'circle',  
            gridSize : 20,  
            sizeRange : [ 12, 50 ],  
            rotationRange : [ 0, 0 ],  
            textStyle : {  
                normal : {  
                    color : function() {  
                        return 'rgb('  
                                + [ Math.round(Math.random() * 160),  
                                        Math.round(Math.random() * 160),  
                                        Math.round(Math.random() * 160) ]  
                                        .join(',') + ')';  
                    }  
                },  
                emphasis : {  
                    shadowBlur : 10,  
                    shadowColor : '#333'  
                }  
            },  
            data : data  
        } ]  
    };  
;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
