#include <sys/statvfs.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

struct disk_usage {
  uint64_t total_bytes;
  uint64_t free_bytes;
  uint64_t used_bytes;
  int percentage;
};

static inline void disk_query(struct disk_usage* usage) {
    struct statvfs stat;
    if (statvfs("/", &stat) != 0) {
        // Error handling
        usage->total_bytes = 0;
        usage->free_bytes = 0;
        return;
    }

    // f_frsize is fragment size (block size)
    // f_blocks is total blocks
    // f_bavail is free blocks for unprivileged users (available)
    
    usage->total_bytes = (uint64_t)stat.f_blocks * stat.f_frsize;
    usage->free_bytes = (uint64_t)stat.f_bavail * stat.f_frsize;
    usage->used_bytes = usage->total_bytes - usage->free_bytes;
    
    if (usage->total_bytes > 0) {
        usage->percentage = (int)((double)usage->used_bytes / (double)usage->total_bytes * 100.0);
    } else {
        usage->percentage = 0;
    }
}
