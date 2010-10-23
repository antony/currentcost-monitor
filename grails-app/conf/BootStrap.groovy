import currentcost.monitor.CurrentCostReader

class BootStrap {

    def init = { servletContext ->

      def log = org.apache.commons.logging.LogFactory.getLog(CurrentCostReader)
      CurrentCostReader.metaClass.getLog << {-> log}

    }
    def destroy = {
    }
}
