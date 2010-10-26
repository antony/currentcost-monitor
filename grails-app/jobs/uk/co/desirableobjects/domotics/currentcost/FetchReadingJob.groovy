package uk.co.desirableobjects.domotics.currentcost

import uk.co.desirableobjects.domotics.currentcost.MonitoringService

class FetchReadingJob {

    MonitoringService monitoringService
  
    def timeout = 3000l

    def execute() {
      monitoringService.takeReading()
    }

}
