// Quick sketch to log brain data to a CSV
// Untested!
// Based on https://github.com/kitschpatrol/BrainGrapher
// Expects data from https://github.com/kitschpatrol/Brain
// Eric Mika Spring 2018

import processing.serial.*;

Serial serial;
Table table;
int packetCount = 0;

void setup() {
  // Set up serial connection
  println("Find your Arduino in the list below, note its [index]:\n");

  for (int i = 0; i < Serial.list().length; i++) {
    println("[" + i + "] " + Serial.list()[i]);
  }

  // Put the index found above here:
  serial = new Serial(this, Serial.list()[0], 9600);

  serial.bufferUntil(10);

  // Set up CSV Table
  table = new Table();

  table.addColumn("Time");
  table.addColumn("Signal Quality");
  table.addColumn("Attention");
  table.addColumn("Meditation");
  table.addColumn("Delta");
  table.addColumn("Theta");
  table.addColumn("Low Alpha");
  table.addColumn("High Alpha");
  table.addColumn("Low Beta");
  table.addColumn("High Beta");  
  table.addColumn("Low Gamma");
  table.addColumn("High Gamma");
}

void draw() {
  // Nothing to do here
}

void serialEvent(Serial p) {
  // Split incoming packet on commas
  // See https://github.com/kitschpatrol/Arduino-Brain-Library/blob/master/README for information on the CSV packet format

  String incomingString = p.readString().trim();  
  String[] incomingValues = split(incomingString, ',');

  // Verify that the packet looks legit
  if (incomingValues.length > 1) {
    packetCount++;

    // Wait till the third packet or so to start recording to avoid initialization garbage.
    if (packetCount > 3) {

      // Create the CSV row
      TableRow newRow = table.addRow();

      // Set the time
      newRow.setInt(0, millis());

      for (int i = 0; i < incomingValues.length; i++) {
        String stringValue = incomingValues[i].trim();

        int newValue = Integer.parseInt(stringValue);

        // Zero the EEG power values if we don't have a signal.
        // Can be useful to leave them in for development.
        if ((Integer.parseInt(incomingValues[0]) == 200) && (i > 2)) {
          newValue = 0;
        }

        // Add the brain data value to the row
        // Index should skip column 0, since the time is in that column
        newRow.setInt(i + 1, newValue);
      }

      // Save the table every time new data is received
      // This might get slow
      // Use a dynamic file name to avoid overwriting past data
      saveTable(table, "data/brain.csv");
    }
  }
}


// Utilities

// Extend Processing's built-in map() function to support the Long datatype
long mapLong(long x, long in_min, long in_max, long out_min, long out_max) { 
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

// Extend Processing's built-in constrain() function to support the Long datatype
long constrainLong(long value, long min_value, long max_value) {
  if (value > max_value) return max_value;
  if (value < min_value) return min_value;
  return value;
}