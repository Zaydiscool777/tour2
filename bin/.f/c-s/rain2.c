#include <ncurses.h> // gcc: -lncurses -ltinfo
#include <stdlib.h> // rand()
#include <unistd.h> // sleep()
// tcc rain2.c -lncurses -ltinfo -run
// this program uses a queue!

// keep track of raindrops
struct point {
	int x;
	int y;
} point;

int width, height; void init(); void draw();
#define MAXDROPS 80
#define EVAP 25
int* pools = NULL;

int main()
{
	initscr();
	nodelay(stdscr, TRUE);
	getmaxyx(stdscr, height, width);
	pools = calloc(width+2, sizeof(int));
	cbreak();
	noecho();
	init();
	while(getch() != 'q')
	{
		draw();
		usleep(25000);
	}
	endwin();
	if(pools != NULL){free(pools);}
	return 0;
}

int len; struct point drops[MAXDROPS];
// dsa methods of drops[]
int push(struct point x)
{
	if(len >= MAXDROPS)
	{
		return 1;
	}
	drops[len] = x;
	len++;
	return 0;

}
struct point look()
{
	return drops[0];
}
void pop()
{
	for(int i = 1; i < len; i++)
	{
		drops[i - 1] = drops[i];
	}
	len--;
}

// actual thing

void init()
{
	if(has_colors())
	{
		start_color();
		if(can_change_color())
		{
			init_color(COLOR_BLUE, 250, 500, 750);
			init_color(COLOR_BLACK, 100, 100, 100);
		}
		init_pair(1, COLOR_BLUE, COLOR_BLACK);
		init_pair(3, COLOR_WHITE, COLOR_BLACK);
	}
	for(int i = 0; i < 3; i++)
	{
		for(int j = 0; j < width; j++)
		{
			if(rand() % 2)
			{
				move(i, j);
				addch('@' | ((rand()%10)?0:A_REVERSE) );
			}
		}
	}
	if(has_colors())
	{
		attron(COLOR_PAIR(1));
	}
}

void draw()
{
	for(int i = 0; i < len; i++){
		drops[i].y++;
	}
	while(look().y == height){
		pop();
	}
	for(int i = 0; i < width; i++)
	{
		if(!(rand() % 200))
		{
			point.x = i;
			point.y = 3;
			push(point);
		}
		move(height - 1, i);
		if(pools[i+1] == 0){
			addch(' ');
		}
		else
		{
			pools[i+1]--;
			addch(' ' | A_UNDERLINE);
		}
	}
	for(int i = 0; i < len; i++)
	{
		move(drops[i].y - 1, drops[i].x);
		if(drops[i].y != 3)
		{
			addch(' ');
		}
		move(drops[i].y, drops[i].x);
		if(drops[i].y == height - 1)
		{
			addch('*' | A_UNDERLINE);
			pools[drops[i].x+1] = EVAP;
			pools[drops[i].x-1+1] = EVAP/2;
			pools[drops[i].x+1+1] = EVAP/2;
		}
		else
		{
			addch('|');
		}
	}
	move(0, 0);
	printw("q to quit\nor ^c");
	addch(33 + rand() % 30);
}

