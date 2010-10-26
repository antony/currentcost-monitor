package uk.co.desirableobjects.domotics.currentcost

import gnu.io.CommPortIdentifier
import gnu.io.SerialPort
import uk.co.desirableobjects.domotics.currentcost.exception.CurrentCostResponseException

class CurrentCostReader {

  public static int    BAUDRATE = 57600;

  CommPortIdentifier  portFound = null
  String		      defaultPort = "/dev/ttyUSB0"  

  String fetchReading() {

      def portList = CommPortIdentifier.portIdentifiers

      portFound = (CommPortIdentifier) portList.find { port ->
        CommPortIdentifier.PORT_SERIAL.equals(port.portType) && defaultPort == port.name
      }

      log.info "Serial port: Looked for ${defaultPort} and found ${portFound}"

      String xml = ""
      if (portFound) {   

        SerialPort serialPort = (SerialPort) portFound.open("CurrentCostMonitor", 2000)
        serialPort.setSerialPortParams(BAUDRATE, SerialPort.DATABITS_8,
                         SerialPort.STOPBITS_1,
                         SerialPort.PARITY_NONE);

        BufferedReader bufferedReader = new BufferedReader(
                new InputStreamReader(serialPort.getInputStream())
        )
        
        while (!xml.endsWith("</msg>")) {
            try {
              xml += bufferedReader.readLine()
            } catch (IOException ioe) {
              xml = ""
              log.error "Unable to fetch stream."
            }
        }

        if (serialPort != null) {
          serialPort.close();
        }

        return xml

      } else {
        throw new CurrentCostResponseException("Could not open port.")
      }
  }
}
