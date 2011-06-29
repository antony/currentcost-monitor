grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.dependency.resolution = {
    inherits("global") {
    }
    log "warn"
    repositories {
        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()
    }
    dependencies {

        runtime 'org.rxtx:rxtx:2.1.7',
                'mysql:mysql-connector-java:5.1.5'
    }
    plugins {
        runtime ':calendar:1.2.1', ':hibernate:1.3.7', ':quartz:0.4.2', ':tomcat:1.3.7', ':jquery:latest.integration'
    }
}
