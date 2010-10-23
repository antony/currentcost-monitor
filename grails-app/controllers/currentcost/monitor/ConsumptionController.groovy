package currentcost.monitor

class ConsumptionController {

    MonitoringService monitoringService

    Map<String, String> windows = ['today':'today', 'yesterday':'yesterday', 'week':'this week', 'month':'this month']

    def index = {

      Date today = new Date()
      Date oneDayAgo, twoDaysAgo, oneWeekAgo, oneMonthAgo
      use(org.codehaus.groovy.runtime.TimeCategory) {
        oneDayAgo = (today - 1.day)
        twoDaysAgo = (today - 2.days)
        oneWeekAgo = (today - 1.week)
        oneMonthAgo = (today - 1.month)
      }

      List<Reading> readings
      switch (params.timeout) {
        case 'month':
          readings = monitoringService.fetchConsumption(oneMonthAgo.time, today.time)
          break
        case 'week':
          readings = monitoringService.fetchConsumption(oneWeekAgo.time, today.time)
          break
        case 'yesterday':
          readings = monitoringService.fetchConsumption(twoDaysAgo.time, oneDayAgo.time)
          break
        case 'today':
        default:
          readings = monitoringService.fetchConsumption(oneDayAgo.time, today.time)
      }

      String currentWindow = windows[params.window] ?: windows['today']

      render(view:'index', model:[readings: readings, windows:windows, window:currentWindow])

    }
}
