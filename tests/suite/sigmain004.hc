#include "../scampRec.hh"
#include "active.hh"

void readEntry(aMap m, lpn_t pn){
  aLApprox a;
  a = m<:pn:>; 
  sfprintf(sfstdout, "ReadEntry:\n");
  sfprintf(sfstdout, "\tThe value for (%d)%d-%d is: ", 
                     pn.npa, pn.nxx, pn.line);
  sfprintf(sfstdout, "in: %d, out: %d, jumble: %d.\n", 
                     a.inA, a.out, a.jumble);
}

void writeEntry(aMap m, lpn_t pn){
  aLApprox a;
  a = m<:pn:>; 
  a.inA -= 1; a.out -= 1; a.jumble-= 1;

  m<:pn:> = a;
  a = m<:pn:>;

  sfprintf(sfstdout, "writeEntry:\n");
  sfprintf(sfstdout, "\tThe value for (%d)%d-%d is:", pn.npa, pn.nxx, pn.line);
  sfprintf(sfstdout, "in: %d, out: %d, jumble: %d.\n", a.inA, a.out, a.jumble);

  a.inA += 1; a.out += 1; a.jumble += 1;
  m<:pn:> = a; // Restore the map to its original state.

}


void chConstMap(aMap m, char * name, lpn_t pn){
  sfprintf(sfstdout, "%s map:\n", name);
  if (m == NULL) {
     sfprintf(sfstdout, "%s is NULL.\n", name);
  } else {
     readEntry(m,pn);
  }
}

void chMap(aMap m, char * name, lpn_t pn){
  sfprintf(sfstdout, "%s map:\n", name);
  if (m == NULL) {
     sfprintf(sfstdout, "%s is NULL.\n", name);
  } else {
     readEntry(m,pn);
     writeEntry(m,pn);
  }
}


int sig_main(const  aMap first default 0 <f:>,
                    aMap second default 0 <s:>,
             const  aMap third <t:>,
                    aMap fourth <u:>,
             new    aMap fifth <v:>,
             exists aMap sixth <w:>,
             exists const aMap seventh <x:>){

  lpn_t pn;
  pn.npa = 973;
  pn.nxx = 360;
  pn.line = 8077;

  chConstMap(first,"first", pn); 
  chMap(second,"second", pn); 
  chMap(second,"second", pn); 
  chConstMap(third,"third", pn); 
  chMap(fourth,"fourth", pn); 
  chMap(fifth,"fifth", pn); 
  chMap(sixth,"sixth", pn); 
  chConstMap(seventh,"seventh", pn); 
}











