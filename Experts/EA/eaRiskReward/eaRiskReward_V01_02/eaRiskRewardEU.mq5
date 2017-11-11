//+------------------------------------------------------------------+
//|                                           eaRiskRewardEURUSD.mq5 |
//|                                   Copyright 2017, Pierre Rougier |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Pierre Rougier"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "CeaRiskReward.mqh"

int _MagicNumber=2015;
extern int exTakeProfitInPips=100;
extern int exStopLossInPips=100;
double _NumberOfLotsToOpen=1;
datetime _Durationrr=D'2017.10.17 17:01:00';

//+------------------------------------------------------------------+
//| Global expert object                                             |
//+------------------------------------------------------------------+
CeaRiskReward eaRiskReward;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
//--- Initializing expert
   if(!eaRiskReward.OnInit(_MagicNumber,exTakeProfitInPips,exStopLossInPips,_NumberOfLotsToOpen,_OpenFirstOrderAtThisDateTime))
     {
      //--- failed
      Log(FATAL,__FILE__,__FUNCTION__,__LINE__,": error initializing expert");
      eaRiskReward.OnDeinit();
      return(INIT_FAILED);
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   eaRiskReward.OnDeinit();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   eaRiskReward.OnTick();
  }
//+------------------------------------------------------------------+
