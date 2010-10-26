import uk.co.desirableobjects.domotics.currentcost.CurrentCostReader
import uk.co.desirableobjects.domotics.currentcost.MonitoringService

beans = {
  currentCostReader(CurrentCostReader)

  monitoringService(MonitoringService) {
    currentCostReader = currentCostReader
  }

}
