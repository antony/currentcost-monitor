<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>CurrentCost Readings</title>
    <script type='text/javascript' src='http://www.google.com/jsapi'></script>
    <script type='text/javascript'>
      google.load('visualization', '1', {'packages':['annotatedtimeline']});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('datetime', 'Date');
        data.addColumn('number', 'Watts');
        data.addColumn('number', 'temperature');
        data.addRows([
          <g:each in="${readings}" var="reading">
                [new Date(${reading.timestamp}), ${reading.watts}, ${reading.temperature}],
          </g:each>
          null
        ]);

        var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div'));
        chart.draw(data, {displayAnnotations: true});
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
      div#chart_div {
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
        <div id='chart_div' style='width: 700px; height: 240px;'></div>  
      </div>
    </div>
  </body>
</html>