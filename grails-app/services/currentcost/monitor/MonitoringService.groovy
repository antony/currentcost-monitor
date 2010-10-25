package currentcost.monitor

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

import currentcost.monitor.exception.CurrentCostResponseException
import currentcost.monitor.exception.UnsupportedResponseException
import groovy.util.slurpersupport.GPathResult

class MonitoringService {

    CurrentCostReader currentCostReader

    static transactional = true

    def takeReading() {

      try {
        String xml = currentCostReader.fetchReading()
        println "xml: ${xml}"
        GPathResult message = new XmlSlurper().parseText(xml)

        if (!message.hist.toString().isEmpty()) {
          throw new UnsupportedResponseException()
        }

        String readingTime = new Date().format("dd/MM/yyyy ${message.time.toString()}")

        Long timestamp = Calendar.instance.time.parse('dd/MM/yyyy HH:mm:ss', readingTime).time

        CH.config.currentcost.channels.each { channel ->
          Reading reading = new Reading(timestamp:timestamp,
                  temperature:message.tmpr.toString() as Double,
                  watts:message[channel].watts.toString() as Integer,
                  channel:1)
          if (!reading.save()) {
            log.error("Could not save reading. Reason: "+reading.errors)  
          }
        }
      } catch (UnsupportedResponseException ure) {
        log.error("History is not yet implemented.")
      } catch (CurrentCostResponseException cre) {
        log.error("Unable to obtain reading.")
      }

    }

    List<Reading> fetchConsumption(long from, long to) {

      println "from ${new Date(from).format("dd/MM/yyyy hh:mm:ss")} to ${new Date(to).format("dd/MM/yyyy hh:mm:ss")}"


      Reading.findAll().each { println new Date(it.timestamp).format("dd/MM/yyyy hh:mm:ss") }

      def criteria = Reading.createCriteria() 
      return criteria {
        between('timestamp', from, to)  
      }
      
    }
}
