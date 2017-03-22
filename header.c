void (*ptr)(void);

void * run (void * fun) {
  ptr = fun;
  ptr();
  return fun;
}
