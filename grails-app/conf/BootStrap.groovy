import uk.co.desirableobjects.domotics.currentcost.CurrentCostReader

class BootStrap {

    def init = { servletContext ->

      def log = org.apache.commons.logging.LogFactory.getLog(CurrentCostReader)
      CurrentCostReader.metaClass.getLog << {-> log}

      // serialPort.addEventListener(new CurrentCostDataEventListener());
      // serialPort.notifyOnDataAvailable(true);

    }

    def destroy = {
        
    }
}
