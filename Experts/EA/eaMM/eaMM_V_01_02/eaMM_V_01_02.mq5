//+------------------------------------------------------------------+
//|                                                 eaMM_V_01_02.mq5 |
//|                                   Copyright 2017, Pierre Rougier |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Pierre Rougier"
#property link      "https://www.mql5.com"
#property version   "1.02"

extern int exStopLossInPips=10;
bool isOpenedOrderPreviously=false;

int m_MagicNumber=2015;

//--- Define some MQL5 Structures we will use for our trade
MqlTick latest_price;      // To be used for getting recent/latest price quotes
MqlTradeRequest mrequest;  // To be used for sending our trade requests
MqlTradeResult mresult;    // To be used to get our trade results
MqlRates mrate[];          // To be used to store the prices, volumes and spread of each bar

int STP,TKP;   // To be used for Stop Loss & Take Profit values
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//   ZeroMemory(mrequest);      // Initialization of mrequest structure

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   MqlTick last_tick;
   MqlDateTime last_datetime;
   double NumberOfLotsToOpen;
   double StopLoss=1.13052;

   datetime OpenFirstOrderAtThisDateTime=D'2017.10.19 17:01:00';

   if(SymbolInfoTick(Symbol(),last_tick))
     {
      if(!isOpenedOrderPreviously)
        {
         if((last_tick.time==OpenFirstOrderAtThisDateTime))
           {
            PrintFormat("DEBUG",__FILE__,__FUNCTION__,__LINE__,
                        " Ask :",last_tick.ask," Bid :",last_tick.bid," TimeSeconds :");
            PrintFormat("DEBUG",__FILE__,__FUNCTION__,__LINE__,
                        " Digits ",Digits()," Point ",Point());

            NumberOfLotsToOpen=1;
            OpenBuy(NumberOfLotsToOpen,StopLoss);
            isOpenedOrderPreviously=true;
           }
        }
     }
   else
     {
      PrintFormat("ERROR",__FILE__,__FUNCTION__,__LINE__,GetLastError());
     }

  }
//+------------------------------------------------------------------+
void OpenBuy(const double &NumberOfLotsToOpen,const double &StopLoss)
  {

   ZeroMemory(mrequest);
   mrequest.action = TRADE_ACTION_DEAL;                                  // immediate order execution
   mrequest.price = NormalizeDouble(latest_price.ask,_Digits);           // latest ask price
   mrequest.sl = NormalizeDouble(latest_price.ask - STP*_Point,_Digits); // Stop Loss
   mrequest.tp = NormalizeDouble(latest_price.ask + TKP*_Point,_Digits); // Take Profit
   mrequest.symbol = _Symbol;                                            // currency pair
   mrequest.volume=NumberOfLotsToOpen;                                                 // number of lots to trade
   mrequest.magic=m_MagicNumber;                                         // Order Magic Number
   mrequest.type = ORDER_TYPE_BUY;                                       // Buy Order
   mrequest.type_filling = ORDER_FILLING_FOK;                            // Order execution type
   mrequest.deviation=100;                                               // Deviation from current price
//--- send order
   OrderSend(mrequest,mresult);
// get the result code
   if(mresult.retcode==10009 || mresult.retcode==10008) //Request is completed or order placed
     {
      Alert("A Buy order has been successfully placed with Ticket#:",mresult.order,"!!");
     }
   else
     {
      Alert("The Buy order request could not be completed -error:",GetLastError());
      ResetLastError();
      return;
     }
  }
//+------------------------------------------------------------------+
