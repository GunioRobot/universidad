#include <errno.h>
#include <stdio.h>
#include <stdio.h>
#include <sys/file.h>

#define UNEXISTING_FILE "/kill_all_humans"

int main ()
{
	int file_descriptor;
	
	file_descriptor = open(UNEXISTING_FILE, O_RDONLY);
	if (file_descriptor == -1)
	{
		printf("errno = %d\n", errno);
		perror("main");
	}

	if ((file_descriptor = open(UNEXISTING_FILE, O_WRONLY)) == -1)
	{
		printf("errno = %d\n", errno);
		perror("main");
	}
	
	return 0;
}