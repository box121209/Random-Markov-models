/*

Compile with:
R CMD SHLIB ./rmm.c

In the R session, load the binary with:
dyn.load("rmm.so")

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void text_convert(
  /* input: */
  char** str,
  int* len,
  /* output: */
  int* num,
  int* cnt
  ){
    int i, c;
    int ws=0;
    *cnt = 0;
    for(i=0; i<*len; i++)
    { 
      c = (*str)[i];
      if(c == 32 && ws == 0){ ws = 1; goto space; }
      if(c<65 || (c>90 && c<97) || c>122) continue;
      ws = 0;
      c |= 32;
      c -= 96;
      num[(*cnt)++] = c;
      continue;
    space: 
      num[(*cnt)++] = 27;
    }
}

void rmm_train(
	       /* input: */
	       int* T,
	       int* nstates,
	       int* nvalues,
	       int* nmodels,
	       int* dat,
	       int* hash,
	       /* output: */
	       double* emission
	       ){
  /* state variable: */
  int s; 
  /* model and time indices: */
  int m,t;
  /* optimisation variables: */
  double d;
  int i, dns, dnsm, mnsnv;
  int ns = *nstates;
  int nv = *nvalues;
  int nsnv = ns*nv;

  srand(time(NULL));
  /* loop over the models: */
  for(m=0; m < *nmodels; m++){
    /* process first observation point: */
    s = rand()%ns;
    mnsnv = m*nsnv;
    dns = dat[0]*ns;
    ++emission[ mnsnv +  dns + s ];
    /* run though remaining observations incrementing emission counts: */
    for(t=1; t < *T; t++){
      dns = dat[t]*ns;
      dnsm = dat[t-1]*ns;
      s = hash[ mnsnv +  dnsm + s ];
      ++emission[ mnsnv +  dns + s ];
    }
    /* normalise each row of the emission matrix: */
    for(s=0; s < *nstates; s++){
      d = 0.0; 
      for(i=mnsnv+s; i<mnsnv+nsnv+s; i += ns) d += emission[i];
      /* if nonzero count, divide the row: */
      if(d > 0.0) 
	for(i=mnsnv+s; i<mnsnv+nsnv+s; i += ns) 
	  emission[i] = emission[i]/d;
    }
  }
}

void rmm_test(
	      /* input: */
	      int* T, 
	      int* nstates,
	      int* nvalues,
	      int* nmodels,
	      int* dat,
	      int* hash,
	      double* emission,
	      /* output: */
	      double* post,
	      double* score
	      ){
  /* state variable: */
  int* s; 
  /* model and time indices: */
  int m,t;
  /* optimisation variables: */
  int dns, dnsm, mnsv;
  int ns = *nstates;
  int nv = *nvalues;
  int nsv = ns*nv;

  /* current state across the ensemble: */
  s = malloc( *nmodels * sizeof(s) );

  /* initialise: */
  for(m=0; m < *nmodels; m++){
    s[m] = rand()%ns;  // <---- CHANGED FROM s[m]=0;
    dns = dat[0]*ns;
    post[0] += emission[ m*nsv +  dns + s[m] ];
  }
  post[0] /= *nmodels;
  if(post[0]>0.0) *score = log(post[0]);

  /* main loop: */
  for(t=1; t < *T; t++){
    dnsm = dat[t-1]*ns;
    dns =  dat[t]*ns;
    for(m=0, mnsv=0; m<*nmodels; m++, mnsv += nsv){
      s[m] = hash[ mnsv +  dnsm + s[m] ];
      post[t] += emission[ mnsv + dns + s[m] ];
    }
    post[t] /= *nmodels;
    if(post[t]>0.0) *score += log(post[t]);
  }

  /* clean up: */
  free(s);
}
