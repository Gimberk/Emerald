#include "filesystem/fat12/fat12.c"

void kernel_main(uint32_t disk_img_start, uint32_t disk_size) {
	terminal_initialize();

	terminal_setcolor(VGA_COLOR_CYAN);
	terminal_writestring("Hello, kernel World!\n");
	terminal_writestring("\nReading Disk...\n");

	char disk_str[12];
	int size = 54324;

	int i = 0;
	if (size == 0){
		disk_str[i++] = '0';
	}
	else {
		while (size > 0){
			disk_str[i++] = '0' + (size%10);
			size /= 10;
		}
	}
	disk_str[i] = '\0'; // terminating char

	for (size_t j = 0, k = i - 1; j < k; j++, k--){
		char temp = disk_str[j];
		disk_str[j] = disk_str[k];
		disk_str[k] = temp;
	}

	terminal_writestring("Disk image size: ");
	terminal_writestring(disk_str);
	terminal_writestring(" bytes\n");

	terminal_writestring("\nDone!");
}