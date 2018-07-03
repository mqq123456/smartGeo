
var dom = document.getElementById("onOrOutPeople");
var myChart = echarts.init(dom);
var app = {};
option = null;
option = {
    tooltip : {
    trigger: 'axis'
    },
legend: {
data:['阜通西大街','阜安路','相邻-宝星华庭','相邻街-宝星园二期']
},
    calculable : true,
    xAxis : [
             {
             type : 'category',
             data : ['6:00','7:00','8:00','9:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00']
             }
             ],
    yAxis : [
             {
             type : 'value'
             }
             ],
    series : [
              {
              name:'阜通西大街',
              type:'line',
              data:[200,400,600,800,500,400,1000,600,400,400,300,500,700,800,500,300,100,50]
              },
              {
              name:'阜安路',
              type:'line',
              data:[100,300,500,900,400,300,800,400,300,300,200,300,500,800,800,400,100,50]
              },
              {
              name:'相邻-宝星华庭',
              type:'line',
              data:[10,30,50,90,40,30,80,40,30,30,20,30,50,80,80,40,10,5]
              },
              {
              name:'相邻街-宝星园二期',
              type:'line',
              data:[20,40,60,80,50,40,100,60,40,40,30,50,70,80,50,30,10,5]
              }
              ]
};
;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
