/* prog6.c -- lab exercise 6, exercise 5.16 on p. 161. Takes amount of time taken to cover a certain distance and displays that in several ways.*/
#include <stdio.h>
const int S_PER_M = 60;		//Seconds per minute.
const int S_PER_H = 3600;	//Seconds per hour.
const double M_PER_K = 0.62137; //Miles per kilometer.

int main(void)
{
	double distk, distm;	//Distance run in km and in miles.
	double rate; 		//Average speed in mph.
	int min, sec; 		//Minutes and seconds of running time;
	int time;		//Running time in seconds.
	double mtime;		//Time in seconds for one mile
	int mmin, msec;		//Minutes and esconds for one mile.

	printf("This program converts your time for a metric rate\n");
	printf("to a time for running a mile and to your average\n");
	printf("speed in miles per hour.\n");

	printf("Please enter, in kilometers, the distance run.\n");
	scanf("%lf", &distk);
	printf("Next enter your time in minutes and seconds.\n");
	printf("Start by entering the minutes taken.\n");
	scanf("%d", &min);
	printf("And also the seconds taken.\n");
	scanf("%d", &sec);

	//Converts time to seconds
	time = S_PER_M * min + sec;
	//converts kilometers to miles
	distm = M_PER_K * distk;
	//Miles per second * sec per hour = mph
	rate = (distm/time) * S_PER_H;
	//time/distance = time per mile
	mtime = time/distm;	//seconds per mile
	mmin = mtime / S_PER_M;	//
	msec = mtime / S_PER_M;

	printf("You ran %1.2f km in (%1.2f miles) in %d min, %d sec.\n", distk, distm, min, sec);
	printf("That pace corresponds to running a mile in %d min, %d sec.\n", mmin, msec);
	printf("Your average speed was %1.2f mph.\n", rate);

	return 0;
}
