#include <mach/mach.h>
#include <unistd.h>
#include <stdio.h>

struct ram {
  host_t host;
  mach_msg_type_number_t count;
  vm_statistics64_data_t vm_stat;
  vm_size_t page_size;

  int load; // Percentage
};

static inline void ram_init(struct ram* ram) {
  ram->host = mach_host_self();
  ram->count = HOST_VM_INFO64_COUNT;
  host_page_size(ram->host, &ram->page_size);
}

static inline void ram_update(struct ram* ram) {
  kern_return_t error = host_statistics64(ram->host,
                                          HOST_VM_INFO64,
                                          (host_info64_t)&ram->vm_stat,
                                          &ram->count);

  if (error != KERN_SUCCESS) {
    printf("Error: Could not read ram host statistics.\n");
    return;
  }

  uint64_t total_pages = 0; 
  // We don't have total_pages directly from vm_stat, usually assume total physical ram.
  // But we can calculate used/free pages relations.
  // Or use sysctl hw.memsize for total. 

  // However, simple "memory pressure" or usage % is:
  // (Active + Wired + Compressed) / Total? 
  // Free = free + speculative. 
  
  // Let's rely on Free Pages vs Total logic or just Wired + Active + Inactive + Speculative + Compressed?
  // Total RAM is constant, we can get it via sysctl or just sum up all pages if we assume they represent total... 
  // Actually sum of (free + active + inactive + wired + speculative + compressor) is roughly total pages?
  
  // Let's use the definition:
  // Used = App Memory + Wired Memory + Compressed
  // App Memory = Anonymous + Purgeable ?? 
  
  // A simpler metric often used in bars:
  // Used = (Total - Free - Inactive)? Or just (Active + Wired)?
  
  // Let's stick to a common formula:
  // used = active + wired + compressed
  // But we need total to calc %.
  
  // Let's use sysctl to get total ram.
  // Actually, we can just look at "free" vs "used". 
  
  // Implementation note:
  // Let's try to get physical memory size.
  
  // For now, let's just calculate "Used Pages" vs "Available Pages" if possible, 
  // OR just assume (Active + Wired) is "Used". 
  
  // Better approach:
  // Total = free + active + inactive + wired + speculative + compressor_occupied?
  
  vm_statistics64_data_t vm = ram->vm_stat;
  
  // uint64_t total = vm.free_count + vm.active_count + vm.inactive_count + vm.wire_count + vm.speculative_count + vm.compressor_page_count;
  // This sum isn't always exact because of how pages are counted (e.g. purging etc), but close enough for bar.
  
  // "App Memory" ≈ (started internal? pageable_internal + purgeable?)
  // "Wired" = wire_count
  // "Compressed" = compressor_page_count
  
  // Let's use: Used = Active + Wired + Compressed
  // Total = Used + Free + Inactive + Speculative
  
  double total = (double)(vm.active_count + vm.wire_count + vm.compressor_page_count + vm.free_count + vm.inactive_count + vm.speculative_count);
  double used = (double)(vm.active_count + vm.wire_count + vm.compressor_page_count);
  
  ram->load = (int)((used / total) * 100.0);
}
