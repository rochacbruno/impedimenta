/* prog10.c -- Jeremy Audet, Thu Oct  1 16:20:10 EDT 2009 */
/* programming exercise 11, page 269, chapter 7 review */
/*
ask for input;
total input;
print output;
-----------------------------
present user with menu and prompt for input;
scan for input;
while input is not 'q',
	if 'a' is input,
		switch to case 'a';
		ask user how many pounds of artichokes they wish to order;
		scan for input;
		record how many pounds of artichokes were sold(overwrite old value, if any);
		break;
	if b is input,
		switch to case 'b';
		ask user how many pounds of beets they wish to order;
		scan for input;
		record how many pounds of beets were sold(overwrite old value, if any);
		break;
	if c is input,
		switch to case 'c';
		ask user how many pounds of carrots they wish to order;
		scan for input;
		record how many pounds of beets were sold(overwrite old value, if any);
		break;
	if other value is input,
		switch to case default;
		remind user that input value is not valid;
	present user with menu and prompt for input;
	flush input buffer;
	scan for input;
	repeat;

find total cost of artichokes;					// Calculate gross_cost
find total cost of beets;
find total cost of carrots;
gross cost = acost + bcost + ccost;				// acost is cost of artichokes, etc

find total pounds of product sold, and store that value;	// Calculate shipping
if total pounds of product sold is = 0,
	set shipping to $0.00;
else if total pounds of product sold is <= 5, 
	set shipping to $3.50;
else if total pounds of product sold is <= 20,
	set shipping to $10.00;
else
	set shipping to $8.00 + ( 0.10 * pounds sold);

if gross cost >= $100						// Calculate discount (discount is already initialized as 0)
	discount = gross cost * 0.05;
net cost = gross cost - discount + shipping;			// Calculate net_cost (Grand Total)

print out results!						// This step is easy!

NOTE: net_cost is rather superflous.
The only time it is ever used in the program is when a) reading a value into the variable, and b) printing out the net cost.
I could easily calculate the net cost of the order as part of the last printf() statement.
However, putting making a variable called net_cost makes the program more extensible and easier to modify in the future.
For example, if I ever decided to turn this program into a function and call it in another program, net_cost could easily be a return value of this function.
Also, making a variable called net_cost makes the program a little bit more... readable, I guess.
If efficency is a real priority, though, I'd get rid of net_cost and calculate it as part of the last printf() statement.
*/


#include <stdio.h>

int main(void)
{
	const float ARATE = 1.25;			// $cost/pound of artichokes
	const float BRATE = 0.65;
	const float CRATE = 0.89;

	char ch;					// Used for menu selections
	int pounds = 0;					// Total pounds of all veggies
	int a = 0, b = 0, c = 0;			// Pounds ordered of each individual veggie
	float gross_cost = 0, net_cost = 0;		// Gross and net cost of order
	float acost = 0, bcost = 0, ccost = 0;		// Total cost of artichokes, beets, and carrots
	float discount = 0, shipping = 0;		// The possible discount starts at 0, and so does shipping costs

	printf("**********************************************************************\n");
	printf("Enter a letter to modify your order of the corresponding veggie.\n");
	printf("a) Artichokes	b) Beets	c) Carrots	q) Quit (place order)\n");
	printf("Current order:\n");
	printf("Artichokes: %d	Beets: %d	Carrots: %d\n", a, b, c);
	printf("**********************************************************************\n");
	while((ch = getchar()) != 'q')
	{
		switch(ch)
		{
			case 'a':
			{
				printf("How many pounds of artichokes do you wish to order? ($%.2f/pound)\n", ARATE);
				scanf("%d", &a);
				if(a < 0)
				{
					printf("Don't cheat me!\n");
					a = 0;
				}
				break;
			}
			case 'b':
			{
				printf("How many pounds of beets do you wish to order? ($%.2f/pound)\n", BRATE);
				scanf("%d", &b);
				if(b < 0)
				{
					printf("Don't cheat me!\n");
					b = 0;
				}
				break;
			}
			case 'c':
			{
				printf("How many pounds of carrots do you wish to order? ($%.2f/pound)\n", CRATE);
				scanf("%d", &c);
				if(c < 0)
				{
					printf("Don't cheat me!\n");
					c = 0;
				}
				break;
			}
			default:
				printf("Valid input is 'a', 'b', 'c', or 'q'. Please make a selection.\n");
		}
	putchar('\n');
	putchar('\n');
	printf("**********************************************************************\n");
	printf("Enter a letter to modify your order of the corresponding veggie.\n");
	printf("a) Artichokes	b) Beets	c) Carrots	q) Quit (place order)\n");
	printf("Current order:\n");
	printf("Artichokes: %d	Beets: %d	Carrots: %d\n", a, b, c);
	printf("**********************************************************************\n");
	while(getchar() != '\n')
		continue;
	}

	acost = (float) a * ARATE;			// Calculate gross_cost
	bcost = (float) b * BRATE;
	ccost = (float) c * CRATE;
	gross_cost = acost + bcost + ccost;
	pounds = a + b + c;				// Calculate shipping
	if(pounds == 0)
		shipping = 0.00;
	else if(pounds <= 5)
		shipping = 3.50;
	else if(pounds <= 20)
		shipping = 10.00;
	else
		shipping = 8.00 + ((float) pounds * 0.10);
	if(gross_cost >= 100.00)			// Calculate discount
		discount = gross_cost * 0.05;
	net_cost = gross_cost - discount + shipping;	// Calculate Grand Total

	printf("%d pounds of artichokes comes to %.2f\n", a, acost);
	printf("%d pounds of beets comes to %.2f\n", b, bcost);
	printf("%d pounds of carrots comes to %.2f\n", c, ccost);
	printf("Gross Cost: %.2f\n", gross_cost);
	printf("Discount: %.2f\n", discount);
	printf("Shipping: %.2f\n", shipping);
	printf("Grand Total: %.2f\n", net_cost);

	return 0;
}
