package uk.co.desirableobjects.domotics.currentcost

import gnu.io.SerialPortEventListener
import gnu.io.SerialPortEvent

class CurrentCostDataEventListener implements SerialPortEventListener {

    public void serialEvent(SerialPortEvent event) {

        switch (event.getEventType()) {
            case SerialPortEvent.DATA_AVAILABLE:
                System.out.println("Data available");
                break;
        }
    }


}
