package currentcost.monitor

class FetchReadingJob {

    MonitoringService monitoringService
  
    def timeout = 3000l

    def execute() {
      monitoringService.takeReading()
    }

}
