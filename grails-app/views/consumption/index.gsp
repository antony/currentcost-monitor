<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Domotics: Energy and Temperature</title>

    <jq:resources />
    <g:javascript library="highcharts" />

    <script type='text/javascript'>

    var wattage, temperature; // globally available
    $(document).ready(function() {
          wattage = new Highcharts.Chart({
             chart: {
                renderTo: 'wattage-chart',
                defaultSeriesType: 'line'
             },
             title: {
                text: ''
             },
             xAxis: {
                title: {
                   text: 'Wattage'
                },
                type: 'datetime'
             },
             yAxis: {
                title: {
                   text: 'Time / Date'
                }
             },
             series: [{
                name: 'Watts',
                data: [
                  <g:each in="${readings}" var="reading">
                    [${reading.timestamp}, ${reading.watts}],
                  </g:each>
                ]
             }]
          });

            temperature = new Highcharts.Chart({
               chart: {
                  renderTo: 'temperature-chart',
                  defaultSeriesType: 'line'
               },
               title: {
                  text: ''
               },
               xAxis: {
                  title: {
                     text: 'Temperature'
                  },
                  type: 'datetime'
               },
               yAxis: {
                  title: {
                     text: 'Time / Date'
                  }
               },
               series: [{
                  name: 'Celsius',
                  data: [
                    <g:each in="${readings}" var="reading">
                      [${reading.timestamp}, ${reading.temperature}],
                    </g:each>
                  ]
               }]
            });
         });
    </script>
    <style type="text/css">
      @font-face { font-family: Delicious; src: url(${resource(dir:'fonts', file:'Delicious-Roman.otf')}); }
      @font-face { font-family: "Delicious Bold"; src: url(${resource(dir:'fonts', file:'Delicious-Bold.otf')}); }
    </style>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'main.css')}" />
  </head>
  <body>
  <div class="module">
    <div class="description">&nbsp;</div>
    <div class="content">
      <h1>Home Automation</h1>
      <h2>Energy Usage Monitoring</h2>
    </div>
  </div>
  <div class="module">
    <div class="description">
      <h2>Wattage Graph</h2>
      <h3>Historical energy usage, in kWh</h3>
    </div>
    <div class="content">
      <div id="wattage-chart" class="chart"></div>
    </div>
  </div>
  <div class="module">
    <div class="description">
      <h2>Temperature</h2>
      <h3>Historical outside building temperature</h3>
    </div>
    <div class="content">
      <div id="temperature-chart" class="chart"></div>
    </div>
  </div>
  <div class="module" id="footer">
    <div class="description">&nbsp;</div>
    <div class="content">
      Designed and developed by <span class="important">DesirableObjects</span>. Powered by &nbsp;
      <g:link url="http://grails.org">
        <img id="grails-logo" src="${resource(dir:'images', file:'grails_logo.png')}" alt="Grails" />
      </g:link>
    </div>
  </div>
  </body>
</html>