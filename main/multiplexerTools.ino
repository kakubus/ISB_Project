/*------------------------------------
   Useful functions for Multiplexer
  Jakub Kaniowski, Szymon Ciemała 2020
              25.10.2020
  ------------------------------------

*/
/*        Truth table CD4076BE
      -----------------------------
      A     B     C     D     ChNum
      -----------------------------
      0     0     0     0   |   0
      1     0     0     0   |   1
      0     1     0     0   |   2
      1     1     0     0   |   3
      0     0     1     0   |   4
      1     0     1     0   |   5
      0     1     1     0   |   6
      1     1     1     0   |   7
      0     0     0     1   |   8  Nadane ograniczenie 3 bitowe!
      1     0     0     1   |   9
      0     1     0     1   |   10
      1     1     0     1   |   11
      0     0     1     1   |   12
      1     0     1     1   |   13
      0     1     1     1   |   14
      1     1     1     1   |   15
*/



/*----------------------------------*/
/*        CONFIG MULTIPLEXER        */
/*----------------------------------*/
/* A, B, C, D - controler table for */
/* multiplexer. Logical table.      */
/*                                  */
/* READ_MULT_PIN - pin for reading  */
/* WRIT_MULT_PIN - pin for write    */
/*----------------------------------*/
