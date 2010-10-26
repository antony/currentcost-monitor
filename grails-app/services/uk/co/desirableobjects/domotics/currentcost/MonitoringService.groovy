package uk.co.desirableobjects.domotics.currentcost

import uk.co.desirableobjects.domotics.currentcost.exception.CurrentCostResponseException
import uk.co.desirableobjects.domotics.currentcost.exception.UnsupportedResponseException
import groovy.util.slurpersupport.GPathResult

import org.codehaus.groovy.grails.commons.ConfigurationHolder

class MonitoringService {

    CurrentCostReader currentCostReader

    static transactional = true

    static String DEFAULT_DATE_FORMAT = "dd/MM/yyyy HH:mm:ss"

    def takeReading() {

      try {
        String xml = currentCostReader.fetchReading()
        log.debug("xml: ${xml}")
        GPathResult message = new XmlSlurper().parseText(xml)

        if (!message.hist.toString().isEmpty()) {
          throw new UnsupportedResponseException()
        }

        String readingTime = new Date().format("dd/MM/yyyy ${message.time.toString()}")

        Long timestamp = Calendar.instance.time.parse(DEFAULT_DATE_FORMAT, readingTime).time

        ConfigurationHolder.config.currentcost.channels.each { channel ->
          Reading reading = new Reading(timestamp:timestamp,
                  temperature:message.tmpr.toString() as Double,
                  watts:message[channel].watts.toString() as Integer,
                  channel:1)
          if (!reading.save()) {
            log.error("Could not save reading. Reason: "+reading.errors)  
          }
        }
      } catch (UnsupportedResponseException ure) {
        log.warn("History is not yet implemented.")
      } catch (CurrentCostResponseException cre) {
        log.warn("Unable to obtain reading.")
      }

    }

    List<Reading> fetchConsumption(long from, long to) {

      def criteria = Reading.createCriteria()
      return criteria {
        between('timestamp', from, to)  
      }
      
    }
}
