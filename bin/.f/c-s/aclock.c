#include <time.h>
#include <math.h> // gcc: -lm
#include <ncurses.h> // gcc: -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -lncurses -ltinfo
#include <stdlib.h>
// tcc -lncurses -ltinfo -run aclock.c
// gcc aclock.c -lm -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -lncurses -ltinfo && ./a.out

int width, length;
int size; float fonth = 1.5;

time_t rawtime; struct tm* now;

int cx, cy;
void show(int m, double s) // took a lot of time to find that it should be double s instead of int.
{
	cx = floor(sin(m * 2 * M_PI / 60) * size * s * fonth + size * fonth);
	cy = floor(-cos(m * 2 * M_PI / 60) * size * s + size);
}

void init()
{
	printw("q to quit\nor ^c");
	// when i can, make the '.' ring on it's own screen
}

void draw()
{
	show(0, 1.0);
	move(cy, cx);
	addch('*' | A_BOLD | A_UNDERLINE);
	for(int i = 1; i < 60; i++){ //i could make it a float i = 0.0, and inc by tau/60...
		show(i, 1.0);
		move(cy, cx);
		addch('.'); //(char)(i + 33)
	}
	time(&rawtime); now = localtime(&rawtime);
	show((now->tm_hour-1)*5/2, 0.5);
	move(cy, cx);
	addch(' ');
	show(now->tm_hour*5/2, 0.5);
	move(cy, cx);
	addch('H' | A_REVERSE);
	show(now->tm_min, 1.0);
	move(cy, cx);
	addch('M');
	show(now->tm_sec, 1.0);
	move(cy, cx);
	addch('S' | A_DIM);
	move(size, fonth * (size-3));
	printw("%02d:%02d:%02d", now->tm_hour, now->tm_min, now->tm_sec);
}

int main()
{

	initscr();
	nodelay(stdscr, TRUE);
	size = 24;
	getmaxyx(stdscr, length, width);
	size = width < length ? width/2 : length/2; //24 by default
	
	cbreak(); // don't have to press enter to quit
	noecho(); // not show things typed
	init();
	while(getch() != 'q')
	{
		draw();
	}
	endwin();
	return 0;
}

