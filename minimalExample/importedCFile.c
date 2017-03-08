#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/** variable from mainCode **/			
extern int *n;			

/** function from mainCode **/
extern int *getVector(int n);

int *aVector;

/**
 * An example using the extern function and variable
 **/
void anExample(void) {
	int x = n[0];

	aVector = (int *) getVector(x);
	aVector[0] = x;
	printf("From mainCode I got %d\n", aVector[0] );
}