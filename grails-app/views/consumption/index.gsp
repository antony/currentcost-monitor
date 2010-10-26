<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>CurrentCost Readings</title>
    <script type='text/javascript' src='http://www.google.com/jsapi'></script>
    <script type='text/javascript'>

      var wattageData = []
      var temperatureData = []
      <g:each in="${readings}" var="reading">
            wattageData.push(new Date(${reading.timestamp}, ${reading.watts}));
            temperatureData.push(new Date(${reading.timestamp}, ${reading.temperature}));
      </g:each>

      google.load('visualization', '1', {'packages':['annotatedtimeline']});
      google.setOnLoadCallback(drawCharts);

      function drawCharts() {

        var wattageData = new google.visualization.DataTable();
        wattageData.addColumn('datetime', 'Date');
        wattageData.addColumn('number', 'Watts');
        wattageData.addRows();

        var temperatureData = new google.visualization.DataTable();
        temperatureData.addColumn('datetime', 'Date');
        temperatureData.addColumn('number', 'Temperature (C)');
        temperatureData.addRows();

        var wattageChart = new google.visualization.AnnotatedTimeLine(document.getElementById('wattage_chart'));
        wattageChart.draw(wattageData, {displayAnnotations: true});

        var wattageChart = new google.visualization.AnnotatedTimeLine(document.getElementById('temperature_chart'));
        wattageChart.draw(temperatureData, {displayAnnotations: true});
      }
    </script>
    <style type="text/css">
      @font-face { font-family: Delicious; src: url(${resource(dir:'fonts', file:'Delicious-Roman.otf')}); }
      @font-face { font-family: "Delicious Bold"; src: url(${resource(dir:'fonts', file:'Delicious-Bold.otf')}); }
      body {
        font-family: "Delicious", sans-serif;
        color: #fff;
        margin: 0;
        padding: 0;
        background: #000 url(${resource(dir:'images', file:'background.jpg')}) repeat top left;
      }
      h1 {
        font-family: "Delicious Bold", sans-serif;
      }
      h1, h2, h3 {
        margin: 0.2em 0;
      }
      div#section {
        margin: 1em 0 1em 2em;
      }
      div#outer {
        text-align: center;
      }
      a {
        color: #86ff1d;
      }
      div#inner {
        text-align: left;
        border: 1px solid #fff;
        background: transparent url(${resource(dir:'images', file:'semi.png')}) repeat top left;
        width: 760px;
        margin: 2em auto;
        padding: 0 0 2em 0;
      }
      div.chart {
        margin: 0 auto;
      }
    </style>
  </head>
  <body>
    <div id="outer">
      <div id="inner">
        <div id="section">
          <h1>Home Automation</h1>
          <h2>Energy Usage Monitoring</h2>
          <h2>For ${window} <g:each in="${windows}" var="windowName">
              <g:if test="${windowName.value != window}">
                | <g:link controller="consumption" params="${[window:windowName.key]}">${windowName.value}</g:link>
              </g:if>
            </g:each>
          </h2>
        </div>
        <div id='wattage_chart' class="chart" style='width: 700px; height: 240px;'></div>
        <h2>Temperature Monitoring</h2>
        <div id='temperature_chart' class="chart" style='width: 700px; height: 240px;'></div>
      </div>
    </div>
  </body>
</html>