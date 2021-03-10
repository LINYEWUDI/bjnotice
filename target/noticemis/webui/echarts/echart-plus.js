
(function () {

    let echartBar=function (option) {

        let defaultOption={
            data:[],
            title:'柱状图统计',
            dom:document.querySelector("#container7")
        };
        Object.assign(defaultOption,option);

        let xdata=defaultOption.data.map(c=>c.name);
        let ydata=defaultOption.data.map(c=>c.value);
        var myChart = echarts.init(defaultOption.dom);
        var option = {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data:[]
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data:xdata,
                    rotate:40,interval:0
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:defaultOption.title,
                    type:'bar',
                    barWidth:'30',
                    data:ydata,
                    itemStyle: {
                        normal: {
                            color:"#269fec"
                        }
                    }

                }
            ]
        };
        myChart.setOption(option);


    };

    let echartLine=function (option) {

        let defaultOption={
            data:[],
            title:'折线图',
            dom:document.querySelector("#container4")
        };
        Object.assign(defaultOption,option);
        let legend=[];
        legend.push(defaultOption.title);
        let xdata=[];
        let ydata=[];
        if(defaultOption.xdata==null)
          xdata=defaultOption.data.map(c=>c.name);
        else
            xdata=defaultOption.xdata;
        if(defaultOption.ydata==null)
            ydata=defaultOption.data.map(c=>c.value);
        else
            ydata=defaultOption.ydata;

        var myChart = echarts.init(defaultOption.dom);
        var option = {
            tooltip : {
                trigger: 'axis',
                axisPointer : {
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data:legend
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data:xdata
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:defaultOption.title,
                    type:'line',
                    data:ydata
                }
            ]
        };
        myChart.setOption(option);

    };



    let echartPie=function (option) {


        let defaultOption={
            data:[],
            title:'柱状图统计',
            dom:document.querySelector("#container5")
        };
        Object.assign(defaultOption,option);
        let pieData=defaultOption.data;
        let legendData=defaultOption.data.map(c=>c.name);

        let myChart = echarts.init(defaultOption.dom);
        option = {
            tooltip : {
                trigger: 'item',
                formatter: "{a} {b} : {c} ({d}%)"
            },
            legend: {
                orient : 'vertical',
                x : 'left',
                data:legendData
            },
            calculable : false,
            series : [
                {
                    name:defaultOption.title,
                    type:'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data:pieData
                }
            ]
        };
        myChart.setOption(option);


    };



  window.echartPlus={
      echartBar:echartBar,
      echartPie:echartPie,
      echartLine:echartLine
  }


})(window);
