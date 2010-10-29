<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Domotics: Energy and Temperature</title>
    <script type='text/javascript' src='http://www.google.com/jsapi'></script>
    <script type='text/javascript'>

      var wattageData = [];
      var temperatureData = [];
      <g:each in="${readings}" var="reading">
            wattageData.push([new Date(${reading.timestamp}), ${reading.watts}]);
            temperatureData.push([new Date(${reading.timestamp}), ${reading.temperature}]);
      </g:each>

      google.load('visualization', '1', {'packages':['annotatedtimeline']});
      google.setOnLoadCallback(drawCharts);

      function drawCharts() {

        var wattage = new google.visualization.DataTable();
        wattage.addColumn('datetime', 'Date');
        wattage.addColumn('number', 'Watts');
        wattage.addRows(wattageData);

        var temperature = new google.visualization.DataTable();
        temperature.addColumn('datetime', 'Date');
        temperature.addColumn('number', 'Temperature (C)');
        temperature.addRows(temperatureData);

        var wattageChart = new google.visualization.AnnotatedTimeLine(document.getElementById('wattage_chart'));
        wattageChart.draw(wattage, {displayAnnotations: true});

        var temperatureChart = new google.visualization.AnnotatedTimeLine(document.getElementById('temperature_chart'));
        temperatureChart.draw(temperature, {displayAnnotations: true});
      }
    </script>
    <style type="text/css">
      @font-face { font-family: Delicious; src: url(${resource(dir:'fonts', file:'Delicious-Roman.otf')}); }
      @font-face { font-family: "Delicious Bold"; src: url(${resource(dir:'fonts', file:'Delicious-Bold.otf')}); }
      body {
        background: #000 url(${resource(dir:'images', file:'background.jpg')}) repeat top left;
      }
      div.content {
        background: transparent url(${resource(dir:'images', file:'semi.png')}) repeat top left;
      }
    </style>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'main.css')}" />
  </head>
  <body>
    <div id="outer">
      <div id="inner" class="content">
        <div class="section">
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
        <div class="section">
          <h2>Temperature Monitoring</h2>
        </div>
        <div id='temperature_chart' class="chart" style='width: 700px; height: 240px;'></div>
      </div>
      <div id="footer" class="content">
        Designed and developed by <span class="important">DesirableObjects</span>. Powered by &nbsp;
        <g:link url="http://grails.org">
          <img id="grails-logo" src="${resource(dir:'images', file:'grails_logo.png')}" alt="Grails" />
        </g:link>
      </div>
    </div>
  </body>
</html>