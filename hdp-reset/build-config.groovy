#!/usr/bin/env groovy

def cli = new CliBuilder()
cli.af(longOpt: 'ambari-source-file', args: 1, required: true, 'Source File of current properties, REQUIRED')
cli.xbd(longOpt: 'xml-base-dir', args: 1, required: false, 'XML Source File of current properties, OPTIONAL')
cli.xc(longOpt: 'xml-component', args: 1, required: false, 'XML Component File of current properties, OPTIONAL')
cli.cf(longOpt: 'check-file', args: 1, required: true, 'Check configuration file, REQUIRED')
cli.osf(longOpt: 'output-set-file', args: 1, required: false, 'Output Set File that will be posted to Ambari')

def options = cli.parse(this.args)

// Read the source file and get the current properties. Add them to a target dictionary that
// will be used to build the output-set-file.
def component_properties = [:]

def inSection = false;

/*
baseDirectory = new File(options.xbd);

baseDirectory.eachDirRecurse { directory ->
    directory.eachFile(FileType.FILES, {
        file ->
            if (file.name.equals(options.xc + ".xml")) {
                println("File Parent: " + file.parentFile.name);
            }
    })
}
 */

ambari_properties = new File(options.af);
ambari_properties.eachLine { line ->
    // Find the line
    if ( !inSection && line.startsWith("\"properties\"")) {
        inSection = true;
    } else if (inSection) {
        if (line.startsWith("\"")) {
            pair = line.split(":", 2)
            key = pair[0].trim().substring(1,pair[0].trim().length()-1)
            value = pair[1].trim()
            if (value.endsWith(",")) {
                value = value.substring(1,value.length()-2)
            } else {
                value = value.substring(1,value.length()-1)
            }
            component_properties.put(key, value)
        } else {
            inSection = false
        }
    }
}

//println component_properties;

def target_properties = [:]
/*
Using the check file, loop through the properties to RESET,ENSURE,ENSURE_ALERT the
current properties in Ambari.

The resulting list is feed back into Ambari to update the configuration.
 */
check_file = new File(options.cf)
check_file.eachLine { line ->
    if (!line.startsWith("#") && line.trim().length() > 0) {
//        println line
        def check_set = line.split("\\|")
        key = check_set[0].trim().substring(1,check_set[0].trim().length()-1)
        value = check_set[1].trim()
        type = check_set[2]
        if (value.endsWith(",")) {
            value = value.substring(1,value.length()-2)
        } else {
            value = value.substring(1,value.length()-1)
        }

        switch (type) {
            case "RESET":
                target_properties.put(key, value)
                break
            case "ENSURE":
                if (component_properties.get(key,"NOT_SET").equals("NOT_SET")) {
                    target_properties.put(key, value)
                } 
                // else {
                    // target_properties.put(key, value)
               //  }
                break
            case "ENSURE_ALERT":
                if (component_properties.get(key,"NOT_SET").equals("NOT_SET")) {
                    target_properties.put(key, value)
                }
                // else {
                   // target_properties.put(key, component_properties.get(key))
                //}
                break
        }
    }
}


// Make sure all the old properties have been transferred.
component_properties.keySet().each { key ->
    if (target_properties.get(key,"NOT_SET").equals("NOT_SET")) {
        target_properties.put(key,component_properties.get(key))
    }
}

//println target_properties.keySet();

newproperties = new File(options.osf)
newproperties.withWriter { dc ->
    dc.writeLine("\"properties\" : {")
    keys = target_properties.keySet()
    keys.each {
        if (it == keys.last()) {
            dc.writeLine("\"" + it + "\" : \"" + target_properties.get(it) + "\"")
        } else {
            dc.writeLine("\"" + it + "\" : \"" + target_properties.get(it) + "\",")
        }
    }
    dc.writeLine("}")
}

