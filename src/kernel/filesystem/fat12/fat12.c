#include "fsinfo.c"
#include "../../stdlib/cout/stdout.c"
#include "../../stdlib/util/cmemory.c"

struct FATBootSector boot_sector;

// reads from the (hopefully) very basic FAT12 file structure
void disk_read(uint32_t lba, uint8_t* buffer, uint8_t count) {
    buffer = NULL;
    return;
}

void list_root_directory() {
    uint8_t buffer[512];
    uint32_t root_dir_sectors = (boot_sector.root_dir_entries * 32) / boot_sector.bytes_per_sector;
    uint32_t root_dir_start = boot_sector.reserved_sectors + (boot_sector.num_fats * boot_sector.sectors_per_fat);

    for (uint32_t i = 0; i < root_dir_sectors; i++) {
        disk_read(root_dir_start + i, buffer, 1);

        struct FATDirEntry* entries = (struct FATDirEntry*)buffer;
        for (unsigned int j = 0; j < boot_sector.bytes_per_sector / sizeof(struct FATDirEntry); j++) {
            if (entries[j].name[0] == 0x00) break;
            if ((unsigned char)entries[j].name[0] == 0xE5) continue;

            char name[12];
            memcpy(name, entries[j].name, 11);
            name[11] = '\0';
            terminal_writestring(name);
            terminal_writestring("\n");
        }
    }
}