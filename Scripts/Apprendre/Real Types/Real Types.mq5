//+------------------------------------------------------------------+
//|                                                   Real Types.mq5 |
//|                                   Copyright 2017, Pierre Rougier |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Pierre Rougier"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   double c1=1.12123515e-25;
   double c2=0.000000000000000000000000112123515; // 24 zero after the decimal point 

   Print("1. c1 =",DoubleToString(c1,16));
// Result: 1. c1 = 0.0000000000000000 

   Print("2. c1 =",DoubleToString(c1,-16));
// Result: 2. c1 = 1.1212351499999999e-025 

   Print("3. c2 =",DoubleToString(c2,-16));
// Result: 3. c2 = 1.1212351499999999e-025
  }
//+------------------------------------------------------------------+
