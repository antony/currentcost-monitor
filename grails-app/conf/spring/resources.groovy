import currentcost.monitor.FetchReadingJob
import currentcost.monitor.CurrentCostReader
import currentcost.monitor.MonitoringService

beans = {
  currentCostReader(CurrentCostReader)

  monitoringService(MonitoringService) {
    currentCostReader = currentCostReader
  }

}
