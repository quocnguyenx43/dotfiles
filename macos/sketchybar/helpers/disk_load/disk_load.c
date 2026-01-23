#include "disk.h"
#include "../sketchybar.h"
#include <unistd.h>
#include <stdlib.h>

int main (int argc, char** argv) {
  float update_freq;
  // Usage: disk_load <event_name> <freq>
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    printf("Usage: %s \"<event-name>\" \"<event_freq>\"\n", argv[0]);
    exit(1);
  }

  alarm(0);
  struct disk_usage usage;

  // Setup the event in sketchybar
  char event_message[512];
  snprintf(event_message, 512, "--add event '%s'", argv[1]);
  sketchybar(event_message);

  char trigger_message[512];
  for (;;) {
    disk_query(&usage);

    // Prepare the event message
    // Parameters:
    // $1 = event name
    // total_bytes
    // free_bytes
    // used_bytes
    // percentage
    
    // We pass bytes as raw strings? 
    // snprintf format for uint64_t is %llu
    
    snprintf(trigger_message,
             512,
             "--trigger '%s' total='%llu' free='%llu' used='%llu' percentage='%d'",
             argv[1],
             usage.total_bytes,
             usage.free_bytes,
             usage.used_bytes,
             usage.percentage);

    // Trigger the event
    sketchybar(trigger_message);

    // Wait
    usleep(update_freq * 1000000);
  }
  return 0;
}
