#include <stdio.h>
void calculatetri(int n);

int main(void)
{
	calculatetri(1);
	calculatetri(2);

	return 0;
}

void calculatetri(int n)
{
	int i;
	int triangle = 0;

	for(i = 0; i <= n; ++i)
		triangle +=i;
	printf("Triangle number %i is %i\n", n, triangle);
}
