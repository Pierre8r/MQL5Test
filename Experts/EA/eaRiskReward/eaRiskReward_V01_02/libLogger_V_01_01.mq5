//+------------------------------------------------------------------+
//|                                                    libLogger.mq4 |
//|                                   Copyright 2015, Pierre Rougier |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright 2015, Pierre Rougier"
#property link      "https://www.mql5.com"
#property version   "1.01"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum LoggerLevel
  {
   DEBUG,
   INFO,
   WARNING,
   ERROR,
   FATAL
  };
//+------------------------------------------------------------------+
//|My function|
//+------------------------------------------------------------------+
void Log(LoggerLevel loggerLevel,string FILE,string FUNCTION,int LINE,string messsage) export
  {
   if(MQLInfoInteger(MQL_TESTER))
     {
      switch(loggerLevel)
        {
         case  DEBUG:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  INFO:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  WARNING:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  ERROR:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            ExpertRemove();
            break;
         case  FATAL:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            ExpertRemove();
            break;
         default:
            break;
        }
     }
   else
     {
      switch(loggerLevel)
        {
         case  DEBUG:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  INFO:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  WARNING:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  ERROR:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            break;
         case  FATAL:
            Print(EnumToString(loggerLevel)+" - "+FILE+" - "+FUNCTION+" - "+IntegerToString(LINE)+" - "+messsage);
            ExpertRemove();
            break;
         default:
            break;
        }
     }
  }
//+------------------------------------------------------------------+
